#! /bin/bash
# ---------------------------------------------------------------------------
# check_website - Checks a website for existence of text and will email when found. Meant to be run as part of a cron job.

# Copyright 2016,  Neil Grogan
# All rights reserved.

# Usage: check_website [-h|--help] [-d|--debug] [-q|--quiet] [-v|--verbosity verbosity_level] [-l|--log log_file]

# Revision history:
# 2016-02-22	Created 
# ---------------------------------------------------------------------------

PROGNAME=${0##*/}
VERSION="0.1"

## PUT FUNCTIONS HERE AND ADD TO main()

main(){
	check_args
	check_website
}

check_args(){
	debug "Checking Email, URL and Text to Find are not empty"
	if [[ -z $email || -z $url || -z $txt_to_find ]]; then
		error "You are missing a required argument, please see usage:"
		echo "$(usage)"
		exit 1
	fi
}

check_website(){
	debug "EMAIL is $email, url is $url, text to find is $txt_to_find"
	if grep -q "$txt_to_find" <(curl -v "$url" | tac | tac); then
		debug "found text: $txt_to_find, on Website: $url"
		mail -s "Found text: $txt_to_find on Website: $url" "$email"  </dev/null
	else
		debug "Didn't find text: $txt_to_find, on Website: $url"
	fi
}

## END of Script Specific Code

clean_up() { # Perform pre-exit housekeeping
	debug "Cleaning up..."
	return
}

error_exit() {
	error "${PROGNAME}: ${1:-"Unknown Error"}" >&2
	clean_up
	exit 1
}

graceful_exit() {
	clean_up
	debug "...Finished"
	exit
}

signal_exit() { # Handle trapped signals
	case $1 in
		INT)    error_exit "Program interrupted by user" ;;
		TERM)   echo -e "\n$PROGNAME: Program terminated" >&2 ; graceful_exit ;;
		*)      error_exit "$PROGNAME: Terminating on unknown signal" ;;
	esac
}

require() { 
    if command -v $1 >/dev/null; then
      debug ""$1" found in path!"
    else
      error ""$1" is not in your path. Please set the PATH correctly."
      exit 0
    fi
}

usage() {
	echo -e "Usage: $PROGNAME [-f|--find] <text_to_find> [-u|--url] <url_to_check> [-e|--email] <email_to_notify>"
}

# Set Colour Variables
# Usage: FBLK (front Black), BRED (Background Red), TBLD (Text Bold)
set_colours() {
  local COLOURS=(BLK RED GRN YLW BLU MAG CYN WHT)
  local i SGRS=(RST BLD DIM ITA UND BLINK ___ INV)
  for (( i=0; i<8; i++ )); do
    eval "F${COLOURS[i]}=\"\e[3${i}m\""
    eval "FL${COLOURS[i]}=\"\e[9${i}m\""
    eval "B${COLOURS[i]}=\"\e[4${i}m\""
    eval "BL${COLOURS[i]}=\"\e[10${i}m\""
    eval   "T${SGRS[i]}=\"\e[${i}m\""
  done
}

# Set Logging
exec 3>&2 # logging stream (file descriptor 3) defaults to STDERR
silent_lvl=0; err_lvl=1; wrn_lvl=2; dbg_lvl=3; inf_lvl=4 # Set logging levels
notify() { log $silent_lvl "${TBLD}[NOTE]:${TRST} $1"; } # Always prints
error() { log $err_lvl "${TRST}${FRED}${TBLD}[ERROR]: ${TRST}${FRED}$1${TRST}"; }
warn() { log $wrn_lvl "${TRST}${FYLW}${TBLD}[WARNING]:${TRST} $1"; }
debug() { log $dbg_lvl "${TRST}${FCYN}${TBLD}[DEBUG]:${TRST} $1"; }
inf() { log $inf_lvl "${TRST}${FWHT}${TBLD}[INFO]:${TRST} $1"; } # "info" is already a command
log() {
	if [ -z $ver_lvl ]; then ver_lvl=2; fi # default to show warnings
    if [ $ver_lvl -ge $1 ]; then
        # Expand escaped characters, wrap at 70 chars, indent wrapped lines
        printf "$NOW $2\n" | fold -w70 -s >&3 #| sed '2~1s/^/  /' >&3
    fi
}

help_message() {
	cat <<- _EOF_
	$PROGNAME ver. $VERSION
	Checks a website for existence of text and will email when found. Meant to be run as part of a cron job.

	$(usage)

	Options:
	-h, --help	Display this help message and exit.
	-d, --debug	Turn debug on
	-q, --quiet	Turn quietness on
	-v, --verbosity verbosity_level	Set verbosity
		Where 'verbosity_level' is the numeric level (0-4) of verbosity.
	-l, --log log_file	Set log file
		Where 'log_file' is the name of the log file.

	_EOF_
	return
}

# Trap signals
trap "signal_exit TERM" TERM HUP
trap "signal_exit INT"  INT



# Parse command-line
while [[ -n $1 ]]; do
	case $1 in
		-d | --debug)	ver_lvl=$dbg_lvl; shift ;;
		-e | --email)	email=$2; shift ;;
		-f | --find)	txt_to_find=$2; shift ;;
		-h | --help)	help_message; graceful_exit ;;
		-q | --quiet)	ver_lvl=$err_lvl; shift ;;
		-u | --url)	url=$2; shift ;;
		-v | --verbosity)	ver_lvl=$2; shift ;;
		-l | --logfile)	log_file=$2; NOW=$(date +"%d-%m-%Y %H:%M:%S"); exec 3>>$2; shift ;;
		-* | --*)	usage; error_exit "Unknown option $1" ;;
		*)		echo "Argument $1 to process..." ;;
	esac
	shift
done


startup(){
	if [ -z $log_file ]; then set_colours; fi # if no log file, set colours
	debug "$PROGNAME ver. $VERSION run by $USER"
	debug "Verbosity level set at $ver_lvl"
	# Source Config File
	if [[ -e ~/."$filename".conf ]]; then source ~/."$filename".conf
	elif [[ -e /etc/"$filename".conf ]]; then source /etc/"$filename".conf
	fi
}

# Main logic
startup
main
graceful_exit

