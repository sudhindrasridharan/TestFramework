#!/usr/bin/env python

#####################################################################
#
# - This Library used to generate Test report from Robot XML file.
# - This library takes XML file output.xml file of robotframework as
#   An input and generate CSV test report according to XML file data.
#
#####################################################################

from XmlParser import XmlParser
from Common import Common
import csv
import re
import os

# Macros
REPORT_FILE_NAME = "../results/TestReport"
REPORT_COLUMN_0 = "TEST_SUITE"
REPORT_COLUMN_1 = "TEST_CASE"
REPORT_COLUMN_2 = "DESCRIPTION"
REPORT_COLUMN_3 = "TEST_ID"
REPORT_COLUMN_4 = "TEST_CATEGORY"
REPORT_COLUMN_5 = "TEST_START_TIME"
REPORT_COLUMN_6 = "TEST_END_TIME"
REPORT_COLUMN_7 = "TEST_STATUS"
REPORT_COLUMN_8 = "COMMENTS"
CSV_FILE_EXT = "csv"
TOTAL_TEST_CASE = "TOTAL"
TOTAL_PASS_TEST = "PASS"
TOTAL_FAIL_TEST = "FAIL"


class TestReportGenerator:

    def __init__(self):
        self.objXmlParser = XmlParser()
        self.objCommon = Common()
        self.objFilePtr = None
        self.objCsvWriter = None

    def _getTestSuiteName(self, suiteInfo):
        """
        Parse Test suite name from XML data
        """
        try:
            return suiteInfo.get("@name")
        except Exception as err:
            print("ERROR: ", err)
            return None

    def _getTestCaseName(self, testInfo):
        """
        Parse Test case name from XML data
        """
        try:
            return testInfo.get("@name")
        except Exception as err:
            print("ERROR: ", error)
            return None

    def _getTestCaseId(self, testInfo):
        """
        Parse Test case ID from XML data
        """
        try:
            if isinstance(testInfo.get("tags").get("tag"), list):
                for tag in testInfo.get("tags").get("tag"):
                    if re.findall(r'[\d]', str(tag)):
                        return tag
            elif isinstance(testInfo.get("tags").get("tag"), str):
                if re.findall(r'[\d]', str(testInfo.get("tags").get("tag"))):
                    return str(testInfo.get("tags").get("tag"))
                else:
                    print("WARN: Test case ID not found...")
                    return False
        except Exception as err:
            print("WARN: Test case ID missing in the robot suite...")
            return None

    def _getTestCaseCategory(self, testInfo):
        """
        Parse test case category from XML data
        """
        try:
            if isinstance(testInfo.get("tags").get("tag"), list):
                for tag in testInfo.get("tags").get("tag"):
                    if not re.findall(r'[\d]', str(tag)):
                        return tag
            elif isinstance(testInfo.get("tags").get("tag"), str):
                if not re.findall(r'[\d]',
                                  str(testInfo.get("tags").get("tag"))):
                    return str(testInfo.get("tags").get("tag"))
                else:
                    print("WARN: Test case CATEGORY not found...")
                    return None
        except Exception as err:
            print("WARN: Test case CATEGORY missung in the robot suite...")
            return None

    def _getTestCaseStartTime(self, testInfo):
        """
        Parse test case start time from XML data
        """
        try:
            return testInfo.get("status").get("@starttime")
        except Exception as err:
            print("ERROR: ", err)
            return None

    def _getTestCaseEndTime(self, testInfo):
        """
        Parse test case end time from XML data
        """
        try:
            return testInfo.get("status").get("@endtime")
        except Exception as err:
            print("ERROR: ", err)
            return None

    def _getTestCaseStatus(self, testInfo):
        """
        Parse test case status from XML data
        """
        try:
            return testInfo.get("status").get("@status")
        except Exception as err:
            print("ERROR: ", err)
            return None

    def _getTestCaseDescription(self, testInfo):
        """
        Parse Test Case Description from XML data
        """
        try:
            return testInfo.get("doc")
        except Exception as err:
            print("ERROR: ", err)
            return None

    def _writeRawDataInCsv(self, rawDataDict):
        """
        Write raw data into csv report
        """
        if rawDataDict:
            try:
                self.objCsvWriter.writerow(dict(rawDataDict))
                return True
            except Exception as err:
                print("ERROR: ", err)
                return False

    def _getTestDataBuffer(self, tcInfo, tsName):
        '''
        Prepare test data buffer to dump into CSV report
        '''
        csvDataDict = {}
        try:
            csvDataDict[REPORT_COLUMN_0] = str(tsName)
            csvDataDict[REPORT_COLUMN_1] = self._getTestCaseName(tcInfo)
            csvDataDict[REPORT_COLUMN_2] = self._getTestCaseDescription(tcInfo)
            csvDataDict[REPORT_COLUMN_3] = self._getTestCaseId(tcInfo)
            csvDataDict[REPORT_COLUMN_4] = self._getTestCaseCategory(tcInfo)
            csvDataDict[REPORT_COLUMN_5] = self._getTestCaseStartTime(tcInfo)
            csvDataDict[REPORT_COLUMN_6] = self._getTestCaseEndTime(tcInfo)
            csvDataDict[REPORT_COLUMN_7] = self._getTestCaseStatus(tcInfo)
            csvDataDict[REPORT_COLUMN_8] = " "
            return csvDataDict
        except Exception as err:
            print("ERROR: ", err)
            return csvDataDict

    def _writeTestStatistics(self, writeTag, writeVal):
        """
        Write test statistics in CSV report
        Total PASS, FAIL and Test Case Count
        """
        try:
            csvDataDict = {}
            csvDataDict[REPORT_COLUMN_0] = str(writeTag)
            csvDataDict[REPORT_COLUMN_1] = str(writeVal)
            return csvDataDict
        except Exception as err:
            print("ERROR: ", err)
            return csvDataDict

    def _prepareCsvReportHeader(self):
        """
        Prepare CSV report Header data
        """
        try:
            headerList = []
            for numCnt in range(9):
                headerList.append(eval("REPORT_COLUMN_{0}".format(numCnt)))
            return headerList
        except Exception as err:
            print("ERROR: ", err)
            return headerList

    def _getTestStatisticsData(self, tsInfo):
        """
        Get Test statistics data from XML report
        """
        try:
            passTestCnt = eval(tsInfo['statistics']['total']["stat"][1]['@pass'])
            failTestCnt = eval(tsInfo['statistics']['total']["stat"][1]['@fail'])
            totalTestCnt = (int(passTestCnt) + int(failTestCnt))
        except Exception as err:
            print("ERROR: ", err)
            passTestCnt = failTestCnt = totalTestCnt = 1

        return (passTestCnt, failTestCnt, totalTestCnt)

    def _getExecTestInfo(self, testData):
        """
        Dump test cases data into CSV report
        """
        totalTestCnt = 0
        try:
            testSuiteInfo = testData.get('robot')
            (passTc, failTc, totalTc) = self._getTestStatisticsData(testSuiteInfo)
            suiteInfo = testData.get("robot").get("suite")
            suiteName = suiteInfo.get("@name")
        except Exception as err:
            print("ERROR: ", err)
            suiteInfo = totalTc = suiteName = 1

        return (totalTc, suiteInfo, suiteName)

    def _dumpTestStatisticsInCsv(self, tsData):
        """
        Dump statistics report into CSV file
        """
        csvDataDict = {}
        try:
            testSuiteInfo = tsData.get('robot')
            (passTc, failTc, totalTc) = self._getTestStatisticsData(testSuiteInfo)
            self._writeRawDataInCsv(self._writeTestStatistics(TOTAL_TEST_CASE, totalTc))
            self._writeRawDataInCsv(self._writeTestStatistics(TOTAL_PASS_TEST, passTc))
            self._writeRawDataInCsv(self._writeTestStatistics(TOTAL_FAIL_TEST, failTc))
        except Exception as err:
            print("ERROR: ", err)
            return False

    def _dumpTestDataInCsv(self, totalTcCnt, suiteData, suiteName):
        """
        Parse and Dump test case data in CSV report
        """
        try:
            if int(totalTcCnt) == 1:
                tcInfo = suiteData.get("test")
                rawDataBuffer = self._getTestDataBuffer(tcInfo, suiteName)
                self._writeRawDataInCsv(rawDataBuffer)
            else:
                for tcInfo in list(suiteData.get("test")):
                    rawDataBuffer = self._getTestDataBuffer(tcInfo, suiteName)
                    self._writeRawDataInCsv(rawDataBuffer)
            return True
        except Exception as err:
            print("ERROR:", err)
            return False

    def _dumpHeaderDataInCsv(self):
        """
        Dump Header data into CSV report
        """
        try:
            headerFields = self._prepareCsvReportHeader()
            self.objCsvWriter = csv.DictWriter(self.objFilePtr,
                                               fieldnames=headerFields)
            self.objCsvWriter.writeheader()
            self.csvHeaderFlag = 1
            return True
        except Exception as err:
            print("ERROR: ", err)
            return False

    def _openCsvReportFile(self, reportFile, tsName):
        """
        Create CSV file to prepare test report
        """
        try:
            epochTime = self.objCommon.getCurrentEpochTime()
            reportFileName = "{0}_{1}_{2}.{3}".format(reportFile, tsName,
                                                  epochTime, CSV_FILE_EXT)
            if os.path.isfile(reportFileName):
                print("INFO: File {0} is already created".format(reportFileName))
            else:
                self.objFilePtr = self.objCommon.openFile(reportFileName)
            return True
        except Exception as err:
            print("ERROR: ", err)
            return False

    def _xmlToDictConverter(self, xmlFilePath):
        """
        Convert XML data into dictionary format
        """
        try:
            return self.objXmlParser.xmlToDict(xmlFilePath)
        except Exception as err:
            print("ERROR : ", err)
            return False

    def generateCsvReport(self, robotXmlFile, csvReportName=REPORT_FILE_NAME):
        """
        Prepare CSV report file from robot XMl report File
        """
        if not self.objCommon.fileExists(robotXmlFile):
            print("ERROR: OUTPUT XML FILE {0} NOT FOUND".format(robotXmlFile))
            return False

        testDataDict = self._xmlToDictConverter(robotXmlFile)
        if not testDataDict:
            return False
        else:
            try:
                (totalCnt, tsData, tsName) = self._getExecTestInfo(testDataDict)
                self._openCsvReportFile(csvReportName, tsName)
                self._dumpHeaderDataInCsv()
                self._dumpTestDataInCsv(totalCnt, tsData, tsName)
                self._dumpTestStatisticsInCsv(testDataDict)
                self.objCommon.closeFile(self.objFilePtr)
                print("\n\n{0}\nINFO: Test report generated successfully\n{0}\n\n"
                  .format("-"*60))
                return True
            except Exception as err:
                return False
