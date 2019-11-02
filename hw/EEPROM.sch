EESchema Schematic File Version 4
LIBS:manila_ice-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 9 11
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
L Memory_EEPROM:M24C01-RMN U8
U 1 1 5DAA4F4F
P 5600 3400
F 0 "U8" H 5350 3650 50  0000 C CNN
F 1 "M24C01-RMN" H 5950 3650 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 5600 3750 50  0001 C CNN
F 3 "http://www.st.com/content/ccc/resource/technical/document/datasheet/b0/d8/50/40/5a/85/49/6f/DM00071904.pdf/files/DM00071904.pdf/jcr:content/translations/en.DM00071904.pdf" H 5650 2900 50  0001 C CNN
F 4 "-90" H 5350 3750 50  0001 C CNN "JLCPCB Rotation"
F 5 "C79988" H 5600 3400 50  0001 C CNN "LCSC Part"
	1    5600 3400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0130
U 1 1 5DAA54F8
P 5150 3800
F 0 "#PWR0130" H 5150 3550 50  0001 C CNN
F 1 "GND" H 5155 3627 50  0000 C CNN
F 2 "" H 5150 3800 50  0001 C CNN
F 3 "" H 5150 3800 50  0001 C CNN
	1    5150 3800
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0131
U 1 1 5DAA6A4A
P 5600 3050
F 0 "#PWR0131" H 5600 2900 50  0001 C CNN
F 1 "+3.3V" H 5615 3223 50  0000 C CNN
F 2 "" H 5600 3050 50  0001 C CNN
F 3 "" H 5600 3050 50  0001 C CNN
	1    5600 3050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 5DB59EF2
P 4500 3250
AR Path="/5DB59EF2" Ref="C?"  Part="1" 
AR Path="/5D7E2E67/5DB59EF2" Ref="C?"  Part="1" 
AR Path="/5D7C5FBE/5DB59EF2" Ref="C?"  Part="1" 
AR Path="/5DAA4BA2/5DB59EF2" Ref="C38"  Part="1" 
F 0 "C38" H 4615 3296 50  0000 L CNN
F 1 "100n" H 4615 3205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 4538 3100 50  0001 C CNN
F 3 "~" H 4500 3250 50  0001 C CNN
F 4 "0" H 4615 3396 50  0001 C CNN "JLCPCB Rotation"
F 5 "C14663" H 4615 3396 50  0001 C CNN "LCSC Part"
	1    4500 3250
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5DB59EF8
P 4500 3050
AR Path="/5D7C5FBE/5DB59EF8" Ref="#PWR?"  Part="1" 
AR Path="/5DAA4BA2/5DB59EF8" Ref="#PWR0132"  Part="1" 
F 0 "#PWR0132" H 4500 2900 50  0001 C CNN
F 1 "+3V3" H 4515 3223 50  0000 C CNN
F 2 "" H 4500 3050 50  0001 C CNN
F 3 "" H 4500 3050 50  0001 C CNN
	1    4500 3050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5DB59EFE
P 4500 3450
AR Path="/5D7C5FBE/5DB59EFE" Ref="#PWR?"  Part="1" 
AR Path="/5DAA4BA2/5DB59EFE" Ref="#PWR0133"  Part="1" 
F 0 "#PWR0133" H 4500 3200 50  0001 C CNN
F 1 "GND" H 4505 3277 50  0000 C CNN
F 2 "" H 4500 3450 50  0001 C CNN
F 3 "" H 4500 3450 50  0001 C CNN
	1    4500 3450
	1    0    0    -1  
$EndComp
Text HLabel 6450 3300 2    50   BiDi ~ 0
SDA
Text HLabel 6450 3400 2    50   BiDi ~ 0
SCL
Text Notes 4600 2300 0    50   ~ 0
TODO: Change for real part: M24C64-RMN6TP\nJLC C79988
Wire Wire Line
	5200 3300 5150 3300
Wire Wire Line
	5150 3300 5150 3400
Wire Wire Line
	5200 3400 5150 3400
Wire Wire Line
	5150 3400 5150 3500
Wire Wire Line
	5200 3500 5150 3500
Wire Wire Line
	5150 3500 5150 3750
Wire Wire Line
	5600 3700 5600 3750
Wire Wire Line
	5600 3750 5150 3750
Wire Wire Line
	5150 3750 5150 3800
Wire Wire Line
	5600 3050 5600 3100
Wire Wire Line
	6000 3500 6050 3500
Wire Wire Line
	6050 3500 6050 3750
Wire Wire Line
	6050 3750 5600 3750
Wire Wire Line
	6000 3400 6450 3400
Wire Wire Line
	6000 3300 6450 3300
Wire Wire Line
	4500 3400 4500 3450
Wire Wire Line
	4500 3050 4500 3100
Connection ~ 5150 3400
Connection ~ 5150 3500
Connection ~ 5150 3750
Connection ~ 5600 3750
$EndSCHEMATC
