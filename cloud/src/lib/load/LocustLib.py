# -*- coding: utf-8 -*-
import inspect
import logging
import os
import signal
import socket
import sys
import time
import six
from optparse import OptionParser

import gevent

from locust import events, runners, web
from locust.core import HttpLocust, Locust
from locust.inspectlocust import get_task_ratio_dict, print_task_ratio
from locust.log import console_logger, setup_logging
from locust.runners import LocalLocustRunner, MasterLocustRunner, SlaveLocustRunner
from locust.stats import (print_error_report, print_percentile_stats, print_stats,
                    stats_printer, stats_writer, write_stat_csvs, global_stats)

_internals = [Locust, HttpLocust]

class Option:
    """
    Init Global variables with default values.
    """
    locustfile = 'locustfile'
    csvfilebase = 'locust'
    master_host = '127.0.0.1'
    no_reset_stats = False
    no_web = True 
    master_bind_port = 5557
    port = 8089
    num_requests= 10
    show_version= False
    expect_slaves = 1 
    master = False
    show_task_ratio = False
    show_task_ratio_json = False
    list_commands = False
    web_host = ''
    hatch_rate = 10 
    slave = False
    only_summary = False
    host = None
    master_port = 5557
    logfile = None
    num_clients = 100 
    loglevel = 'INFO'
    master_bind_host = '*' 
    print_stats = True
 
