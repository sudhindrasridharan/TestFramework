#!/bin/bash
##################################################################
# This Script installs packages and python packages needed for
# SmackIT
# For Run Script : ubuntu_install.sh "/home/<user>/android-sdk"
# While script is running user should have to manually press Enter
# and Select YES for further process.
###################################################################

Version="v10.10.0"

function do_apt_get_install()
{
    sudo apt-get -y install $*
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

if [ $# -ne 1 ]
then
    echo -e "\n\n***************************************"
    echo "Please Provide Android SDK Path"
    echo "e.g: ubuntu_install.sh < Path to android SDK >" 
    echo "***************************************"
    exit 1
fi

echo "This script requires root permissions"
sudo -v

sudo apt-get update
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to install Update"
else
    echo "Successfully update"
fi

if grep -R "python=python3" ~/.bashrc
then
    echo "Current setup consist python3 as default"
else
    echo "alias python=python3" >> ~/.bashrc
    echo "Alias added successfully"
fi

do_apt_get_install vim
do_apt_get_install python3-pip
do_apt_get_install exuberant-ctags
do_apt_get_install aptitude
do_apt_get_install python3-dev
do_apt_get_install python3-setuptools
do_apt_get_install python3-pil
do_apt_get_install libtiff5-dev 
do_apt_get_install libjpeg8-dev 
do_apt_get_install zlib1g-dev
do_apt_get_install libfreetype6-dev 
do_apt_get_install liblcms2-dev 
do_apt_get_install libwebp-dev 
do_apt_get_install libharfbuzz-dev 
do_apt_get_install libfribidi-dev
do_apt_get_install tcl8.6-dev 
do_apt_get_install tk8.6-dev 
do_apt_get_install python-tk
do_apt_get_install python-urllib3
do_apt_get_install python-urllib3-whl
do_apt_get_install python-requests
do_apt_get_install python-requests-whl
do_apt_get_install python-openssl

sudo -H pip3 install -U pip setuptools
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to setup"
    exit 1
else
    echo "Successfully setup"
fi

do_pip3_install robotframework
do_pip3_install robotframework-appiumlibrary

if grep -R "ANDROID_HOME="$1"" ~/.bashrc
then
    echo "Android PATH is Already Added."
else
    echo "export ANDROID_HOME="$1"" >> ~/.bashrc
fi

ORIG_PATH=""$1"/tools:"$1"/platform-tools"

nodeZip="node-"$Version"-linux-x64.tar.gz"
if ! [ -e "$nodeZip" ]
then
    CMD_GET="wget http://nodejs.org/dist/"$Version"/node-"$Version"-linux-x64.tar.gz"
    $CMD_GET
    CMD_UNTAR="tar -xvf node-"$Version"-linux-x64.tar.gz"
    $CMD_UNTAR
    CMD_MOVE="sudo mv node-"$Version"-linux-x64 /usr/local/node/"
    $CMD_MOVE
fi

nodePath="/usr/bin/node"
if [ -e "$nodePath" ]
then
	CMD_MOVE="sudo mv /usr/bin/node /usr/bin/node_bkup"
	$CMD_MOVE
fi

npmPath="/usr/bin/npm"
if [ -e "$npmPath" ]
then
	CMD_MOVE="sudo mv /usr/bin/npm /usr/bin/npm_bkup"
	$CMD_MOVE
fi

javaPath="/usr/bin/java"
if [ -e "$javaPath" ]
then
	CMD_MOVE="sudo mv /usr/bin/java /usr/bin/java_bkup"
	$CMD_MOVE
fi

export PATH=$PATH:/usr/local/node/bin

npm install -g appium
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to install appium"
    exit 1
else
    echo "Successfully Installed appium"
fi

npm install wd
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to install wd"
    exit 1
else
    echo "Successfully install wd"
fi

npm install -g appium-doctor
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to install appium-doctor"
    exit 1
else
    echo "Successfully installed appium-doctor"
fi

sudo add-apt-repository ppa:webupd8team/java
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to add repository"
    exit 1
else
    echo "Successfully added repository"
fi

sudo apt-get update
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to update"
    exit 1
else
    echo "Successfully updated"
fi

do_apt_get_install oracle-java8-installer

if grep -R "JAVA_HOME=/usr/lib/jvm/java-8-oracle" ~/.bashrc
then
    echo "Java PATH is Already Added."
else
    echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.bashrc
    echo "Alias added successfully"
fi

if grep -R "PATH=" ~/.bashrc
then
    echo "PATH is Already Added."
else
    echo "export PATH=$PATH:$ORIG_PATH:/usr/lib/jvm/java-8-oracle/bin" >> ~/.bashrc
    echo "Alias added successfully"
fi

sudo add-apt-repository ppa:nilarimogard/webupd8
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to add repository"
    exit 1
else
    echo "Successfully Added repository"
fi

sudo apt-get update
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to update"
    exit 1
else
    echo "Successfully updated"
fi

sudo apt-get install android-tools-adb 
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to install android-tools-adb"
    exit 1
else
    echo "Successfully Installed android-tools-adb"
fi

sudo apt-get install android-tools-fastboot
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to install android-tools-fastboot"
    exit 1
else
    echo "Successfully Installed android-tools-fastboot"
fi

do_pip3_install Pillow
do_pip3_install pytesseract
do_pip3_install pyserial
sudo pip3 install paramiko --upgrade
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to upgrade Paramiko"
    exit 1
else
    echo "Successfully upgrade Paramiko"
fi
do_pip3_install paramiko
do_pip3_install xmltodict
do_pip3_install gevent
do_pip3_install Markdown
do_pip3_install urllib3
do_pip3_install requests
sudo pip3 install pyOpenSSL --upgrade
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to Upgrade pyOpenSSL"
    exit 1
else
    echo "Successfully Upgrade pyOpenSSL"
fi
do_pip3_install pyOpenSSL
sudo pip3 install --ignore-installed six
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to install python six"
    exit 1
else
    echo "Successfully Installed Six"
fi
sudo pip3 install --ignore-installed urllib3
if [ $? -ne 0 ]
then
    echo -e "\n\n***************************************"
    echo "Unable to install urllib3"
    exit 1
else
    echo "Successfully Installed urllib3"
fi
do_pip3_install locustio --ignore-installed six
do_pip3_install locustio
do_pip3_install boto3
do_pip3_install robotframework-testrail==1.0.2
do_pip3_install matplotlib==2.2.3
do_pip3_install robotframework-imaplibrary==0.3.0
#do_pip3_install robotframework-mqttlibrary==0.5.0
#do_pip3_install bokeh
do_pip3_install robotframework-requests
do_pip3 install robotframework-seriallibrary
do_pip3 install robotframework-sshlibrary
