EESchema Schematic File Version 4
LIBS:manila_ice-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 10
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
L power:GND #PWR047
U 1 1 5D81A23E
P 6000 6250
F 0 "#PWR047" H 6000 6000 50  0001 C CNN
F 1 "GND" H 6005 6077 50  0000 C CNN
F 2 "" H 6000 6250 50  0001 C CNN
F 3 "" H 6000 6250 50  0001 C CNN
	1    6000 6250
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR046
U 1 1 5D81E914
P 4950 1100
F 0 "#PWR046" H 4950 950 50  0001 C CNN
F 1 "+3V3" H 4965 1273 50  0000 C CNN
F 2 "" H 4950 1100 50  0001 C CNN
F 3 "" H 4950 1100 50  0001 C CNN
	1    4950 1100
	1    0    0    -1  
$EndComp
$Comp
L Device:L L1
U 1 1 5D82593D
P 6450 1250
F 0 "L1" V 6640 1250 50  0000 C CNN
F 1 "4u7" V 6549 1250 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" H 6450 1250 50  0001 C CNN
F 3 "~" H 6450 1250 50  0001 C CNN
F 4 "C19666" H 6640 1350 50  0001 C CNN "LCSC Part"
	1    6450 1250
	0    -1   -1   0   
$EndComp
$Comp
L Device:C C16
U 1 1 5D8272F2
P 8050 1450
F 0 "C16" H 8165 1496 50  0000 L CNN
F 1 "4u7" H 8165 1405 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 8088 1300 50  0001 C CNN
F 3 "~" H 8050 1450 50  0001 C CNN
F 4 "C19666" H 8165 1596 50  0001 C CNN "LCSC Part"
	1    8050 1450
	1    0    0    -1  
$EndComp
$Comp
L Device:C C15
U 1 1 5D82758F
P 7600 1450
F 0 "C15" H 7715 1496 50  0000 L CNN
F 1 "100n" H 7715 1405 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 7638 1300 50  0001 C CNN
F 3 "~" H 7600 1450 50  0001 C CNN
F 4 "C14663" H 7715 1596 50  0001 C CNN "LCSC Part"
	1    7600 1450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR051
U 1 1 5D82B670
P 7800 1700
F 0 "#PWR051" H 7800 1450 50  0001 C CNN
F 1 "GND" H 7805 1527 50  0000 C CNN
F 2 "" H 7800 1700 50  0001 C CNN
F 3 "" H 7800 1700 50  0001 C CNN
	1    7800 1700
	1    0    0    -1  
$EndComp
$Comp
L Device:C C14
U 1 1 5D833EC7
P 4600 1400
F 0 "C14" H 4715 1446 50  0000 L CNN
F 1 "4u7" H 4715 1355 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 4638 1250 50  0001 C CNN
F 3 "~" H 4600 1400 50  0001 C CNN
F 4 "C19666" H 4715 1546 50  0001 C CNN "LCSC Part"
	1    4600 1400
	1    0    0    -1  
$EndComp
$Comp
L Device:C C13
U 1 1 5D833ECD
P 4150 1400
F 0 "C13" H 4265 1446 50  0000 L CNN
F 1 "100n" H 4265 1355 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 4188 1250 50  0001 C CNN
F 3 "~" H 4150 1400 50  0001 C CNN
F 4 "C14663" H 4265 1546 50  0001 C CNN "LCSC Part"
	1    4150 1400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR043
U 1 1 5D833ED3
P 4350 1650
F 0 "#PWR043" H 4350 1400 50  0001 C CNN
F 1 "GND" H 4355 1477 50  0000 C CNN
F 2 "" H 4350 1650 50  0001 C CNN
F 3 "" H 4350 1650 50  0001 C CNN
	1    4350 1650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5D8BFF3C
P 850 4900
AR Path="/5D7C5FBE/5D8BFF3C" Ref="R?"  Part="1" 
AR Path="/5E257EC5/5D8BFF3C" Ref="R7"  Part="1" 
F 0 "R7" H 920 4946 50  0000 L CNN
F 1 "10k" H 920 4855 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 780 4900 50  0001 C CNN
F 3 "~" H 850 4900 50  0001 C CNN
F 4 "C25804" H 920 5046 50  0001 C CNN "LCSC Part"
	1    850  4900
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5D8BFF43
P 1300 4650
AR Path="/5D7C5FBE/5D8BFF43" Ref="#PWR?"  Part="1" 
AR Path="/5E257EC5/5D8BFF43" Ref="#PWR033"  Part="1" 
F 0 "#PWR033" H 1300 4500 50  0001 C CNN
F 1 "+3V3" H 1315 4823 50  0000 C CNN
F 2 "" H 1300 4650 50  0001 C CNN
F 3 "" H 1300 4650 50  0001 C CNN
	1    1300 4650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5D8BFF4C
