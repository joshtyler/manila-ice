EESchema Schematic File Version 4
LIBS:hx4k_dev_board-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 4
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 9800 2950 900  1100
U 5D7C5FBE
F0 "FPGA" 50
F1 "FPGA.sch" 50
$EndSheet
$Sheet
S 7500 2850 1150 1200
U 5D7ED7E5
F0 "SDRAM" 50
F1 "SDRAM.sch" 50
F2 "ADDRESS[0..11]" I L 7500 2950 50 
$EndSheet
$Sheet
S 2900 3550 850  450 
U 5D7CE450
F0 "USB_UART" 50
F1 "USB_UART.sch" 50
F2 "USB_DP" B L 2900 3600 50 
F3 "USB_DM" B L 2900 3700 50 
F4 "~UART_CTS" I R 3750 3900 50 
F5 "~UART_RTS" O R 3750 3800 50 
F6 "UART_RX" I R 3750 3700 50 
F7 "UART_TX" O R 3750 3600 50 
$EndSheet
$Comp
L Connector:USB_B_Micro J?
U 1 1 5D7DED67
P 1500 3600
F 0 "J?" H 1557 4067 50  0000 C CNN
F 1 "USB_B_Micro" H 1557 3976 50  0000 C CNN
F 2 "" H 1650 3550 50  0001 C CNN
F 3 "~" H 1650 3550 50  0001 C CNN
	1    1500 3600
	1    0    0    -1  
$EndComp
NoConn ~ 1800 3800
Text Notes 850  4800 0    50   ~ 0
ID pin is disconnected for USB devices.
$Comp
L Device:R R?
U 1 1 5D7E077F
P 1400 4200
F 0 "R?" H 1200 4250 50  0000 L CNN
F 1 "1k" H 1200 4150 50  0000 L CNN
F 2 "" V 1330 4200 50  0001 C CNN
F 3 "~" H 1400 4200 50  0001 C CNN
	1    1400 4200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5D7E0A0B
P 1500 4450
F 0 "#PWR?" H 1500 4200 50  0001 C CNN
F 1 "GND" H 1505 4277 50  0000 C CNN
F 2 "" H 1500 4450 50  0001 C CNN
F 3 "" H 1500 4450 50  0001 C CNN
	1    1500 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 4000 1400 4050
Wire Wire Line
	1400 4350 1400 4400
Wire Wire Line
	1400 4400 1500 4400
Wire Wire Line
	1500 4400 1500 4450
Wire Wire Line
	1500 4000 1500 4400
Connection ~ 1500 4400
Wire Wire Line
	1800 3600 2900 3600
Wire Wire Line
	2900 3700 1800 3700
$Comp
L Regulator_Linear:LM317_3PinPackage U?
U 1 1 5D7EE74A
P 3550 1900
F 0 "U?" H 3550 2142 50  0000 C CNN
F 1 "LM317_3PinPackage" H 3550 2051 50  0000 C CNN
F 2 "" H 3550 2150 50  0001 C CIN
F 3 "http://www.ti.com/lit/ds/symlink/lm317.pdf" H 3550 1900 50  0001 C CNN
	1    3550 1900
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 5D7EF43A
P 2900 2100
F 0 "C?" H 3015 2146 50  0000 L CNN
F 1 "100n" H 3015 2055 50  0000 L CNN
F 2 "" H 2938 1950 50  0001 C CNN
F 3 "~" H 2900 2100 50  0001 C CNN
	1    2900 2100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 5D7EFA4C
P 4600 2100
F 0 "C?" H 4715 2146 50  0000 L CNN
F 1 "1u" H 4715 2055 50  0000 L CNN
F 2 "" H 4638 1950 50  0001 C CNN
F 3 "~" H 4600 2100 50  0001 C CNN
	1    4600 2100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5D7EFDBD
P 2900 2300
F 0 "#PWR?" H 2900 2050 50  0001 C CNN
F 1 "GND" H 2905 2127 50  0000 C CNN
F 2 "" H 2900 2300 50  0001 C CNN
F 3 "" H 2900 2300 50  0001 C CNN
	1    2900 2300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5D7F00F8
