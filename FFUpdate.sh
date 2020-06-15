#!/bin/bash

clear

print_step_begin() {
	echo -e "\e[32m\e[1m==> $1\e[0m"
}

check_deps() {
	echo "Checking wget"
	command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed.  Aborting."; exit 1; }
	echo "Checking cp"
	command -v cp > /dev/null 2>&1 || { echo >&2 "I require cp but it's not installed.  Aborting."; exit 1; }
	echo "Checking tar"
	command -v tar > /dev/null 2>&1 || { echo >&2 "I require tar but it's not installed.  Aborting."; exit 1; }
}

dl_latest() {
	cd /tmp
	rm -f "firefox-nightly-latest.tar.bz2"
	wget -O "firefox-nightly-latest.tar.bz2" "https://download.mozilla.org/?product=firefox-nightly-latest-l10n-ssl&os=linux64&lang=de"
}

ext_latest() {
	rm -rf "firefox-nightly-latest"
	tar -xjf "firefox-nightly-latest.tar.bz2"	
}

rm_old() {
	killall firefox-bin &> /dev/null
	cd /opt
	rm -rf firefox-nightly-latest
}

print_step_begin "Checking dependencies"
check_deps

print_step_begin "Downloading lastest release"
dl_latest

print_step_begin "Extracting release"
ext_latest

print_step_begin "Removing old version"
rm_old

print_step_begin "Copying new version"
sudo cp -rf /tmp/firefox /opt

print_step_begin "Done!"
