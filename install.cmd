rem Set the 64-bit robot as the default executable and the robot installation configuration
set ROBOTEXE="nimsoft-robot-x64.exe"
set ROBOTCONF="nms-robot-vars.cfg"
set NIMSERV="NimbusWatcherService"

rem Check if the UIM robot is already installed if it is exit with error code 1
rem This method should NOT BE USED for upgrades
sc query %NIMSERV%
if %errorlevel% equ 0 (
  echo "The Unified Infrastructure Management robot is already installed, exiting.."
  exit /b 10
)

rem The location determines the hub configuration for the target robot
if "%1%"=="" set LOCATIONCONF="nms-robot-vars_americas.cfg"
if "%1%"=="americas" set LOCATIONCONF="nms-robot-vars_americas.cfg"
if "%1%"=="apj" set LOCATIONCONF="nms-robot-vars_apj.cfg"
if "%1%"=="awsuseast" set LOCATIONCONF="nms-robot-vars_awsuseast.cfg"
if "%1%"=="awsuswest" set LOCATIONCONF="nms-robot-vars_awsuswest.cfg"
if "%1%"=="emea" set LOCATIONCONF="nms-robot-vars_emea.cfg"
if "%1%"=="qa" set  LOCATIONCONF="nms-robot-vars_qa.cfg"

rem This variable is not set on 32-bit machines so change to a 32-bit robot
if "%ProgramW6432%"=="" set ROBOTEXE="nimsoft-robot.exe"

rem Copy the installation files to a known read write enabled folder and install
mkdir %TEMP%\uim
copy %ROBOTEXE% %TEMP%\uim

rem Copy the base configuration file
copy %LOCATIONCONF% %TEMP%\uim\%ROBOTCONF%
copy request.cfg %TEMP%\uim\request.cfg
pushd %TEMP%\uim

rem Run the actual installer
%ROBOTEXE% /VERYSILENT /SUPPRESSMSGBOXES /NORESTART
set INSTALLRC=%ERRORLEVEL%

net stop "Nimsoft Robot Watcher"
copy request.cfg "C:\Program Files\Nimsoft\request.cfg"
net start "Nimsoft Robot Watcher"
popd
exit /b %INSTALLRC%
