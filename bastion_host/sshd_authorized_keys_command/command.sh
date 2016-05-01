#!/usr/bin/env bash

config_file="$(pwd)/config"
sub_command="$(pwd)/command_with_ssh_bastion.sh"


# ref http://unix.stackexchange.com/questions/175648/use-config-file-for-my-shell-script

typeset -A config

config=(
  [user]="developer"
)

while read line
do
  if echo $line | grep -F = &>/dev/null
  then
    varname=$(echo "$line" | cut -d '=' -f 1)
    config[$varname]=$(echo "$line" | cut -d '=' -f 2-)
  fi
done < $config_file

if [ "$1" == "${config[user]}" ]; then
  . $sub_command
fi
