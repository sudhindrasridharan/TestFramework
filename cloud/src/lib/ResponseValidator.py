#!/usr/bin/env python

#########################################################################
#
# - ResponseValidator Library is used to validate JSON, XML response
#
#########################################################################

import xmltodict
import json


class ResponseValidator:

    def _getResponse(self, response, traversalPath):
        try:
            traversalPath = traversalPath.split(',')
            for path in traversalPath:
                path = path.split(':')
                path[0] = path[0].lower()
                if path[0] == 'list':
                    response = response[int(path[1])]
                elif path[0] == 'dict' or path[0] == 'dictionary':
                    response = response[str(path[1])]
                elif path[0] == 'str':
                    if path[1] == 'dict' or path[0] == 'dictionary' \
                           or path[1] == 'list' or path[1] == 'tuple':
                        response = eval(response)
                else:
                    response = None
                    print("Please Provide Correct Traversal Path \
                            Type: 'list', 'dict'\n")
            return response
        except Exception as err:
            print("Error:", err)
            return False

    def responseValidation(self, responseType, response, traversalPath):
        """
        This function will return expected response value.
        Arguments: responseType: Provide response type
                                 (Ex: 'JSON', 'XML')
                   response: Provide variable where
                             response is stored
                   traversalPath: Provide traversal path for
                                  whom need to find value
                                  (Ex: 'dict:args,dict:key,list:1')
        Return: Response Value
        """
        responseType = responseType.upper()
        try:
            if responseType == 'JSON':
                response = self._getResponse(response, traversalPath)
                return response
            elif responseType == 'XML':
                response = json.loads(json.dumps(xmltodict.parse(response)))
                response = self._getResponse(response, traversalPath)
                return response
            else:
                print("Supported Response Types are: 'JSON', 'XML'\n")
                return False
        except Exception as err:
            print("Error:", err)
            return False