P 1300 5400
AR Path="/5D7C5FBE/5D8BFF4C" Ref="#PWR?"  Part="1" 
AR Path="/5E257EC5/5D8BFF4C" Ref="#PWR034"  Part="1" 
F 0 "#PWR034" H 1300 5150 50  0001 C CNN
F 1 "GND" H 1305 5227 50  0000 C CNN
F 2 "" H 1300 5400 50  0001 C CNN
F 3 "" H 1300 5400 50  0001 C CNN
	1    1300 5400
	1    0    0    -1  
$EndComp
$Comp
L Oscillator:SG-7050CAN X?
U 1 1 5D8BFF53
P 1300 5050
AR Path="/5D7C5FBE/5D8BFF53" Ref="X?"  Part="1" 
AR Path="/5E257EC5/5D8BFF53" Ref="X1"  Part="1" 
F 0 "X1" H 1100 5300 50  0000 L CNN
F 1 "SG-7050CAN" H 1350 5400 50  0000 L CNN
F 2 "Oscillator:Oscillator_SMD_SeikoEpson_SG8002CA-4Pin_7.0x5.0mm" H 2000 4700 50  0001 C CNN
F 3 "https://support.epson.biz/td/api/doc_check.php?dl=brief_SG7050CAN&lang=en" H 1200 5050 50  0001 C CNN
F 4 "C70528" H 1100 5400 50  0001 C CNN "LCSC Part"
	1    1300 5050
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP1
U 1 1 5D8C357B
P 2600 5250
F 0 "TP1" V 2600 5500 50  0000 C CNN
F 1 "TestPoint" V 2704 5322 50  0000 C CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 2800 5250 50  0001 C CNN
F 3 "~" H 2800 5250 50  0001 C CNN
F 4 "0" H 2600 5600 50  0001 C CNN "JLCPCB BOM"
	1    2600 5250
	0    -1   -1   0   
$EndComp
$Comp
L Interface_Ethernet:RTL8211EG-VB-CG U5
U 1 1 5D800FBF
P 6100 3850
F 0 "U5" H 6900 1600 50  0000 C CNN
F 1 "RTL8211EG-VB-CG" H 5450 1600 50  0000 C CNN
F 2 "Package_DFN_QFN:QFN-64-1EP_9x9mm_P0.5mm_EP3.8x3.8mm_ThermalVias" H 5500 4250 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/Realtek-Semicon-RTL8211EG-VB-CG_C69264.pdf" H 6800 3650 50  0001 C CNN
F 4 "C69264" H 6900 1700 50  0001 C CNN "LCSC Part"
	1    6100 3850
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR036
U 1 1 5D8F6B92
P 2200 4650
F 0 "#PWR036" H 2200 4500 50  0001 C CNN
F 1 "+3V3" H 2215 4823 50  0000 C CNN
F 2 "" H 2200 4650 50  0001 C CNN
F 3 "" H 2200 4650 50  0001 C CNN
	1    2200 4650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R9
U 1 1 5D8F6B98
P 2200 4850
F 0 "R9" H 2270 4896 50  0000 L CNN
F 1 "10k" H 2270 4805 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 2130 4850 50  0001 C CNN
F 3 "~" H 2200 4850 50  0001 C CNN
F 4 "C25804" H 2270 4996 50  0001 C CNN "LCSC Part"
	1    2200 4850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR056
U 1 1 5D93328C
P 10000 4000
F 0 "#PWR056" H 10000 3750 50  0001 C CNN
F 1 "GND" H 10005 3827 50  0000 C CNN
F 2 "" H 10000 4000 50  0001 C CNN
F 3 "" H 10000 4000 50  0001 C CNN
	1    10000 4000
	1    0    0    -1  
$EndComp
$Comp
L Connector:RB1-125B8G1A J2
U 1 1 5D9194BB
P 9900 2750
F 0 "J2" H 9570 2846 50  0000 R CNN
F 1 "RB1-125B8G1A" H 9570 2755 50  0000 R CNN
F 2 "Connector_RJ:RJ45_UDE_RB1-125B8G1A" H 9950 2850 50  0001 C CNN
F 3 "https://datasheet.lcsc.com/szlcsc/1901091107_UDE-Corp-RB1-125B8G1A_C363353.pdf" H 9660 2795 50  0001 L TNN
F 4 "0" H 9570 2946 50  0001 C CNN "JLCPCB BOM"
	1    9900 2750
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R24
U 1 1 5D93002F
P 10000 3800
F 0 "R24" H 10070 3846 50  0000 L CNN
F 1 "0R" H 10070 3755 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 9930 3800 50  0001 C CNN
F 3 "~" H 10000 3800 50  0001 C CNN
F 4 "C21189" H 10070 3946 50  0001 C CNN "LCSC Part"
	1    10000 3800
	1    0    0    -1  
$EndComp
$Comp
L Device:C C17
U 1 1 5D94BE61
P 10400 2100
F 0 "C17" H 10515 2146 50  0000 L CNN
F 1 "100n" H 10515 2055 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 10438 1950 50  0001 C CNN
F 3 "~" H 10400 2100 50  0001 C CNN
F 4 "C14663" H 10515 2246 50  0001 C CNN "LCSC Part"
	1    10400 2100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR057
