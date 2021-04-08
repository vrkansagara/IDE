#!/usr/bin/env bash

# set -e # This setting is telling the script to exit on a command error.
# set -x # You refer to a noisy script.(Used to debugging)
export DEBIAN_FRONTEND=noninteractive

if [ "$(whoami)" != "root" \]; then
	SUDO=sudo
fi

# """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
#  Maintainer :- Vallabh Kansagara<vrkansagara@gmail.com> — @vrkansagara
#  Note		  :- Linux home directory permission, Linux way !
# """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

echo "User [ $USER ] is the only one who owning the [ $HOME ] directory"
${SUDO} chown $USER:$USER -Rf $HOME

echo "Current user [ $USER ] has all the rights to change [ $HOME ] directory and it's file(s)."
${SUDO} chmod 0755 -Rf $HOME

echo "SSH must be with golden permission of SSH way"
${SUDO} chmod 0700 $HOME/.ssh
${SUDO} chmod 0600 $HOME/.ssh/id_rsa*
${SUDO} chmod 0700 $HOME/.ssh/*.pub

echo " Docker related permission..."
if [ -f "/usr/bin/docker" ]; then
	${SUDO} chmod 666 /var/run/docker.sock
	${SUDO} groupadd docker
	${SUDO} usermod -aG docker ${USER}
	if [ -d "$HOME/$USER/.docker" ]; then
		${SUDO} chown "$USER":"$USER" /home/"$USER"/.docker -R
		${SUDO} chmod g+rwx "$HOME/.docker" -R
	fi 
fi

echo "[DONE] Linux home directory permission applied."

exit 1