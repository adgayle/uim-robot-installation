#!/bin/sh
#
# Installs the CA Unified Infrastructure Management robot

ROBOTRPM=nimsoft-robot.i386.rpm
ROBOTCONF=nms-robot-vars.cfg
export PATH=/sbin:/usr/sbin:/bin:/usr/bin:$PATH

# Check if the UIM robot is already installed and exit if it is
# This method SHOULD NOT be used for upgrades
chkconfig nimbus
if [ $? -eq 0 ]
then
  echo "Nimsoft Robot is already installed, exiting..."
  exit 1
fi

case "$1" in
  americas)
    LOCATIONCONF=nms-robot-vars_americas.cfg
    ;;
  apj)
    LOCATIONCONF=nms-robot-vars_apj.cfg
    ;;
  awsuseast)
    LOCATIONCONF=nms-robot-vars_awsuseast.cfg
    ;;
  awsuswest)
    LOCATIONCONF=nms-robot-vars_awsuswest.cfg
    ;;
  emea)
    LOCATIONCONF=nms-robot-vars_emea.cfg
    ;;
  qa)
    LOCATIONCONF=nms-robot-vars_qa.cfg
    ;;
  *)
    LOCATIONCONF=nms-robot-vars_americas.cfg
esac

#
# Determine whether to use the 32-bit of 64-bit probe
#
ARCH=`uname -i`
if [ "$ARCH" = "x86_64" ]
then
  ROBOTRPM=nimsoft-robot.x86_64.rpm
fi

#
# Install the robot using the appropriate base configuration file
#
SOURCEDIR=`pwd`
cp $LOCATIONCONF /opt/$ROBOTCONF
cp $ROBOTRPM /opt/$ROBOTRPM
cd /opt
rpm -ivh $ROBOTRPM

cd /opt/nimsoft/install
./RobotConfigurer.sh
cp $SOURCEDIR/request.cfg /opt/nimsoft
/etc/init.d/nimbus start
RC=$?
rm /opt/$ROBOTRPM /opt/$ROBOTCONF

cd $SOURCEDIR
exit $RC