U 1 1 5D94C8F9
P 10400 2300
F 0 "#PWR057" H 10400 2050 50  0001 C CNN
F 1 "GND" H 10405 2127 50  0000 C CNN
F 2 "" H 10400 2300 50  0001 C CNN
F 3 "" H 10400 2300 50  0001 C CNN
	1    10400 2300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R20
U 1 1 5DA52DC2
P 7700 4500
F 0 "R20" H 7770 4546 50  0000 L CNN
F 1 "510R" H 7770 4455 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 7630 4500 50  0001 C CNN
F 3 "~" H 7700 4500 50  0001 C CNN
F 4 "C23193" H 7770 4646 50  0001 C CNN "LCSC Part"
	1    7700 4500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR050
U 1 1 5DA58680
P 7700 4700
F 0 "#PWR050" H 7700 4450 50  0001 C CNN
F 1 "GND" H 7705 4527 50  0000 C CNN
F 2 "" H 7700 4700 50  0001 C CNN
F 3 "" H 7700 4700 50  0001 C CNN
	1    7700 4700
	1    0    0    -1  
$EndComp
$Comp
L Device:R R23
U 1 1 5DA80AEA
P 8250 4500
F 0 "R23" H 8320 4546 50  0000 L CNN
F 1 "510R" H 8320 4455 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 8180 4500 50  0001 C CNN
F 3 "~" H 8250 4500 50  0001 C CNN
F 4 "C23193" H 8320 4646 50  0001 C CNN "LCSC Part"
	1    8250 4500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR054
U 1 1 5DA80AF0
P 8250 4700
F 0 "#PWR054" H 8250 4450 50  0001 C CNN
F 1 "GND" H 8255 4527 50  0000 C CNN
F 2 "" H 8250 4700 50  0001 C CNN
F 3 "" H 8250 4700 50  0001 C CNN
	1    8250 4700
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D2
U 1 1 5DAAA59B
P 7300 3450
F 0 "D2" V 7339 3333 50  0000 R CNN
F 1 "LED" V 7248 3333 50  0000 R CNN
F 2 "Diode_SMD:D_0805_2012Metric_Castellated" H 7300 3450 50  0001 C CNN
F 3 "~" H 7300 3450 50  0001 C CNN
F 4 "C84256" H 7339 3433 50  0001 C CNN "LCSC Part"
	1    7300 3450
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R18
U 1 1 5DAAD193
P 7300 3800
F 0 "R18" H 7370 3846 50  0000 L CNN
F 1 "510R" H 7370 3755 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 7230 3800 50  0001 C CNN
F 3 "~" H 7300 3800 50  0001 C CNN
F 4 "C23193" H 7370 3946 50  0001 C CNN "LCSC Part"
	1    7300 3800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR048
U 1 1 5DAAD199
P 7300 4000
F 0 "#PWR048" H 7300 3750 50  0001 C CNN
F 1 "GND" H 7305 3827 50  0000 C CNN
F 2 "" H 7300 4000 50  0001 C CNN
F 3 "" H 7300 4000 50  0001 C CNN
	1    7300 4000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R21
U 1 1 5DAD3957
P 7900 3450
F 0 "R21" H 7970 3496 50  0000 L CNN
F 1 "4k7" H 7970 3405 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 7830 3450 50  0001 C CNN
F 3 "~" H 7900 3450 50  0001 C CNN
F 4 "C23162" H 7970 3596 50  0001 C CNN "LCSC Part"
	1    7900 3450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR052
U 1 1 5DAD395D
P 7900 3650
F 0 "#PWR052" H 7900 3400 50  0001 C CNN
F 1 "GND" H 7905 3477 50  0000 C CNN
F 2 "" H 7900 3650 50  0001 C CNN
F 3 "" H 7900 3650 50  0001 C CNN
	1    7900 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R22
U 1 1 5DADC15B
P 8200 3450
F 0 "R22" H 8270 3496 50  0000 L CNN
F 1 "4k7" H 8270 3405 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 8130 3450 50  0001 C CNN
F 3 "~" H 8200 3450 50  0001 C CNN
F 4 "C23162" H 8270 3596 50  0001 C CNN "LCSC Part"
	1    8200 3450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR053
U 1 1 5DADC161
P 8200 3650
F 0 "#PWR053" H 8200 3400 50  0001 C CNN
F 1 "GND" H 8205 3477 50  0000 C CNN
F 2 "" H 8200 3650 50  0001 C CNN
F 3 "" H 8200 3650 50  0001 C CNN
	1    8200 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R17
U 1 1 5DB5FA6E
P 4750 6200
F 0 "R17" H 4820 6246 50  0000 L CNN
F 1 "4k7" H 4820 6155 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 4680 6200 50  0001 C CNN
F 3 "~" H 4750 6200 50  0001 C CNN
F 4 "C23162" H 4820 6346 50  0001 C CNN "LCSC Part"
	1    4750 6200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR045
