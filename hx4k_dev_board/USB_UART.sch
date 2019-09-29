EESchema Schematic File Version 4
LIBS:hx4k_dev_board-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 9
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Interface_USB:CH340E U?
U 1 1 5D7CE99F
P 5650 4050
F 0 "U?" H 5400 4600 50  0000 C CNN
F 1 "CH340E" H 5900 4600 50  0000 C CNN
F 2 "Package_SO:MSOP-10_3x3mm_P0.5mm" H 5700 3500 50  0001 L CNN
F 3 "https://www.mpja.com/download/35227cpdata.pdf" H 5300 4850 50  0001 C CNN
	1    5650 4050
	1    0    0    -1  
$EndComp
Text HLabel 4700 3950 0    50   BiDi ~ 0
USB_DP
Text HLabel 4700 4050 0    50   BiDi ~ 0
USB_DM
Wire Wire Line
	4700 3950 5250 3950
Wire Wire Line
	5250 4050 4700 4050
Text HLabel 6200 3950 2    50   Input ~ 0
~UART_CTS
Text HLabel 6200 4450 2    50   Output ~ 0
~UART_RTS
Wire Wire Line
	6050 3650 6200 3650
Wire Wire Line
	6200 3750 6050 3750
Wire Wire Line
	6050 3950 6200 3950
Wire Wire Line
	6200 4450 6050 4450
$Comp
L power:GND #PWR?
U 1 1 5D7D3316
P 5650 4700
F 0 "#PWR?" H 5650 4450 50  0001 C CNN
F 1 "GND" H 5655 4527 50  0000 C CNN
F 2 "" H 5650 4700 50  0001 C CNN
F 3 "" H 5650 4700 50  0001 C CNN
	1    5650 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5650 4650 5650 4700
Text Notes 4600 5800 0    50   ~ 0
TNOW is an active high status output to show that transmission is in progress. (Datasheet p.3)\nIt is not clear how much current it can provide, but should be okay with 1.5mA for an LED.
Text HLabel 6200 3750 2    50   Input ~ 0
UART_RX
Wire Wire Line
	6850 4600 6850 4650
$Comp
L Device:R R?
U 1 1 5D7D0D58
P 6850 4450
F 0 "R?" H 6920 4496 50  0000 L CNN
F 1 "1k" H 6920 4405 50  0000 L CNN
F 2 "" V 6780 4450 50  0001 C CNN
F 3 "~" H 6850 4450 50  0001 C CNN
	1    6850 4450
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D?
U 1 1 5D7CFA7C
P 6850 4800
F 0 "D?" V 6889 4683 50  0000 R CNN
F 1 "LED" V 6798 4683 50  0000 R CNN
F 2 "" H 6850 4800 50  0001 C CNN
F 3 "~" H 6850 4800 50  0001 C CNN
	1    6850 4800
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5D7D83DF
P 6850 5000
F 0 "#PWR?" H 6850 4750 50  0001 C CNN
F 1 "GND" H 6855 4827 50  0000 C CNN
F 2 "" H 6850 5000 50  0001 C CNN
F 3 "" H 6850 5000 50  0001 C CNN
	1    6850 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6850 4950 6850 5000
Text Notes 4900 2450 0    50   ~ 0
The chip supports both 5V and 3V3 operation.\nFor 3V3 operation. VCC connects to V3. (Datasheet p.4)
$Comp
L power:+3V3 #PWR?
U 1 1 5D7DBD9C
P 5650 3350
F 0 "#PWR?" H 5650 3200 50  0001 C CNN
F 1 "+3V3" H 5665 3523 50  0000 C CNN
F 2 "" H 5650 3350 50  0001 C CNN
F 3 "" H 5650 3350 50  0001 C CNN
	1    5650 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5550 3450 5550 3400
Wire Wire Line
	5550 3400 5650 3400
Wire Wire Line
	5650 3400 5650 3350
Wire Wire Line
	5650 3450 5650 3400
Connection ~ 5650 3400
Text Notes 4900 2950 0    50   ~ 0
Datasheet requests 0.1uF decoupling cap (p.2)
$Comp
L Device:C C?
U 1 1 5D7DCA49
P 4400 3150
F 0 "C?" H 4515 3196 50  0000 L CNN
F 1 "100n" H 4515 3105 50  0000 L CNN
F 2 "" H 4438 3000 50  0001 C CNN
F 3 "~" H 4400 3150 50  0001 C CNN
	1    4400 3150
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5D7DCD2D
P 4400 2950
F 0 "#PWR?" H 4400 2800 50  0001 C CNN
F 1 "+3V3" H 4415 3123 50  0000 C CNN
F 2 "" H 4400 2950 50  0001 C CNN
F 3 "" H 4400 2950 50  0001 C CNN
	1    4400 2950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5D7DD32D
P 4400 3350
F 0 "#PWR?" H 4400 3100 50  0001 C CNN
F 1 "GND" H 4405 3177 50  0000 C CNN
F 2 "" H 4400 3350 50  0001 C CNN
F 3 "" H 4400 3350 50  0001 C CNN
	1    4400 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 2950 4400 3000
Wire Wire Line
	4400 3300 4400 3350
Text HLabel 6200 3650 2    50   Output ~ 0
UART_TX
Wire Wire Line
	6050 4250 6850 4250
Wire Wire Line
	6850 4250 6850 4300
$EndSCHEMATC
