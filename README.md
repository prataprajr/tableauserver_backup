# tableauserver_backup
Backup Tableau server to AWS S3 storage, for disaster recovery purpose
##Introduction
This script lets you backup a Tableau server instance to AWS S3 storage. The highlights are:
 - Written in Windows PowerShell for adaptability with other system modules
 - Uses the native 'Write-S3Object' module in AWS-provided Windows OS, so there is no need to install any 3rd party tool
 - Does not require any downtime on Tableau server for taking backup
 - Can be automated to run daily by adding to 'Task scheduler'

##Pre-requisites
 - Remote desktop access to node running Tableau server application
 - Access to Tableau install directory
 - Configure powershell to run user scripts. Reference: https://technet.microsoft.com/en-us/library/ee176961.aspx
      
##List of Scripts
 - tableauserverbackup.ps1
 
##Usage
 - Copy the script to 'bin' in tableau server install directory.
 - Edit 'User configurable variables' in script to match your server environment.
 - Right click on script and click edit(using powershell). You can run the script here.

##Automation
Once manual testing of script is successful, you can configure it to run daily via the Windows task sheduler
 - Program Path: 'powershell.exe'
 - Argument '-file <"path to Tableau backup powershell script">
