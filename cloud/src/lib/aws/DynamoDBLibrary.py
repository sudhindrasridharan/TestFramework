#!/usr/bin/env python

##################################################################################
#
# This libray provide interface to DynamoDB Table resources in order to
# create tables, write items to tables, modify existing items, retrieve items,
# and query/filter the items in the table.
#
###################################################################################

from boto3.dynamodb.conditions import Key, Attr
import boto3
import json


class DynamoDBLibrary:

    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def __init__(self):
        self.dbClient = None

    def createAwsDynamoDBSession(self, awsAccessKey, awsSecKey, region):
        """
        Create AWS DynamoDB Session to read/write DB table
        """
        try:
            self.dbClient = boto3.resource(
                                           'dynamodb',
                                           aws_access_key_id=awsAccessKey,
                                           aws_secret_access_key=awsSecKey,
                                           region_name=region
                                          )
            return True
        except Exception as err:
            print("ERROR:", err)
            return False

    def getDbTable(self, tableName):
        """
        Get Table Object from DataBase For Get and Set Item
        """
        try:
            return self.dbClient.Table(str(tableName))
        except Exception as err:
            print("ERROR: ", err)
            return False

    def createNewTable(self, tableName, keySchema,
                         attrDefinitions, provisionedThroughput):
        """
        Create the DynamoDB table
        """
        newTable = self.dbClient.create_table(
                TableName = tableName,
                KeySchema = keySchema,
                AttributeDefinitions = attrDefinitions,
                ProvisionedThroughput = provisionedThroughput
                )
        retVal = newTable.meta.client.get_waiter('table_exists').wait(
							TableName = tableName
							)
        if str(retVal) == "0":
            return True
        else:
            return False

    def putItemInTable(self, tableName, item):
        """
        Once you have a DynamoDB.Table resource you can add new items 
        to the table.
        """
        isTable = self.getDbTable(tableName)
        if not isTable:
            print("ERROR: Table {0} Not Found into Database".format(isTable))
            return False
        try:
            return isTable.put_item(
                Item = json.dumps(item)
                )
        except Exception as err:
            print("ERROR: ", err)
            return False

    def getItemFromTable(self, tableName, item):
        """
        Once you have a DynamoDB.Table resource you can Get items 
        from the table.
        """
        isTable = self.getDbTable(tableName)
        if not isTable:
            print("ERROR: Table {0} Not Found into Database".format(isTable))
            return False
        try:
            getItemResponse =  isTable.get_item(
                                         Key = json.dumps(item)
                                        )
            return getItemResponse['Item']
        except Exception as err:
            return False

    def deleteItemFromTable(self, tableName, item):
        """
        Once you have a DynamoDB.Table resource you can Delete items 
        from the table.
        """
        isTable = self.getDbTable(tableName)
        if not isTable:
            print("ERROR: Table {0} Not Found into Database".format(isTable))
            return False
        try:
            return isTable.delete_item(
                                 Key = json.dumps(item)
                                )
        except Exception as err:
            print("ERROR: ", err)
            return False

    def scanTable(self, tableName):
        """
        Scan Item from table
        """
        isTable = self.getDbTable(tableName)
        if not isTable:
            print("ERROR: Table {0} Not Found into Database".format(isTable))
            return False
        try:
            scanresp = isTable.scan()
            return scanresp['Items']
        except Exception as err:
            print("ERROR: ", err)
            return False
        
    def searchQueryFromTheTable(self, tableName, searchKey, expectedVal):
        """
        The Query operation finds items based on primary key values.
        You can query any table or secondary index that has a composite primary key
        """
        isTable = self.getDbTable(tableName)
        if not isTable:
            print("ERROR: Table {0} Not Found into Database".format(isTable))
            return False
        try:
            response = isTable.query(
                KeyConditionExpression=Key(str(searchKey)).eq(str(expectedVal))
                )
            return response['Items']
        except Exception as err:
            print("ERROR: ", err)
            return False

    def deleteTable(self, tableName):
        """
        Delete Table From the DataBase
        """
        isTable = self.getDbTable(tableName)
        if not isTable:
            print("ERROR: Table {0} Not Found into Database".format(isTable))
            return False
        try:
            return isTable.delete()
        except Exception as err:
            print("ERROR: ", err)
            return False
