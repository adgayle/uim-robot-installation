# uim-robot-installation
Scripts to silently install CA Unified Infrastructure Management Robots

## Using the scripts
There are 2 scripts, 1 each for MS Windows and Red Hat Enterprise linux. 
1. Use the nms-robot-vars_sample.cfg file to create hub configurations based on how you want your systems to talk to hubs. E.g. Create a file for each of your hub pairs so each robot will have primary and secondary . If you only have a single hub for each robot location just remove the secondary information from the file.
2. Edit the script(s) to reference the correct nms-robot-vars_<location>.cfg files. Remember these files have the information about the hub(s) you want the robot to talk to.
3. Edit the request.cfg file to install the packages (or probes you want to install). This can be done by following the example in the sample_request.cfg file. Rename the completed file to request.cfg
4. Copy all the files to the target machine you want to install to and run install.sh <location> or install.cmd <location>. The install will deploy the robot to the hub(s) specified in the nms-robot-vars_<location>.cfg. Once complete it will make a call to the primary ADE server to get the packages you specified in the request.cfg installed