P 4600 2300
F 0 "#PWR?" H 4600 2050 50  0001 C CNN
F 1 "GND" H 4605 2127 50  0000 C CNN
F 2 "" H 4600 2300 50  0001 C CNN
F 3 "" H 4600 2300 50  0001 C CNN
	1    4600 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 2250 2900 2300
Wire Wire Line
	2900 1950 2900 1900
Wire Wire Line
	2900 1900 3250 1900
Wire Wire Line
	3850 1900 3950 1900
Wire Wire Line
	4600 1900 4600 1950
Wire Wire Line
	4600 2250 4600 2300
Wire Wire Line
	2200 3400 2200 1900
Wire Wire Line
	2200 1900 2900 1900
Connection ~ 2900 1900
Text Label 2300 1900 2    50   ~ 0
5V
$Comp
L power:+3.3V #PWR?
U 1 1 5D7F1786
P 4600 1850
F 0 "#PWR?" H 4600 1700 50  0001 C CNN
F 1 "+3.3V" H 4615 2023 50  0000 C CNN
F 2 "" H 4600 1850 50  0001 C CNN
F 3 "" H 4600 1850 50  0001 C CNN
	1    4600 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 1850 4600 1900
Connection ~ 4600 1900
$Comp
L power:PWR_FLAG #FLG?
U 1 1 5D7F1F49
P 2000 3350
F 0 "#FLG?" H 2000 3425 50  0001 C CNN
F 1 "PWR_FLAG" H 2000 3523 50  0000 C CNN
F 2 "" H 2000 3350 50  0001 C CNN
F 3 "~" H 2000 3350 50  0001 C CNN
	1    2000 3350
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG?
U 1 1 5D7F4E86
P 4150 1850
F 0 "#FLG?" H 4150 1925 50  0001 C CNN
F 1 "PWR_FLAG" H 4150 2023 50  0000 C CNN
F 2 "" H 4150 1850 50  0001 C CNN
F 3 "~" H 4150 1850 50  0001 C CNN
	1    4150 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 1850 4150 1900
Connection ~ 4150 1900
Wire Wire Line
	4150 1900 4600 1900
Wire Wire Line
	2000 3350 2000 3400
Connection ~ 2000 3400
Wire Wire Line
	2000 3400 2200 3400
Wire Wire Line
	1800 3400 2000 3400
$Comp
L Device:R R?
U 1 1 5D7F8287
P 3950 2100
F 0 "R?" H 4020 2146 50  0000 L CNN
F 1 "3k6" H 4020 2055 50  0000 L CNN
F 2 "" V 3880 2100 50  0001 C CNN
F 3 "~" H 3950 2100 50  0001 C CNN
	1    3950 2100
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5D7F8882
P 3950 2500
F 0 "R?" H 4020 2546 50  0000 L CNN
F 1 "2k2" H 4020 2455 50  0000 L CNN
F 2 "" V 3880 2500 50  0001 C CNN
F 3 "~" H 3950 2500 50  0001 C CNN
	1    3950 2500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5D7F8C11
P 3950 2700
F 0 "#PWR?" H 3950 2450 50  0001 C CNN
F 1 "GND" H 3955 2527 50  0000 C CNN
F 2 "" H 3950 2700 50  0001 C CNN
F 3 "" H 3950 2700 50  0001 C CNN
	1    3950 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3950 1950 3950 1900
Connection ~ 3950 1900
Wire Wire Line
	3950 1900 4150 1900
Wire Wire Line
	3950 2250 3950 2300
Wire Wire Line
	3950 2650 3950 2700
Wire Wire Line
	3550 2200 3550 2300
Wire Wire Line
	3550 2300 3950 2300
Connection ~ 3950 2300
Wire Wire Line
	3950 2300 3950 2350
Text Notes 3200 2700 0    50   ~ 0
Vadj is 1.25V
Text Notes 2750 1450 0    50   ~ 0
LM317 decoupling is from datasheet.
$EndSCHEMATC