U 1 1 5DB5FA74
P 4750 6400
F 0 "#PWR045" H 4750 6150 50  0001 C CNN
F 1 "GND" H 4755 6227 50  0000 C CNN
F 2 "" H 4750 6400 50  0001 C CNN
F 3 "" H 4750 6400 50  0001 C CNN
	1    4750 6400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R15
U 1 1 5DB8941F
P 4250 3350
F 0 "R15" H 4320 3396 50  0000 L CNN
F 1 "4k7" H 4320 3305 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 4180 3350 50  0001 C CNN
F 3 "~" H 4250 3350 50  0001 C CNN
F 4 "C23162" H 4320 3496 50  0001 C CNN "LCSC Part"
	1    4250 3350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R13
U 1 1 5DB89996
P 3950 3350
F 0 "R13" H 4020 3396 50  0000 L CNN
F 1 "4k7" H 4020 3305 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 3880 3350 50  0001 C CNN
F 3 "~" H 3950 3350 50  0001 C CNN
F 4 "C23162" H 4020 3496 50  0001 C CNN "LCSC Part"
	1    3950 3350
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR040
U 1 1 5DB8A1B8
P 3950 3150
F 0 "#PWR040" H 3950 3000 50  0001 C CNN
F 1 "+3V3" H 3965 3323 50  0000 C CNN
F 2 "" H 3950 3150 50  0001 C CNN
F 3 "" H 3950 3150 50  0001 C CNN
	1    3950 3150
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR042
U 1 1 5DB8ACA6
P 4250 3150
F 0 "#PWR042" H 4250 3000 50  0001 C CNN
F 1 "+3V3" H 4265 3323 50  0000 C CNN
F 2 "" H 4250 3150 50  0001 C CNN
F 3 "" H 4250 3150 50  0001 C CNN
	1    4250 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R12
U 1 1 5DBACDC9
P 3650 3350
F 0 "R12" H 3720 3396 50  0000 L CNN
F 1 "4k7" H 3720 3305 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 3580 3350 50  0001 C CNN
F 3 "~" H 3650 3350 50  0001 C CNN
F 4 "C23162" H 3720 3496 50  0001 C CNN "LCSC Part"
	1    3650 3350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 5DBACDCF
P 3350 3350
F 0 "R11" H 3420 3396 50  0000 L CNN
F 1 "4k7" H 3420 3305 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 3280 3350 50  0001 C CNN
F 3 "~" H 3350 3350 50  0001 C CNN
F 4 "C23162" H 3420 3496 50  0001 C CNN "LCSC Part"
	1    3350 3350
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR038
U 1 1 5DBACDD5
P 3350 3150
F 0 "#PWR038" H 3350 3000 50  0001 C CNN
F 1 "+3V3" H 3365 3323 50  0000 C CNN
F 2 "" H 3350 3150 50  0001 C CNN
F 3 "" H 3350 3150 50  0001 C CNN
	1    3350 3150
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR039
U 1 1 5DBACDDB
P 3650 3150
F 0 "#PWR039" H 3650 3000 50  0001 C CNN
F 1 "+3V3" H 3665 3323 50  0000 C CNN
F 2 "" H 3650 3150 50  0001 C CNN
F 3 "" H 3650 3150 50  0001 C CNN
	1    3650 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R16
U 1 1 5DBCF795
P 4400 6200
F 0 "R16" H 4470 6246 50  0000 L CNN
F 1 "4k7" H 4470 6155 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 4330 6200 50  0001 C CNN
F 3 "~" H 4400 6200 50  0001 C CNN
F 4 "C23162" H 4470 6346 50  0001 C CNN "LCSC Part"
	1    4400 6200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR044
U 1 1 5DBCF79B
P 4400 6400
F 0 "#PWR044" H 4400 6150 50  0001 C CNN
F 1 "GND" H 4405 6227 50  0000 C CNN
F 2 "" H 4400 6400 50  0001 C CNN
F 3 "" H 4400 6400 50  0001 C CNN
	1    4400 6400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 5DC00CC6
P 3050 3350
F 0 "R10" H 3120 3396 50  0000 L CNN
F 1 "4k7" H 3120 3305 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 2980 3350 50  0001 C CNN
F 3 "~" H 3050 3350 50  0001 C CNN
F 4 "C23162" H 3120 3496 50  0001 C CNN "LCSC Part"
	1    3050 3350
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR037
U 1 1 5DC00CCC
P 3050 3150
F 0 "#PWR037" H 3050 3000 50  0001 C CNN
F 1 "+3V3" H 3065 3323 50  0000 C CNN
F 2 "" H 3050 3150 50  0001 C CNN
F 3 "" H 3050 3150 50  0001 C CNN
	1    3050 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R14
U 1 1 5DC1F274
P 4100 6200
F 0 "R14" H 4170 6246 50  0000 L CNN
F 1 "4k7" H 4170 6155 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 4030 6200 50  0001 C CNN
F 3 "~" H 4100 6200 50  0001 C CNN
F 4 "C23162" H 4170 6346 50  0001 C CNN "LCSC Part"
	1    4100 6200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR041