class LocustLib(Option):
    def _is_package(path):
        """
        Is the given path a Python package?
        """
        return (
            os.path.isdir(path)
            and os.path.exists(os.path.join(path, '__init__.py'))
        )
    
    
    def find_locustfile(self, locustfile):
        """
        Attempt to locate a locustfile, either explicitly or by searching parent dirs.
        """
        # Obtain env value
        names = [locustfile]
        # Create .py version if necessary
        if not names[0].endswith('.py'):
            names += [names[0] + '.py']
        # Does the name contain path elements?
        if os.path.dirname(names[0]):
            # If so, expand home-directory markers and test for existence
            for name in names:
                expanded = os.path.expanduser(name)
                if os.path.exists(expanded):
                    if name.endswith('.py') or _is_package(expanded):
                        return os.path.abspath(expanded)
        else:
            # Otherwise, start in cwd and work downwards towards filesystem root
            path = os.path.abspath('.')
            while True:
                for name in names:
                    joined = os.path.join(path, name)
                    if os.path.exists(joined):
                        if name.endswith('.py') or _is_package(joined):
                            return os.path.abspath(joined)
                parent_path = os.path.dirname(path)
                if parent_path == path:
                    # we've reached the root path which has been checked this iteration
                    break
                path = parent_path
        # Implicit 'return None' if nothing was found
    
    
    def is_locust(self, tup):
        """
        Takes (name, object) tuple, returns True if it's a public Locust subclass.
        """
        name, item = tup
        return bool(
            inspect.isclass(item)
            and issubclass(item, Locust)
            and hasattr(item, "task_set")
            and getattr(item, "task_set")
            and not name.startswith('_')
        )
    
    
    def load_locustfile(self, path):
        """
        Import given locustfile path and return (docstring, callables).
    
        Specifically, the locustfile's ``__doc__`` attribute (a string) and a
        dictionary of ``{'name': callable}`` containing all callables which pass
        the "is a Locust" test.
        """
        # Get directory and locustfile name
        directory, locustfile = os.path.split(path)
        # If the directory isn't in the PYTHONPATH, add it so our import will work
        added_to_path = False
        index = None
        if directory not in sys.path:
            sys.path.insert(0, directory)
            added_to_path = True
        # If the directory IS in the PYTHONPATH, move it to the front temporarily,
        # otherwise other locustfiles -- like Locusts's own -- may scoop the intended
        # one.
        else:
            i = sys.path.index(directory)
            if i != 0:
                # Store index for later restoration
                index = i
                # Add to front, then remove from original position
                sys.path.insert(0, directory)
                del sys.path[i + 1]
        # Perform the import (trimming off the .py)
        imported = __import__(os.path.splitext(locustfile)[0])
        # Remove directory from path if we added it ourselves (just to be neat)
        if added_to_path:
            del sys.path[0]
        # Put back in original index if we moved it
        if index is not None:
            sys.path.insert(index + 1, directory)
            del sys.path[0]
        # Return our two-tuple
        locusts = dict(filter(self.is_locust, vars(imported).items()))
        return imported.__doc__, locusts
    

    def startExecution(self, num_clients, hatch_rate, num_requests, csvBase='locust'):
        """
        This function executes locust test.
        """
        arguments = []
        options = Option()
        options.num_clients = int(num_clients)
        options.hatch_rate = int(hatch_rate)
        options.num_requests = int(num_requests)
        options.csvfilebase = str(csvBase)
    
        # setup logging
        setup_logging(options.loglevel, options.logfile)
        logger = logging.getLogger(__name__)
        
        if options.show_version:
            print("Locust %s" % (version,))
            sys.exit(0)
    
        locustfile = self.find_locustfile(options.locustfile)
    
        if not locustfile:
            logger.error("Could not find any locustfile! Ensure file ends in '.py' and see --help for available options.")
            sys.exit(1)
    
        if locustfile == "locust.py":
            logger.error("The locustfile must not be named `locust.py`. Please rename the file and try again.")
            sys.exit(1)
    
        docstring, locusts = self.load_locustfile(locustfile)
    
        if options.list_commands:
            print("Available Locusts:")
            for name in locusts:
                print("    " + name)
            sys.exit(0)
    
        if not locusts:
            logger.error("No Locust class found!")
            sys.exit(1)
    
        # make sure specified Locust exists
        if arguments:
            missing = set(arguments) - set(locusts.keys())
            if missing:
                logger.error("Unknown Locust(s): %s\n" % (", ".join(missing)))
                sys.exit(1)
            else:
                names = set(arguments) & set(locusts.keys())
                locust_classes = [locusts[n] for n in names]
        else:
            # list() call is needed to consume the dict_view object in Python 3
            locust_classes = list(locusts.values())
        
        if options.show_task_ratio:
            print("\n Task ratio per locust class")
            print( "-" * 80)
            print_task_ratio(locust_classes)
            print("\n Total task ratio")
            print("-" * 80)
            print_task_ratio(locust_classes, total=True)
            sys.exit(0)
        if options.show_task_ratio_json:
            from json import dumps
            task_data = {
                "per_class": get_task_ratio_dict(locust_classes), 
                "total": get_task_ratio_dict(locust_classes, total=True)
            }
            print(dumps(task_data))
            sys.exit(0)
    
        if not options.no_web and not options.slave:
            # spawn web greenlet
            logger.info("Starting web monitor at %s:%s" % (options.web_host or "*", options.port))
            main_greenlet = gevent.spawn(web.start, locust_classes, options)
        
        if not options.master and not options.slave:
            runners.locust_runner = LocalLocustRunner(locust_classes, options)
            # spawn client spawning/hatching greenlet
            if options.no_web:
                runners.locust_runner.start_hatching(wait=True)
                main_greenlet = runners.locust_runner.greenlet
        elif options.master:
            runners.locust_runner = MasterLocustRunner(locust_classes, options)
            if options.no_web:
                while len(runners.locust_runner.clients.ready)<options.expect_slaves:
                    logging.info("Waiting for slaves to be ready, %s of %s connected",
                                 len(runners.locust_runner.clients.ready), options.expect_slaves)
                    time.sleep(1)
    
                runners.locust_runner.start_hatching(options.num_clients, options.hatch_rate)
                main_greenlet = runners.locust_runner.greenlet
        elif options.slave:
            try:
                runners.locust_runner = SlaveLocustRunner(locust_classes, options)
                main_greenlet = runners.locust_runner.greenlet
            except socket.error as e:
                logger.error("Failed to connect to the Locust master: %s", e)
                sys.exit(-1)
        
        if not options.only_summary and (options.print_stats or (options.no_web and not options.slave)):
            # spawn stats printing greenlet
            gevent.spawn(stats_printer)
    
        if options.csvfilebase:
            gevent.spawn(stats_writer, options.csvfilebase)
    
        def print_stats(stats):
            """
            This function prints locust test executon data.
            """
            STATS_NAME_WIDTH = 60
            print ((" %-" + str(STATS_NAME_WIDTH) + "s %7s %12s %7s %7s %7s  | %7s %7s") % ('Name', '# reqs', 
                '#fails', 'Avg', 'Min', 'Max', 'Median', 'req/s'))
            print ("-" * (80 + STATS_NAME_WIDTH))
            total_rps = 0
            total_reqs = 0
            total_failures = 0
            for key in sorted(six.iterkeys(stats)):
                r = stats[key]
                total_rps += r.current_rps
                total_reqs += r.num_requests
                total_failures += r.num_failures
                print(r)
            print ("-" * (80 + STATS_NAME_WIDTH))
            try:
                fail_percent = (total_failures/float(total_reqs))*100
            except ZeroDivisionError:
                fail_percent = 0
            print ((" %-" + str(STATS_NAME_WIDTH) + "s %7d %12s %42.2f") % ('Total', total_reqs, "%d(%.2f%%)" %(total_failures, fail_percent), total_rps))
            print ("")


        def print_percentile_stats(stats):
            """
            This function prints locust test executon percentile data.
            """
            STATS_NAME_WIDTH = 60
            print ("Percentage of the requests completed within given times")
            print ((" %-" + str(STATS_NAME_WIDTH) + "s %8s %6s %6s %6s %6s %6s %6s %6s %6s %6s") % ('Name', '# reqs', '50%', '66%', '75%', '80%', '90%', '95%', '98%', '99%', '100%'))
            print ("-" * (80 + STATS_NAME_WIDTH))
            for key in sorted(six.iterkeys(stats)):
                r = stats[key]
                if r.response_times:
                    print (r.percentile())
            print ("-" * (80 + STATS_NAME_WIDTH))
            total_stats = global_stats.aggregated_stats()
            if total_stats.response_times:
                print (total_stats.percentile())
            print ("")

        def print_error_report():
            """
            This function prints locust test executon error data.
            """
            STATS_NAME_WIDTH = 60
            if not len(global_stats.errors):
                return
            print("Error report")
            print(" %-18s %-100s" % ("# occurences", "Error"))
            print("-" * (80 + STATS_NAME_WIDTH))
            for error in six.itervalues(global_stats.errors):
                print(" %-18i %-100s" % (error.occurences, error.to_name()))
            print("-" * (80 + STATS_NAME_WIDTH))
            print("")
            return(error.occurences, error.to_name())

        def shutdown(code=0):
            """
            Shut down locust by firing quitting event, printing/writing stats and exiting
            """
            logger.info("Shutting down (exit code %s), bye." % code)
            events.quitting.fire()
            print_stats(runners.locust_runner.request_stats)
            print_percentile_stats(runners.locust_runner.request_stats)
            if options.csvfilebase:
                write_stat_csvs(options.csvfilebase)
            error = print_error_report()
            return error

        # install SIGTERM handler
        def sig_term_handler():
            logger.info("Got SIGTERM signal")
            self.shutdown(0)
        gevent.signal(signal.SIGTERM, sig_term_handler)
        
        try:
            #logger.info("Starting Locust %s" % version)
            main_greenlet.join()
            code = 0
            if len(runners.locust_runner.errors):
                code = 1
            error = shutdown(code=code)
            if error:
                return (False, error[1])
            else:
                return True
        except KeyboardInterrupt as e:
            shutdown(0)
            return False

