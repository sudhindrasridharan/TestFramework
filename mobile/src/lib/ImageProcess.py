#!/usr/bin/env python

#########################################################################
#
# - This Library is used to convert image into string
# - This Library internally uses the Python Imaging Library
#   Python Imaging Library supports multiple operations
#   like opening, manipulating and saving for different
#   image file formats.
# - This Library takes absolute path of image file as input
# - Return Type is a string
# - This Library is use for Mobile App validation.
#
##########################################################################

import pytesseract
from PIL import Image
import os
import sys
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                                '../../../commonlib')))
from Common import Common


class ImageProcess:

    def __init__(self):
        self.objImg = None
        self.imagePath = None
        self.objCommonFile = Common()

    def _openImage(self):
        """
        Open Image and get image object for Image Processing
        """
        return Image.open(str(self.imagePath))

    def _loadImage(self):
        """
        Load Given image for further processing
        """
        self.objImg.load()

    def _convertImageToStr(self):
        """
        Convert Image Object into Raw Data
        """
        return pytesseract.image_to_string(self.objImg)

    def imageToStringConverter(self, imgPath):
        """
        Convert Image into text data
        """
        try:
            self.imagePath = imgPath
            if self.objCommonFile.fileExists(self.imagePath):
                self.objImg = self._openImage()
                self._loadImage()
                return self._convertImageToStr()
            return False
        except Exception as err:
            print("Error : ", err)
            return False
