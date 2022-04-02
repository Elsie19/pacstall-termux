#!/data/data/com.termux/files/usr/bin/bash

#     ____                  __        ____
#    / __ \____ ___________/ /_____ _/ / /
#   / /_/ / __ `/ ___/ ___/ __/ __ `/ / /
#  / ____/ /_/ / /__(__  ) /_/ /_/ / / /
# /_/    \__,_/\___/____/\__/\__,_/_/_/
#
# Copyright (C) 2020-present
#
# This file is part of Pacstall
#
# Pacstall is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3 of the License
#
# Pacstall is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Pacstall. If not, see <https://www.gnu.org/licenses/>.

# Update should be self-contained and should use mutable functions or variables
# Color variables are ok, while "$USERNAME" and "$BRANCH" are needed

mkdir -p "/data/data/com.termux/files/usr/var/log/pacstall/metadata"
mkdir -p "/data/data/com.termux/files/usr/var/log/pacstall/error_log"
find /data/data/com.termux/files/usr/var/log/pacstall/* -maxdepth 1 | grep -v metadata | grep -v error_log | xargs -I{} mv {} /data/data/com.termux/files/usr/var/log/pacstall/metadata
chown "$PACSTALL_USER" -R /data/data/com.termux/files/usr/var/log/pacstall/error_log
mkdir -p "/data/data/com.termux/files/usr/tmp/pacstall"
chown "$PACSTALL_USER" -R /data/data/com.termux/files/usr/tmp/pacstall

STGDIR="/data/data/com.termux/files/usr/share/pacstall"

if ! command -v apt &> /dev/null; then
	echo -ne "Do you want to install axel (faster downloads)? [${BIGreen}Y${NC}/${RED}n${NC}] "
	read -r reply <&0
	case "$reply" in
		N*|n*) ;;
		*) apt install -qq -y axel;;
	esac
fi
#for i in {error_log.sh,add-repo.sh,search.sh,download.sh,install-local.sh,upgrade.sh,remove.sh,update.sh,query-info.sh}; do
	#wget -q -N https://raw.githubusercontent.com/"$USERNAME"/pacstall/"$BRANCH"/misc/scripts/"$i" -P "$STGDIR/scripts" &
done

wget -q -N https://raw.githubusercontent.com/termux-desktop/pacstall/main/pacstall -P /bin &
wget -q -O /data/data/com.termux/files/usr/share/man/man8/pacstall.8.gz https://raw.githubusercontent.com/termux-desktop/pacstall/main/misc/pacstall.8.gz &
mkdir -p /data/data/com.termux/files/usr/share/bash-completion/completions &
wget -q -O /data/data/com.termux/files/usr/share/bash-completion/completions/pacstall https://raw.githubusercontent.com/termux-desktop/pacstall/main/misc/completion/bash &

if command -v fish &> /dev/null; then
	wget -q -O /data/data/com.termux/files/usr/share/fish/vendor_completions.d/pacstall.fish https://raw.githubusercontent.com/termux-deskto/pacstall/main/misc/completion/fish &
fi

wait

chmod +x /data/data/com.termux/files/usr/bin/pacstall
chmod +x /data/data/com.termux/files/usr/share/pacstall/scripts/*

# Bling Bling update ascii
echo '
    ____                  __        ____
   / __ \____ ___________/ /_____ _/ / /
  / /_/ / __ `/ ___/ ___/ __/ __ `/ / /
 / ____/ /_/ / /__(__  ) /_/ /_/ / / /
/_/    \__,_/\___/____/\__/\__,_/_/_/
'

# vim:set ft=sh ts=4 sw=4 noet:
