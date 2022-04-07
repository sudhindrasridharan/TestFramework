********************************************************************************
               Sample Test Framework - Robot Framework Ride Install Steps
                                ReadMe.txt
                             Version 0.1
********************************************************************************

1. INTRODUCTION
===============

 -> RIDE is a test data editor for Robot Framework test data.
       Latest developments on RIDE can be found at the official git page - https://github.com/robotframework/RIDE/wiki

2. PREREQUISITES
================

 -> Linux Ubuntu-14.04 or 16.04
 -> System RAM >= 4.0 GB
 -> Python - 3.4.3
 -> Python package management system(pip) should be installed in the system.
 -> Robotframework installed in the system.


3. RIDE INSTALLATION
=======================
 -> Installation of WX Python

    RIDE officially supports wxPython 2.8.12.1 and 3.0.2. But none support python3.Hence it is recommended to run Ride from python 2.7 and robotframework from Python 3.5.2.

     - Installation Using PIP
       - python2.7 -m pip install wxpython

 -> Installation of robotframework RIDE

    Please use the ride version 1.5.2.1 as it is the most stable release till date.

    - python2.7 -m pip install robotframework-ride==1.5.2.1

4. Launching RIDE
=================
 Ride is started from command line with command ride.py.Please refer the getting started guide at the link  below for usage instructions:
  - https://github.com/robotframework/RIDE/wiki/How-To#starting-ride