U 1 1 5DC1F27A
P 4100 6400
F 0 "#PWR041" H 4100 6150 50  0001 C CNN
F 1 "GND" H 4105 6227 50  0000 C CNN
F 2 "" H 4100 6400 50  0001 C CNN
F 3 "" H 4100 6400 50  0001 C CNN
	1    4100 6400
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5D962FBD
P 6750 1200
F 0 "#FLG02" H 6750 1275 50  0001 C CNN
F 1 "PWR_FLAG" H 6750 1373 50  0000 C CNN
F 2 "" H 6750 1200 50  0001 C CNN
F 3 "~" H 6750 1200 50  0001 C CNN
	1    6750 1200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R19
U 1 1 5D983321
P 7400 5950
F 0 "R19" V 7193 5950 50  0000 C CNN
F 1 "2k4" V 7284 5950 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 7330 5950 50  0001 C CNN
F 3 "~" H 7400 5950 50  0001 C CNN
F 4 "C22940" H 7193 6050 50  0001 C CNN "LCSC Part"
	1    7400 5950
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR049
U 1 1 5D983EE4
P 8050 6000
F 0 "#PWR049" H 8050 5750 50  0001 C CNN
F 1 "GND" H 8055 5827 50  0000 C CNN
F 2 "" H 8050 6000 50  0001 C CNN
F 3 "" H 8050 6000 50  0001 C CNN
	1    8050 6000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR055
U 1 1 5D9BDFAF
P 9800 3600
F 0 "#PWR055" H 9800 3350 50  0001 C CNN
F 1 "GND" H 9805 3427 50  0000 C CNN
F 2 "" H 9800 3600 50  0001 C CNN
F 3 "" H 9800 3600 50  0001 C CNN
	1    9800 3600
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG03
U 1 1 5DA08687
P 10450 3500
F 0 "#FLG03" H 10450 3575 50  0001 C CNN
F 1 "PWR_FLAG" H 10450 3673 50  0000 C CNN
F 2 "" H 10450 3500 50  0001 C CNN
F 3 "~" H 10450 3500 50  0001 C CNN
	1    10450 3500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 5DA900EC
P 7850 5950
F 0 "R8" V 7643 5950 50  0000 C CNN
F 1 "91" V 7734 5950 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 7780 5950 50  0001 C CNN
F 3 "~" H 7850 5950 50  0001 C CNN
F 4 "C25199" H 7643 6050 50  0001 C CNN "LCSC Part"
	1    7850 5950
	0    1    1    0   
