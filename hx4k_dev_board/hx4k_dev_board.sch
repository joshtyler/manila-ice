EESchema Schematic File Version 4
LIBS:hx4k_dev_board-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 9
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
S 7200 1000 750  1300
U 5D7ED7E5
F0 "SDRAM" 50
F1 "SDRAM.sch" 50
F2 "ADDRESS[0..11]" I L 7200 1250 50 
F3 "DATA[0..15]" B L 7200 1150 50 
F4 "BS[0..1]" I L 7200 1350 50 
F5 "~CS" I L 7200 1450 50 
F6 "CKE" I L 7200 1550 50 
F7 "CLK" I L 7200 1650 50 
F8 "LDQM" I L 7200 1750 50 
F9 "UDQM" I L 7200 1850 50 
F10 "~WE" I L 7200 1950 50 
F11 "~CAS" I L 7200 2050 50 
F12 "~RAS" I L 7200 2150 50 
$EndSheet
$Sheet
S 3000 1750 850  450 
U 5D7CE450
F0 "USB_UART" 50
F1 "USB_UART.sch" 50
F2 "USB_DP" B L 3000 1800 50 
F3 "USB_DM" B L 3000 1900 50 
F4 "~UART_CTS" I R 3850 2100 50 
F5 "~UART_RTS" O R 3850 2000 50 
F6 "UART_RX" I R 3850 1900 50 
F7 "UART_TX" O R 3850 1800 50 
$EndSheet
$Comp
L Device:R R1
U 1 1 5D7E077F
P 1500 2400
F 0 "R1" H 1300 2450 50  0000 L CNN
F 1 "1k" H 1300 2350 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 1430 2400 50  0001 C CNN
F 3 "~" H 1500 2400 50  0001 C CNN
	1    1500 2400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 5D7E0A0B
P 1600 2650
F 0 "#PWR01" H 1600 2400 50  0001 C CNN
F 1 "GND" H 1605 2477 50  0000 C CNN
F 2 "" H 1600 2650 50  0001 C CNN
F 3 "" H 1600 2650 50  0001 C CNN
	1    1600 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 2200 1500 2250
Wire Wire Line
	1500 2550 1500 2600
Wire Wire Line
	1500 2600 1600 2600
Wire Wire Line
	1600 2600 1600 2650
Wire Wire Line
	1600 2200 1600 2600
Connection ~ 1600 2600
Wire Wire Line
	1900 1800 3000 1800
Wire Wire Line
	3000 1900 1900 1900
Text Label 3350 1250 2    50   ~ 0
5V
$Sheet
S 3450 1150 550  200 
U 5D7E2E67
F0 "POWER" 50
F1 "POWER.sch" 50
F2 "VIN" U L 3450 1250 50 
$EndSheet
Wire Wire Line
	2950 1600 2950 1250
Wire Wire Line
	2950 1250 3050 1250
$Comp
L Device:Ferrite_Bead FB1
U 1 1 5D80AD16
P 2650 1600
F 0 "FB1" V 2376 1600 50  0000 C CNN
F 1 "GZ2012D101TF" V 2467 1600 50  0000 C CNN
F 2 "Inductor_SMD:L_0805_2012Metric" V 2580 1600 50  0001 C CNN
F 3 "~" H 2650 1600 50  0001 C CNN
	1    2650 1600
	0    1    1    0   
$EndComp
Wire Wire Line
	2950 1600 2800 1600
Wire Bus Line
	7000 1150 7200 1150
Wire Bus Line
	7200 1250 7000 1250
Wire Bus Line
	7000 1350 7200 1350
Wire Wire Line
	7200 1450 7000 1450
Wire Wire Line
	7000 1550 7200 1550
Wire Wire Line
	7000 1650 7200 1650
Wire Wire Line
	7000 1750 7200 1750
Wire Wire Line
	7200 1850 7000 1850
Wire Wire Line
	7000 1950 7200 1950
Wire Wire Line
	7200 2050 7000 2050
Wire Wire Line
	7000 2150 7200 2150
Wire Wire Line
	3850 1800 5250 1800
Wire Wire Line
	5250 1900 3850 1900
Wire Wire Line
	3850 2000 5250 2000
