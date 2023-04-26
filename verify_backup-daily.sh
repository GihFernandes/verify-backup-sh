#!/bin/bash
#
#author: Giovane Fernandes
#description: Backup Verification Routine
#version: 1.0.1
#04/13/2023 16:17
#

function verify_backup(){
	#Put the path to backups directory here
	cd /home/backup-daily/

	#-mmin -480, less than 480 minutes, i used this paramenter to my case
	new_backup_name=$(find . -mmin -480 -name "*.tar.gz" | sort -nr | sed '1!d' | awk {'print $1'} | sed 's|^./||')
	old_backup_name=$(find . -mmin -480 -name "*.tar.gz" | sort -nr | sed '2!d' | awk {'print $1'} | sed 's|^./||')

	new_backup_size=$(find . -name $new_backup_name -exec du {} + | awk {'print $1'})
	old_backup_size=$(find . -name $old_backup_name -exec du {} + | awk {'print $1'})
	
	#Print the variables
	echo $new_backup_name $new_backup_size "-" $old_backup_name $old_backup_size 
	
	#Compare new_backup_size and old_backup_size
	if [ $new_backup_size -gt $old_backup_size ]
	then 
   		echo "sucess"
	
	else 
    		echo "error"
	fi	
}

#Current date variable
DATE=$(date +%y-%m-%d_%H%M)

#Call, Excute the function and save output as log file
verify_backup > /home/logs/log_${DATE}.out 2> /home/logs/log_${DATE}.err