$EndComp
Text HLabel 4950 2350 0    50   Input ~ 0
GTXCLK
Text HLabel 4950 2450 0    50   Output ~ 0
TXCLK
Text HLabel 4400 2400 0    50   Input ~ 0
TXD[0..7]
Text HLabel 4950 3350 0    50   Input ~ 0
TXEN
Text HLabel 4950 3450 0    50   Input ~ 0
TXER
Text HLabel 2950 3650 0    50   Output ~ 0
RXCLK
Text HLabel 2400 3600 0    50   Output ~ 0
RXD[0..7]
Text HLabel 2750 4550 0    50   Output ~ 0
RXDV
Text HLabel 2750 4650 0    50   Output ~ 0
RXER
Text HLabel 2750 4750 0    50   Output ~ 0
COL
Text HLabel 2750 4850 0    50   Output ~ 0
CS
Text HLabel 2750 5650 0    50   Input ~ 0
MDC
Text HLabel 1800 5750 0    50   BiDi ~ 0
MDIO
Text HLabel 2700 5850 0    50   Output ~ 0
~PME_INT
Text HLabel 1800 5450 0    50   Input ~ 0
~PHYRST
Text Notes 5400 900  0    50   ~ 0
See datasheet section 9.1 for PSU layout.
Text Label 4600 2550 0    50   ~ 0
TXD0
Text Label 4600 2650 0    50   ~ 0
TXD1
Text Label 4600 2750 0    50   ~ 0
TXD2
Text Label 4600 2850 0    50   ~ 0
TXD3
Text Label 4600 2950 0    50   ~ 0
TXD4
Text Label 4600 3050 0    50   ~ 0
TXD5
Text Label 4600 3150 0    50   ~ 0
TXD6
Text Label 4600 3250 0    50   ~ 0
TXD7
Text Label 2600 3750 0    50   ~ 0
RXD0
Text Label 2600 3850 0    50   ~ 0
RXD1
Text Label 2600 3950 0    50   ~ 0
RXD2
Text Label 2600 4050 0    50   ~ 0
RXD3
Text Label 2600 4150 0    50   ~ 0
RXD4
Text Label 2600 4250 0    50   ~ 0
RXD5
Text Label 2600 4350 0    50   ~ 0
RXD6
Text Label 2600 4450 0    50   ~ 0
RXD7
Text Notes 500  5450 0    50   ~ 0
50MHz Oscillator\nLCSC C70528
Text Notes 3700 7650 0    50   ~ 0
~PME~ and ~INT~ are combined since the FPGA would handle them in the same way.
Text Notes 8900 5000 0    50   ~ 0
Centre tap and ground connection is as per RTL8211C(L)\nLayout Guide (as found on Baidu).\nThis is the closed document I could find without an NDA.\n\nThis is Bob Smith termination.
Text Label 9250 1650 0    50   ~ 0
LED_Y_HIGH
Text Label 9250 1750 0    50   ~ 0
LED_Y_LOW
Text Label 9250 1350 0    50   ~ 0
LED_G_HIGH
Text Label 9250 1450 0    50   ~ 0
LED_G_LOW
Text Label 8350 3050 0    50   ~ 0
LED_G_HIGH
Text Label 8350 3150 0    50   ~ 0
LED_Y_HIGH
Text Label 7700 4300 0    50   ~ 0
LED_G_LOW
Text Label 8250 4300 0    50   ~ 0
LED_Y_LOW
Text Notes 7550 4100 0    50   ~ 0
LED circuit is datasheet p.7
Text Notes 1300 1700 0    50   ~ 0
Datsheet Table 13 shows some pin strapping options.\nPHYAD= 000 (use any address)\nAN= 11 (advertise all capabilities)\nTXDLY= 1 (add 2ns delay to TXC to allow TXD latching)\nRXDLY= 1 (add 2ns delay to TXC to allow RXD latching)\nMODE = 0 (G)MII\nSELRGV = 1 (3V3 signalling)
Text Notes 8900 5350 0    50   ~ 0
ST AN5031 Figure 47 is a useful resource
Text Notes 8950 5800 0    50   ~ 0
RSET value is from ST AN5031 Figure 47.
Text Label 7450 2150 0    50   ~ 0
MDI0_P
Text Label 7450 2250 0    50   ~ 0
MDI0_N
Text Label 7450 2350 0    50   ~ 0
MDI1_P
Text Label 7450 2450 0    50   ~ 0
MDI1_N
Text Label 7450 2550 0    50   ~ 0
MDI2_P
Text Label 7450 2650 0    50   ~ 0
MDI2_N
Text Label 7450 2750 0    50   ~ 0
MDI3_P
Text Label 7450 2850 0    50   ~ 0
MDI3_N
Text Label 3200 5250 0    50   ~ 0
CLK125
Text Label 6300 1400 0    50   ~ 0
REG_OUT
Text Label 7150 1250 0    50   ~ 0
VDD
Text Label 10100 1800 0    50   ~ 0
CT
Text Label 10100 3600 0    50   ~ 0
TERM
Text Label 1750 5050 0    50   ~ 0
CLK50
Wire Wire Line
	6400 6150 6400 6200
Wire Wire Line
	6400 6200 6200 6200
Wire Wire Line
	6000 6200 6000 6150
Wire Wire Line
	6000 6250 6000 6200
Wire Wire Line
	6100 6150 6100 6200
Wire Wire Line
	6100 6200 6000 6200
Wire Wire Line
	6200 6150 6200 6200
Wire Wire Line
	6200 6200 6100 6200
Wire Wire Line
	5000 2150 4950 2150
Wire Wire Line
	4950 2150 4950 1600
Wire Wire Line
	5200 1650 5200 1600
Wire Wire Line
	5200 1600 4950 1600
Wire Wire Line
	4950 1600 4950 1150
Wire Wire Line
	5200 1600 5400 1600
Wire Wire Line
	6100 1600 6100 1650
Wire Wire Line
	6000 1650 6000 1600
Wire Wire Line
	6000 1600 6100 1600
Wire Wire Line
	5900 1650 5900 1600
Wire Wire Line
	5900 1600 6000 1600
Wire Wire Line
	5700 1650 5700 1600
Wire Wire Line
	5700 1600 5900 1600
Wire Wire Line
	5500 1650 5500 1600
Wire Wire Line
	5500 1600 5700 1600
Wire Wire Line
	5400 1650 5400 1600
Wire Wire Line
	5400 1600 5500 1600
Wire Wire Line
	6300 1650 6300 1250
Wire Wire Line
	7600 1600 7600 1650
Wire Wire Line
	7600 1650 7800 1650
Wire Wire Line
	8050 1650 8050 1600
Wire Wire Line
	7800 1700 7800 1650
Wire Wire Line
	7800 1650 8050 1650
Wire Wire Line
	6600 1250 6750 1250
Wire Wire Line
	8050 1250 8050 1300
Wire Wire Line
	7600 1300 7600 1250
Wire Wire Line
	7600 1250 8050 1250
Wire Wire Line
	7000 1650 7000 1600
Wire Wire Line
	7000 1250 7600 1250
Wire Wire Line
	6900 1650 6900 1600
Wire Wire Line
	6900 1600 7000 1600
Wire Wire Line
	7000 1600 7000 1250
Wire Wire Line
	6500 1650 6500 1600
Wire Wire Line
	6500 1600 6600 1600
Wire Wire Line
	6700 1650 6700 1600
Wire Wire Line
	6700 1600 6900 1600
Wire Wire Line
	6600 1650 6600 1600