Wire Wire Line
	5250 2100 3850 2100
$Sheet
S 7200 2550 750  1700
U 5E257EC5
F0 "ETHERNET" 50
F1 "ETHERNET.sch" 50
F2 "GTXCLK" I L 7200 2650 50 
F3 "TXCLK" O L 7200 2750 50 
F4 "TXD[0..7]" I L 7200 2850 50 
F5 "TXEN" I L 7200 2950 50 
F6 "TXER" I L 7200 3050 50 
F7 "RXCLK" O L 7200 3200 50 
F8 "RXD[0..7]" O L 7200 3300 50 
F9 "RXDV" O L 7200 3400 50 
F10 "RXER" O L 7200 3500 50 
F11 "COL" O L 7200 3600 50 
F12 "CS" O L 7200 3700 50 
F13 "MDC" I L 7200 3850 50 
F14 "MDIO" B L 7200 3950 50 
F15 "~PME_INT" O L 7200 4050 50 
F16 "~PHYRST" I L 7200 4150 50 
$EndSheet
$Sheet
S 5250 1000 1750 4700
U 5D7C5FBE
F0 "FPGA" 50
F1 "FPGA.sch" 50
F2 "UART_TX" O L 5250 1900 50 
F3 "UART_RX" I L 5250 1800 50 
F4 "~UART_RTS" I L 5250 2000 50 
F5 "RAM_DATA[0..15]" B R 7000 1150 50 
F6 "RAM_ADDRESS[0..11]" O R 7000 1250 50 
F7 "RAM_BS[0..1]" O R 7000 1350 50 
F8 "~RAM_CS" O R 7000 1450 50 
F9 "RAM_CKE" O R 7000 1550 50 
F10 "RAM_CLK" O R 7000 1650 50 
F11 "RAM_LDQM" O R 7000 1750 50 
F12 "RAM_UDQM" O R 7000 1850 50 
F13 "~RAM_WE" O R 7000 1950 50 
F14 "~RAM_CAS" O R 7000 2050 50 
F15 "~RAM_RAS" O R 7000 2150 50 
F16 "ETH_GTXCLK" O R 7000 2650 50 
F17 "ETH_TXCLK" I R 7000 2750 50 
F18 "ETH_TXD[0..7]" O R 7000 2850 50 
F19 "ETH_TXEN" O R 7000 2950 50 
F20 "ETH_TXER" O R 7000 3050 50 
F21 "RXCLK" I R 7000 3200 50 
F22 "ETH_RXD[0..7]" I R 7000 3300 50 
F23 "ETH_RXDV" I R 7000 3400 50 
F24 "ETH_RXER" I R 7000 3500 50 
F25 "ETH_MDC" O R 7000 3850 50 
F26 "ETH_MDIO" B R 7000 3950 50 
F27 "~ETH_PME_INT" I R 7000 4050 50 
F28 "~ETH_PHYRST" O R 7000 4150 50 
F29 "PMODA[0..7]" B R 7000 4550 50 
F30 "PMODB[0..7]" B R 7000 4950 50 
F31 "ETH_COL" I R 7000 3600 50 
F32 "ETH_CS" I R 7000 3700 50 
F33 "UART_CTS" O L 5250 2100 50 
F34 "LED[0..7]" O R 7000 5350 50 
$EndSheet
Wire Wire Line
	7000 2650 7200 2650
Wire Wire Line
	7000 2750 7200 2750
Wire Bus Line
	7000 2850 7200 2850
Wire Wire Line
	7200 2950 7000 2950
Wire Wire Line
	7000 3050 7200 3050
Wire Wire Line
	7200 3200 7000 3200
Wire Bus Line
	7000 3300 7200 3300
Wire Wire Line
	7200 3400 7000 3400
Wire Wire Line
	7000 3500 7200 3500
Wire Wire Line
	7200 3600 7000 3600
Wire Wire Line
	7000 3700 7200 3700
Wire Wire Line
	7200 3850 7000 3850
Wire Wire Line
	7000 3950 7200 3950
Wire Wire Line
	7200 4050 7000 4050
Wire Wire Line
	7000 4150 7200 4150
