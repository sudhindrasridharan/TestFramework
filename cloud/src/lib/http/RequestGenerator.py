#!/usr/bin/env python

#########################################################################
#
# RequestGenerator Library is used to generate a request and get status
# code and json response
#
# NOTE: Currently this file is not used.
#########################################################################
import requests


class RequestGenerator():
    def request(self, method, url, data=None, headers=None, retries=1):
        """
        Generate and trigger given method request with given data, headers
        """
        self.response = None
        try:
            self.response = requests.request(method=method, url=url, data=data, headers=headers)
            if self.response.status_code != '200':
                for retry in range(0,int(retries)-1):
                    self.response = requests.request(method=method, url=url, data=data, headers=headers)
            return self.response
        except Exception as err:
            print("Error:", err)
            return False

    def response_status_code(self, response):
        """
        Return status code from given request's response
        """
        self.statusCode = 0
        try:
            self.statusCode = response.status_code
            return self.statusCode
        except Exception as err:
            print("Error:", err)
            return False

    def response_json(self, response):
        """
        Return JSON response from given request's response
        """
        self.jsonData = None
        try:
            self.jsonData = response.json()
            return self.jsonData
        except Exception as err:
            print("Error:", err)
            return False