Wire Wire Line
	6600 1600 6700 1600
Wire Wire Line
	4150 1550 4150 1600
Wire Wire Line
	4150 1600 4350 1600
Wire Wire Line
	4600 1600 4600 1550
Wire Wire Line
	4350 1650 4350 1600
Wire Wire Line
	4350 1600 4600 1600
Wire Wire Line
	4150 1150 4600 1150
Wire Wire Line
	4150 1150 4150 1250
Wire Wire Line
	4950 1150 4950 1100
Wire Wire Line
	4600 1150 4600 1250
Wire Wire Line
	4600 1150 4950 1150
Wire Wire Line
	4950 2350 5000 2350
Wire Wire Line
	5000 2450 4950 2450
Wire Wire Line
	4550 2550 5000 2550
Wire Wire Line
	4550 2650 5000 2650
Wire Wire Line
	4550 2750 5000 2750
Wire Wire Line
	4550 2850 5000 2850
Wire Wire Line
	4550 2950 5000 2950
Wire Wire Line
	4550 3050 5000 3050
Wire Wire Line
	4550 3150 5000 3150
Wire Wire Line
	4550 3250 5000 3250
Wire Bus Line
	4400 2400 4450 2400
Wire Wire Line
	4950 3350 5000 3350
Wire Wire Line
	5000 3450 4950 3450
Wire Wire Line
	2750 4550 4750 4550
Wire Wire Line
	2750 4750 4400 4750
Wire Wire Line
	5000 4850 2750 4850
Wire Wire Line
	2950 3650 5000 3650
Wire Bus Line
	2450 3600 2400 3600
Wire Wire Line
	1000 5050 850  5050
Wire Wire Line
	1300 4750 1300 4700
Wire Wire Line
	1300 4700 1300 4650
Wire Wire Line
	1300 5350 1300 5400
Wire Wire Line
	850  4750 850  4700
Wire Wire Line
	850  4700 1300 4700
Wire Wire Line
	2600 5250 5000 5250
Wire Wire Line
	5000 5050 1600 5050
Wire Wire Line
	2750 5650 5000 5650
Wire Wire Line
	2200 4700 2200 4650
Wire Wire Line
	1800 5750 2200 5750
Wire Wire Line
	2200 5000 2200 5750
Wire Wire Line
	2200 5750 5000 5750
Wire Wire Line
	5000 5850 2750 5850
Wire Wire Line
	5000 5950 2750 5950
Wire Wire Line
	2750 5950 2750 5850
Wire Wire Line
	2750 5850 2700 5850
Wire Wire Line
	7200 2350 9100 2350
Wire Wire Line
	10000 3950 10000 4000
Wire Wire Line
	10000 3550 10000 3600
Wire Wire Line
	9400 2050 9350 2050
Wire Wire Line
	9350 2050 9350 1800
Wire Wire Line
	9350 1800 10400 1800
Wire Wire Line
	10400 1800 10400 1950
Wire Wire Line
	10400 2300 10400 2250
Wire Wire Line
	7200 2150 9400 2150
Wire Wire Line
	9150 2250 9150 2350
Wire Wire Line
	9150 2350 9400 2350
Wire Wire Line
	7200 2250 9150 2250
Wire Wire Line
	9100 2350 9100 2450
Wire Wire Line
	9100 2450 9400 2450
Wire Wire Line
	9050 2450 9050 2650
Wire Wire Line
	9050 2650 9400 2650
Wire Wire Line
	7200 2450 9050 2450
Wire Wire Line
	9000 2550 9000 2750
Wire Wire Line
	9000 2750 9400 2750
Wire Wire Line
	7200 2550 9000 2550
Wire Wire Line
	8950 2650 8950 2950
Wire Wire Line
	8950 2950 9400 2950
Wire Wire Line
	7200 2650 8950 2650
Wire Wire Line
	8900 2750 8900 3050
Wire Wire Line
	8900 3050 9400 3050
Wire Wire Line
	7200 2750 8900 2750
Wire Wire Line
	8850 2850 8850 3250
Wire Wire Line
	8850 3250 9400 3250
Wire Wire Line
	7200 2850 8850 2850
Wire Wire Line
	9700 1850 9700 1750
Wire Wire Line
	9800 1850 9800 1650
Wire Wire Line
	9800 1650 9250 1650
Wire Wire Line
	9250 1750 9700 1750
Wire Wire Line
	9900 1850 9900 1450
Wire Wire Line
	9900 1450 9250 1450
Wire Wire Line
	10000 1850 10000 1350
Wire Wire Line
	10000 1350 9250 1350
Wire Wire Line
	7200 3050 7900 3050
Wire Wire Line
	7200 3150 8200 3150
Wire Wire Line
	7700 4700 7700 4650
Wire Wire Line
	7700 4300 7700 4350
Wire Wire Line
	8250 4700 8250 4650
Wire Wire Line
	8250 4300 8250 4350
Wire Wire Line
	7300 4000 7300 3950
Wire Wire Line
	7300 3600 7300 3650
Wire Wire Line
	7300 3300 7300 3250
