# Author: Pratap Raj
# Purpose: Backup Tableau server to AWS S3 storage, for disaster recovery purpose
# see http://kb.tableausoftware.com/articles/knowledgebase/server-maintenance
#

############     User configuratble variables - Edit as per your environment    #############
#############################################################################################
# Provide path to Tableau server bin folder
$tableaubindir = 'D:\Program Files\Tableau\Tableau Server\10.1\bin'

# Provide path to local backup directory. Ensure user running script has read-modify permissions here
$bakdir = "D:\Backups\Tableau"

# Provide S3 bucket name
$s3bucket ="tableau-dr-backups"

#Provide S3 prefix (subfolder)
$s3prefix = "tableau/server"
############### User configurable variables end. DO NOT edit anything below #################

# Create two backup files, one date-stamped, one with a standard name to facilitate automated restore
$name = Get-Date -uformat "tabbackup_%Y%m%d-%H%M.tsbak"
$name_last = "tabbackup_last.tsbak"

cd $tableaubindir

# Create backup directory if it doesn't exist
new-item $bakdir -Force -Type Directory

# Backup script
.\tabadmin.bat backup $name -v

# Run tabadmin cleanup
.\tabadmin.bat cleanup


# Move to local backup folder
move-item $name $bakdir\$name
copy-item $bakdir\$name $bakdir\$name_last

# Upload to S3 
Write-S3Object -BucketName $s3bucket -File $bakdir\$name -Key $s3prefix/$name
Write-S3Object -BucketName $s3bucket -File $bakdir\$name_last -Key $s3prefix/$name_last

#Remove backups from local backup folder
remove-item $bakdir\$name