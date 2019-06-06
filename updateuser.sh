#!/bin/bash
$user = `egrep '1[0-9]{3}' /etc/passwd | cut -d \: -f1`
apt update && adduser $user sudo
su - $user
