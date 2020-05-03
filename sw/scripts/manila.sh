#!/bin/bash

# Univeral tool for managing manila iCE bootloader
set -e


if [ $# -lt 1 ]; then
	echo "Usage: $0 [action] .."
	exit 1
fi

ACTION=$1

shift

case ${ACTION} in
	prog)
		if [ $# -ne 2 ]; then
			echo "Expected args: [slot #] [file to program]"
			exit 1
		fi
		SLOT=$1
		FILE=$2
		shift
		ADDR=$((0x40000 * ${SLOT}))
		SERIAL=$(./findserial.sh)
		./identify.sh ${SERIAL}
		../spi_prog/spi_prog -m wbuart --uartdev ${SERIAL} --baud 460800 --compaddr 0 -w -v -a ${ADDR} -i ${FILE}
		;;
	*)
		echo "Unknown action: $1"
		exit 1
		;;
esac
