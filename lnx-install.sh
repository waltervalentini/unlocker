#!/bin/bash
set -e

echo "Unlocker 3.0.2 for VMware Workstation"
echo "====================================="
echo "(c) Dave Parsons 2011-18"

# Ensure we only use unmodified commands
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo Creating backup folder...
base_dir=/usr/lib/vmware
backup_dir=./backup
rm -rf "$backup_dir"
mkdir -p "$backup_dir"
cp -v \
    "$base_dir/bin/vmware-vmx" \
    "$base_dir/bin/vmware-vmx-debug" \
    "$base_dir/bin/vmware-vmx-stats" "$backup_dir"
if [ -d "$base_dir/lib/libvmwarebase.so.0/" ]; then
    cp -v "$base_dir/lib/libvmwarebase.so.0/libvmwarebase.so.0" "$backup_dir"
elif [ -d "$base_dir/lib/libvmwarebase.so/" ]; then
    cp -v "$base_dir/lib/libvmwarebase.so/libvmwarebase.so" "$backup_dir"
fi

echo Patching...
python3 ./unlocker.py

echo "you can run ./lnx-update-tools.sh to download wmvare tools"

echo Finished!