Wire Wire Line
	7300 3250 7200 3250
Wire Wire Line
	7900 3650 7900 3600
Wire Wire Line
	8200 3650 8200 3600
Wire Wire Line
	7900 3300 7900 3050
Wire Wire Line
	7900 3050 8350 3050
Wire Wire Line
	8200 3300 8200 3150
Wire Wire Line
	8200 3150 8350 3150
Wire Wire Line
	2550 3750 5000 3750
Wire Wire Line
	2550 3850 5000 3850
Wire Wire Line
	2550 3950 5000 3950
Wire Wire Line
	2550 4050 5000 4050
Wire Wire Line
	2550 4250 3350 4250
Wire Wire Line
	2550 4350 3650 4350
Wire Wire Line
	2550 4450 3950 4450
Wire Wire Line
	4750 6400 4750 6350
Wire Wire Line
	4750 6050 4750 4550
Wire Wire Line
	4750 4550 5000 4550
Wire Wire Line
	3950 3150 3950 3200
Wire Wire Line
	4250 3150 4250 3200
Wire Wire Line
	3950 3500 3950 4450
Wire Wire Line
	3950 4450 5000 4450
Wire Wire Line
	3350 3150 3350 3200
Wire Wire Line
	3650 3150 3650 3200
Wire Wire Line
	3650 3500 3650 4350
Wire Wire Line
	3650 4350 5000 4350
Wire Wire Line
	3350 3500 3350 4250
Wire Wire Line
	3350 4250 5000 4250
Wire Wire Line
	4400 6400 4400 6350
Wire Wire Line
	4400 6050 4400 4750
Wire Wire Line
	4400 4750 5000 4750
Wire Wire Line
	2550 4150 3050 4150
Wire Wire Line
	3050 3150 3050 3200
Wire Wire Line
	3050 3500 3050 4150
Wire Wire Line
	3050 4150 5000 4150
Wire Wire Line
	4100 6400 4100 6350
Wire Wire Line
	4100 6050 4100 5450
Wire Wire Line
	4100 5450 5000 5450
Wire Wire Line
	2750 4650 4250 4650
Wire Wire Line
	4250 3500 4250 4650
Wire Wire Line
	4250 4650 5000 4650
Wire Wire Line
	6750 1200 6750 1250
Wire Wire Line
	6750 1250 7000 1250
Wire Wire Line
	7200 5950 7250 5950
Wire Wire Line
	9800 3550 9800 3600
Wire Wire Line
	10450 3500 10450 3600
Wire Wire Line
	10450 3600 10000 3600
Wire Wire Line
	10000 3600 10000 3650
Wire Wire Line
	1800 5450 4100 5450
Wire Wire Line
	7550 5950 7700 5950
Wire Wire Line
	8000 5950 8050 5950
Wire Wire Line
	8050 5950 8050 6000
Entry Wire Line
	4450 2450 4550 2550
Entry Wire Line
	4450 2550 4550 2650
Entry Wire Line
	4450 2650 4550 2750
Entry Wire Line
	4450 2750 4550 2850
Entry Wire Line
	4450 2850 4550 2950
Entry Wire Line
	4450 2950 4550 3050
Entry Wire Line
	4450 3050 4550 3150
Entry Wire Line
	4450 3150 4550 3250
Entry Wire Line
	2450 3650 2550 3750
Entry Wire Line
	2450 3750 2550 3850
Entry Wire Line
	2450 3850 2550 3950
Entry Wire Line
	2450 3950 2550 4050
Entry Wire Line
	2450 4050 2550 4150
Entry Wire Line
	2450 4150 2550 4250
Entry Wire Line
	2450 4250 2550 4350
Entry Wire Line
	2450 4350 2550 4450
Connection ~ 6000 6200
Connection ~ 6100 6200
Connection ~ 6200 6200
Connection ~ 4950 1600
Connection ~ 5200 1600
Connection ~ 6000 1600
Connection ~ 5900 1600
Connection ~ 5700 1600
Connection ~ 5500 1600
Connection ~ 5400 1600
Connection ~ 7800 1650
Connection ~ 7600 1250
Connection ~ 7000 1250
Connection ~ 7000 1600
Connection ~ 6900 1600
Connection ~ 6700 1600
Connection ~ 6600 1600
Connection ~ 4350 1600
Connection ~ 4950 1150
Connection ~ 4600 1150
Connection ~ 1300 4700
Connection ~ 2200 5750
Connection ~ 2750 5850
Connection ~ 7900 3050
Connection ~ 8200 3150
Connection ~ 4750 4550
Connection ~ 3950 4450
Connection ~ 3650 4350
Connection ~ 3350 4250
Connection ~ 4400 4750
Connection ~ 3050 4150
Connection ~ 4100 5450
Connection ~ 4250 4650
Connection ~ 6750 1250
Connection ~ 10000 3600
NoConn ~ 5000 5150
Wire Bus Line
	2450 3600 2450 4350
Wire Bus Line
	4450 2400 4450 3150
$EndSCHEMATC
