#!/bin/bash

# Check that a connected board is a manila iCE
# If it is, unlock it

if [ $# -ne 1 ]; then
	echo "Usage: $0 [serial port]"
	exit 1
fi

SERIAL=$1
BAUD=460800
MAGIC='#!manilamagic!#'
IDENT_STR="Manila iCE bootloader v1.0.0"

# Disable echo to minimise the garbage bytes we send out
# It seems unavoidable on linux to send out some, since what is in the buffer will be echoed back on opening the port
stty -F ${SERIAL} -echo

# Set baud
stty -F ${SERIAL} ${BAUD}

# Read the identification string
# We do it this way to get past any stale data that may have filled the buffer
# If we don't do this, I empirically find the first 60 bytes are stale
IDENT=$(timeout 2s head -n 20 ${SERIAL} | tail -n 1)

if [[ "${IDENT}" == "${IDENT_STR}" ]]; then
	echo "Successfully found ${IDENT}"
	# Unlock
	echo -n ${MAGIC} > ${SERIAL}
else
	echo "ERROR: Unknown device ${IDENT}"
	exit 1
fi