$Sheet
S 7200 4450 550  200 
U 5EA5DA36
F0 "PMODA" 50
F1 "PMOD.sch" 50
F2 "DATA[0.7]" B L 7200 4550 50 
$EndSheet
$Sheet
S 7200 4850 550  200 
U 5EA6C61B
F0 "PMODB" 50
F1 "PMOD.sch" 50
F2 "DATA[0.7]" B L 7200 4950 50 
$EndSheet
Wire Bus Line
	7000 4550 7200 4550
Wire Bus Line
	7200 4950 7000 4950
$Sheet
S 7200 5250 550  200 
U 5EA6F132
F0 "LEDS" 50
F1 "LEDS.sch" 50
F2 "LEDS[0..7]" I L 7200 5350 50 
$EndSheet
Wire Bus Line
	7000 5350 7200 5350
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5EA70B34
P 3050 1200
F 0 "#FLG01" H 3050 1275 50  0001 C CNN
F 1 "PWR_FLAG" H 3050 1373 50  0000 C CNN
F 2 "" H 3050 1200 50  0001 C CNN
F 3 "~" H 3050 1200 50  0001 C CNN
	1    3050 1200
	1    0    0    -1  
$EndComp
Connection ~ 3050 1250
Wire Wire Line
	3050 1250 3450 1250
Wire Wire Line
	3050 1200 3050 1250
Wire Wire Line
	1900 1600 2300 1600
$Comp
L Connector:USB_B J1
U 1 1 5DB0A8C9
P 1600 1800
F 0 "J1" H 1657 2267 50  0000 C CNN
F 1 "USB_B" H 1657 2176 50  0000 C CNN
F 2 "Connector_USB:USB_B_OST_USB-B1HSxx_Horizontal" H 1750 1750 50  0001 C CNN
F 3 " ~" H 1750 1750 50  0001 C CNN
	1    1600 1800
	1    0    0    -1  
$EndComp
Text Label 2150 1800 0    50   ~ 0
USB_D_P
Text Label 2150 1900 0    50   ~ 0
USB_D_N
$Comp
L Mechanical:MountingHole_Pad H1
U 1 1 5D93C488
P 1250 3900
F 0 "H1" H 1350 3949 50  0000 L CNN
F 1 "MountingHole_Pad" H 1350 3858 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad" H 1250 3900 50  0001 C CNN
F 3 "~" H 1250 3900 50  0001 C CNN
	1    1250 3900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0116
U 1 1 5D93D1EA
P 1250 4050
F 0 "#PWR0116" H 1250 3800 50  0001 C CNN
F 1 "GND" H 1255 3877 50  0000 C CNN
F 2 "" H 1250 4050 50  0001 C CNN
F 3 "" H 1250 4050 50  0001 C CNN
	1    1250 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 4000 1250 4050
$Comp
L Mechanical:MountingHole_Pad H2
U 1 1 5D93E639
P 1250 4450
F 0 "H2" H 1350 4499 50  0000 L CNN
F 1 "MountingHole_Pad" H 1350 4408 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad" H 1250 4450 50  0001 C CNN
F 3 "~" H 1250 4450 50  0001 C CNN
	1    1250 4450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0117
U 1 1 5D93E63F
P 1250 4600
F 0 "#PWR0117" H 1250 4350 50  0001 C CNN
F 1 "GND" H 1255 4427 50  0000 C CNN
F 2 "" H 1250 4600 50  0001 C CNN
F 3 "" H 1250 4600 50  0001 C CNN
	1    1250 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 4550 1250 4600
$Comp
L Mechanical:MountingHole_Pad H3
U 1 1 5D93F37D
P 1250 5000
F 0 "H3" H 1350 5049 50  0000 L CNN
F 1 "MountingHole_Pad" H 1350 4958 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad" H 1250 5000 50  0001 C CNN
F 3 "~" H 1250 5000 50  0001 C CNN
	1    1250 5000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0118
U 1 1 5D93F383
P 1250 5150
F 0 "#PWR0118" H 1250 4900 50  0001 C CNN
F 1 "GND" H 1255 4977 50  0000 C CNN
F 2 "" H 1250 5150 50  0001 C CNN
F 3 "" H 1250 5150 50  0001 C CNN
	1    1250 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 5100 1250 5150
