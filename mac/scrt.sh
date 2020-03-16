#!/bin/bash

td=`date +%Y%m%d`
user_home=/Users/chench
config_root=$user_home/Library/Application' 'Support/VanDyke
config_path=$user_home/Library/Application\ Support/VanDyke/SecureCRT/Config
backup_dir=~/soft/scrt_bak/
backup_file="SecureCRTBackup.$td.tar.gz"

echo "Renewal scrt start ..."

action=$1
path=$2
#echo $action
#echo $path

if [ ! "$path" ]; then
	## path is empty
	path=~
fi
backup_dir=$path

## Backup scrt sessions
#echo "Backup..."
#if [ ! -d "$config_path" ]; then
#  	echo "$config_path not exists"
#	echo "Exist."
#	exit 1
#fi

## Uninstall scrt
function doRemove() {
	#echo "Uninstall..."
	echo "remove $user_home/Library/Application Support/VanDyke/*"
	rm -rf $user_home/Library/Application\ Support/VanDyke/*
	#echo "Uninstall done."
}

## Backup config
function doExport() {
	cd $user_home/Library/Application\ Support/VanDyke/SecureCRT/Config
	rm -rf SecureCRT_eval.lic
	tar czvf ${backup_file} *
 	mv ${backup_file} ${backup_dir}
	echo "Backup done."
	echo ""
}

## Restore scrt sessions
function doImport() {
	echo "Restore scrt sessions..."
	if [ ! -d "$config_path" ]; then
  		mkdir -p $config_path
	fi
	#tar zxvf "$backup_dir/$backup_file" -C $user_home/Library/Application\ Support/VanDyke/SecureCRT/Config
	tar zxvf "$path" -C $user_home/Library/Application\ Support/VanDyke/SecureCRT/Config
	echo "Restore done."
	echo ""
}

if [ "import" == "$action" ]; then
	echo "Do import..."
	doImport
elif [ "export" == "$action" ]; then
	echo "Do export..."
	doExport
elif [ "remove" == "$action" ]; then
	echo "Do remove..."
	doRemove
else
	echo "Do nothing!"
	echo "Usage: $0 import|export|remove [path]"
	echo ""
	echo "  e.g: $0 import /Users/chench/SecureCRTBackup.20190920.tar.gz"
	echo "  e.g: $0 export ~"
	echo "  e.g: $0 remove"
fi

#exit 0

#cd /Users/chench/Library/Application\ Support/VanDyke/SecureCRT/Config
#rm -rf SecureCRT_eval.lic
#tar czvf ${backup_file} *
#mv ${backup_file} ${backup_dir}
#echo "Backup done."
#echo ""
#exit 0

## Uninstall scrt
#echo "Uninstall scrt..."
#cd ~
#sudo dpkg --purge scrt
#rm -rf $config_root
#echo "Uninstall done."
#echo ""

## Reinstall scrt
#echo "Reinstall scrt..."
#cd ~/soft
##sudo dpkg -i scrt-8.5.2-1799.ubuntu18-64.x86_64.deb
#sudo dpkg -i scrt-8.5.3-1867.ubuntu18-64.x86_64.deb
#echo "Reinstall done."
#echo ""

## Restore scrt sessions
#echo "Restore scrt sessions..."
#if [ ! -d "$config_path" ]; then
#  	mkdir -p $config_path
#fi
#tar zxvf "$backup_dir/$backup_file" -C $config_path
#echo "Restore done."
#echo ""

#cd ~
#echo "Done."
echo  ""
