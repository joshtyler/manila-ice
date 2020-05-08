#!/bin/bash

# Universal tool for managing manila iCE bootloader
set -e

if [ $# -lt 1 ]; then
	printf "Usage: $0 [action] ..\n"
	printf "Supported actions:\n"
	printf "\tprog (program)\n"
	exit 1
fi

ACTION=$1
shift
# Get the real path of the script
SCRIPT_PATH=$(dirname $(readlink -f $0))

prog_help()
{
	printf "Usage for prog action:\n"
	printf "\t$0 prog [optional arguments] [filename]\n"
	printf "Acceptable optional arguments for prog action:\n"
	printf "\t -s [slot number] The slot in flash to program (default is slot 1)\n"
	printf "\t -d [serial device] The path to the serial device (default is auto detect)\n"
	printf "\t -u  Skip the unlock/identify step. Assume the device is already present and unlocked\n"
}

case ${ACTION} in
	prog)
		# Set default arguments
		SLOT="1"
		SERIAL=""
		UNLOCK=true
		while getopts s:d:u opt ; do
			case "$opt" in
				s) SLOT="$OPTARG";;
				d) SERIAL="$OPTARG";;
				u) UNLOCK=false;;
				[?])
					printf "Unknown optional argument.\n"
					prog_help
					exit 1
					;;
			esac
		done
		shift $((OPTIND-1))
		if [ $# -ne 1 ]; then
			printf "Missing compulsory argument.\n"
			prog_help
			exit 1
		fi
		# Read file
		FILE=$1
		shift

		ADDR=$((0x40000 * ${SLOT}))

		# Auto detect the serial if the user didn't provide it
		if [[ -z ${SERIAL} ]]; then
			printf "Finding serial device\n"
			SERIAL=$(${SCRIPT_PATH}/findserial.sh)
			printf "Found likely manila iCE at ${SERIAL}\n"
		fi

		# Identify and unlock the board
		if [[ ${UNLOCK} = true ]]; then
			printf "Identifying and unlocking the board\n"
			${SCRIPT_PATH}/identify.sh ${SERIAL}
		fi

		# Program the board
		printf "Programming the board\n"
		${SCRIPT_PATH}/spi_prog -m wbuart --uartdev ${SERIAL} --baud 460800 --compaddr 0 -w -v -a ${ADDR} -i ${FILE}
		;;
	*)
		printf "Unknown action: $1\n"
		exit 1
		;;
esac
