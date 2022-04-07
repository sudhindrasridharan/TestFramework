#!/bin/bash

##################################################################
# This Script installs packages and python packages needed for
# Volenium
#
# For Run: e.g: ./ios_install.sh 
##################################################################

bashProfile="~/.bash_profile"

function do_brew_install()
{
    brew install $*
    if [ $? -ne 0 ]; then
        echo -e "\n\n***************************************"
        echo "Unable to install $*"
        exit 1
    else
        echo "Successfully Installed $*"
    fi
}

function do_pip3_install()
{
    sudo pip3 install $*
    if [ $? -ne 0 ]; then
        echo -e "\n\n***************************************"
        echo "Unable to install python $* module"
        exit 1
    else
        echo "Successfully Installed python $* module"
    fi

}

brew --help
if [ $? -ne 0 ]
then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Brew Alredy Installed"
fi

do_brew_install python

brew update

if [ -f "$bashProfile" ]
then
    if grep -R "python=python3" ~/.bash_profile
    then
        echo "Current setup consist python3 as default"
    else
        echo "alias python=python3" >> ~/.bash_profile
        echo "Alias added successfully"
    fi
else	
    echo "alias python=python3" >> ~/.bash_profile
    echo "Alias added successfully"
fi

source ~/.bash_profile

do_pip3_install robotframework

sudo easy_install pip
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to install pip"
    exit 1
else
    echo "Successfully Installed pip"
fi

sudo pip install robotframework-appiumlibrary
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to install robotframework-appiumlibrary"
    exit 1
else
    echo "Successfully Installed robotframework-appiumlibrary"
fi

do_pip3_install Pillow

do_pip3_install pytesseract

do_pip3_install pyserial

do_pip3_install paramiko

do_pip3_install xmltodict

do_pip3 install robotframework-sshlibrary

do_pip3 install robotframework-seriallibrary

do_brew_install node

do_brew_install autoconf

do_brew_install ideviceinstaller
brew link ideviceinstaller

do_brew_install libxml2

if grep -R "PATH=/usr/local/opt/libxml2/bin" ~/.bash_profile
then
    echo "libxml path is already added.."
else
    echo "export PATH=/usr/local/opt/libxml2/bin:$PATH" >> ~/.bash_profile
    echo "Alias added successfully"
fi

brew update
brew uninstall --ignore-dependencies libimobiledevice
do_brew_install --HEAD libimobiledevice
brew link libimobiledevice

do_brew_install tesseract

#npm install -g ios-deploy
#npm install -g ios-deploy --unsafe-perm=true
#if [ $? -ne 0 ]
#then
#    echo -e "\n\n***************************************"
#    echo "Unable to install ios-deploy"
#    exit 1
#else
#    echo "Successfully Installed ios-deploy"
#fi

sudo npm install -g appium
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to install appium"
    exit 1
else
    echo "Successfully Installed appium"
fi
