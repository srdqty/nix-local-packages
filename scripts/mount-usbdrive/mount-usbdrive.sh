#!@bash@

set -eux

device=$1
mount_point=$2
user=${3:-`@id@ -nu`}
group=${4:-`@id@ -ng`}

@mount@ -o "umask=0,uid=$user,gid=$group" "$device" "$mount_point"
