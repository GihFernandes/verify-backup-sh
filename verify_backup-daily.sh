#!/bin/bash
#
#author: Giovane Fernandes
#description: Backup Verification Routine
#version: 1.0
#04/13/2023 16:17
#

cd /home/ponto/dumps/dumprw/

new_backup_name=$(find . -mmin -480 -name "*.tar.gz" | sort -nr | sed '1!d' | awk {'print $1'} | sed 's|^./||')
old_backup_name=$(find . -mmin -480 -name "*.tar.gz" | sort -nr | sed '2!d' | awk {'print $1'} | sed 's|^./||')

new_backup_size=$(find . -name $new_backup_name -exec du {} + | awk {'print $1'})
old_backup_size=$(find . -name $old_backup_name -exec du {} + | awk {'print $1'})

function backup_compare(){
	if [ $new_backup_size -gt $old_backup_size ]
	then 
    echo "sucess"
	
	else 
    echo "erro"
	fi	
}

#Call and Excute the function
backup_compare 

