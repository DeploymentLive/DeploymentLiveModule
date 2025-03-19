# DeploymentLiveModule
Common PowerShell Functions for Deployment Live.

Various tools used in Windows Systems Management and Deployment.

# Execution

There are two ways to execute the Module:

* Execute In-Place - Simply import the `import-module .\DeploymentLiveModule.psm1` from this folder. Will traverse the subfolders and import all script functions.

* Execution of compiled Module - After running the `.\build.ps1` command, a single file `import-module .\_release\DeploymentLive.psm1` module will be created. The single file should be faster to execute and makes singing easier. 

# Components:

* Disk
* General
* Hyper-V
* INI Files
* Network
* Resources
* User Interface
* Utility 
* Windows