$Comp
L Mechanical:MountingHole_Pad H4
U 1 1 5D93FF47
P 1250 5550
F 0 "H4" H 1350 5599 50  0000 L CNN
F 1 "MountingHole_Pad" H 1350 5508 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad" H 1250 5550 50  0001 C CNN
F 3 "~" H 1250 5550 50  0001 C CNN
	1    1250 5550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0119
U 1 1 5D93FF4D
P 1250 5700
F 0 "#PWR0119" H 1250 5450 50  0001 C CNN
F 1 "GND" H 1255 5527 50  0000 C CNN
F 2 "" H 1250 5700 50  0001 C CNN
F 3 "" H 1250 5700 50  0001 C CNN
	1    1250 5700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 5650 1250 5700
Text Label 2050 1600 0    50   ~ 0
VBUS
$Comp
L Connector:TestPoint TP?
U 1 1 5DA6EF37
P 2250 1250
AR Path="/5E257EC5/5DA6EF37" Ref="TP?"  Part="1" 
AR Path="/5DA6EF37" Ref="TP4"  Part="1" 
F 0 "TP4" V 2250 1500 50  0000 C CNN
F 1 "TestPoint" V 2354 1322 50  0000 C CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 2450 1250 50  0001 C CNN
F 3 "~" H 2450 1250 50  0001 C CNN
	1    2250 1250
	0    -1   -1   0   
$EndComp
$Comp
L Connector:TestPoint TP?
U 1 1 5DA73087
P 2250 1050
AR Path="/5E257EC5/5DA73087" Ref="TP?"  Part="1" 
AR Path="/5DA73087" Ref="TP3"  Part="1" 
F 0 "TP3" V 2250 1300 50  0000 C CNN
F 1 "TestPoint" V 2354 1122 50  0000 C CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 2450 1050 50  0001 C CNN
F 3 "~" H 2450 1050 50  0001 C CNN
	1    2250 1050
	0    -1   -1   0   
$EndComp
$Comp
L Connector:TestPoint TP?
U 1 1 5DA73E99
P 2250 850
AR Path="/5E257EC5/5DA73E99" Ref="TP?"  Part="1" 
AR Path="/5DA73E99" Ref="TP2"  Part="1" 
F 0 "TP2" V 2250 1100 50  0000 C CNN
F 1 "TestPoint" V 2354 922 50  0000 C CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 2450 850 50  0001 C CNN
F 3 "~" H 2450 850 50  0001 C CNN
	1    2250 850 
	0    -1   -1   0   
$EndComp
$Comp
L power:+3.3V #PWR0127
U 1 1 5DA75889
P 2500 700
AR Path="/5DA75889" Ref="#PWR0127"  Part="1" 
AR Path="/5D7E2E67/5DA75889" Ref="#PWR?"  Part="1" 
F 0 "#PWR0127" H 2500 550 50  0001 C CNN
F 1 "+3.3V" H 2515 873 50  0000 C CNN
F 2 "" H 2500 700 50  0001 C CNN
F 3 "" H 2500 700 50  0001 C CNN
	1    2500 700 
	1    0    0    -1  
$EndComp
$Comp
L power:+1V2 #PWR?
U 1 1 5DA7683A
P 2750 700
AR Path="/5D7E2E67/5DA7683A" Ref="#PWR?"  Part="1" 
AR Path="/5DA7683A" Ref="#PWR0128"  Part="1" 
F 0 "#PWR0128" H 2750 550 50  0001 C CNN
F 1 "+1V2" H 2765 873 50  0000 C CNN
F 2 "" H 2750 700 50  0001 C CNN
F 3 "" H 2750 700 50  0001 C CNN
	1    2750 700 
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 850  2250 850 
Wire Wire Line
	2500 700  2500 850 
Wire Wire Line
	2750 700  2750 1050
Wire Wire Line
	2750 1050 2250 1050
Wire Wire Line
	2250 1250 2300 1250
Wire Wire Line
	2300 1250 2300 1600
Connection ~ 2300 1600
Wire Wire Line
	2300 1600 2500 1600
$EndSCHEMATC
