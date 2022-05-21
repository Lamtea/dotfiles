#! /bin/bash

clouds=(
	dropbox
	gdrive
	onedrive
	pcloud
	mega
)

for cloud in "${clouds[@]}"; do
	mountpath="${HOME}/clouds/${cloud}"
	if [[ ! -e "${mountpath}" ]]; then
		mkdir -p "${mountpath}"
	fi

	if [ "${cloud}" = "dropbox" ]; then
		rclone mount --vfs-cache-mode writes "${cloud}:Data" "${mountpath}" &
	else
		rclone mount --vfs-cache-mode writes "${cloud}:/" "${mountpath}" &
	fi
done
