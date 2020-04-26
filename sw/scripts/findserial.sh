#!/bin/bash

# Find the serial device that belongs to a manila ice

MANILA_ICE_PROD_ID="7523"
MANILA_ICE_VEND_ID="1a86"

SERIAL=""

# In case there are no ttyUSB devices
shopt -s nullglob

for F in /dev/ttyUSB*
do
	PROD_ID=$(udevadm info --name=${F} --attribute-walk | grep idProduct | head -n 1 | cut -d'"' -f2)
	VEND_ID=$(udevadm info --name=${F} --attribute-walk | grep idVendor | head -n 1 | cut -d'"' -f2)

	if [[ "${PROD_ID}" == "${MANILA_ICE_PROD_ID}" ]] && [[ "${VEND_ID}" == "${MANILA_ICE_VEND_ID}" ]]; then
		if [[ -z "${SERIAL}" ]]; then
			SERIAL=${F}
		else
			>&2 echo "Multiple serial devices found that match manila iCE product and vendor ID. Cannot unambigously identify. Exiting"
			exit 1
		fi
	fi
done

if [[ -z "${SERIAL}" ]]; then
	>&2 echo "No serial device found that matches manila iCE product and vendor ID. Exiting"
	exit 1
fi

echo ${SERIAL}
