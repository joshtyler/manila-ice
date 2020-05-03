#!/bin/bash

# Find the serial device that belongs to a manila ice

MANILA_ICE_PROD_ID="7523"
MANILA_ICE_VEND_ID="1a86"

SERIAL=""

# In case there are no ttyUSB devices
shopt -s nullglob

# Try to find the device for 10 seconds
for i in {1..1000}; do
	for F in /dev/ttyUSB*
	do
		PROD_ID=$(udevadm info --name=${F} --attribute-walk | grep idProduct | head -n 1 | cut -d'"' -f2)
		VEND_ID=$(udevadm info --name=${F} --attribute-walk | grep idVendor | head -n 1 | cut -d'"' -f2)
	
		if [[ "${PROD_ID}" == "${MANILA_ICE_PROD_ID}" ]] && [[ "${VEND_ID}" == "${MANILA_ICE_VEND_ID}" ]]; then
			if [[ -z "${SERIAL}" ]]; then
				SERIAL=${F}
			else
				>&2 echo "ERROR: Multiple serial devices found that match manila iCE product and vendor ID. Cannot unambigously identify."
				exit 1
			fi
		fi
	done
	
	if [[ -n "${SERIAL}" ]]; then
		break
	fi
	sleep 0.1
done

if [[ -z "${SERIAL}" ]]; then
	>&2 echo "ERROR: No serial device found that matches manila iCE product and vendor ID."
	exit 1
fi

echo ${SERIAL}
