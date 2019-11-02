EESchema Schematic File Version 4
LIBS:manila_ice-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 6 11
Title "manila iCE"
Date ""
Rev "1.0"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:GND #PWR0102
U 1 1 5EA5FB48
P 6050 4050
AR Path="/5EA5DA36/5EA5FB48" Ref="#PWR0102"  Part="1" 
AR Path="/5EA6C61B/5EA5FB48" Ref="#PWR0106"  Part="1" 
F 0 "#PWR0102" H 6050 3800 50  0001 C CNN
F 1 "GND" H 6055 3877 50  0000 C CNN
F 2 "" H 6050 4050 50  0001 C CNN
F 3 "" H 6050 4050 50  0001 C CNN
	1    6050 4050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5EA6052D
P 5450 4050
AR Path="/5EA5DA36/5EA6052D" Ref="#PWR0101"  Part="1" 
AR Path="/5EA6C61B/5EA6052D" Ref="#PWR0105"  Part="1" 
F 0 "#PWR0101" H 5450 3800 50  0001 C CNN
F 1 "GND" H 5455 3877 50  0000 C CNN
F 2 "" H 5450 4050 50  0001 C CNN
F 3 "" H 5450 4050 50  0001 C CNN
	1    5450 4050
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0103
U 1 1 5EA60E2D
P 6050 3300
AR Path="/5EA5DA36/5EA60E2D" Ref="#PWR0103"  Part="1" 
AR Path="/5EA6C61B/5EA60E2D" Ref="#PWR0107"  Part="1" 
F 0 "#PWR0103" H 6050 3150 50  0001 C CNN
F 1 "+3V3" H 6065 3473 50  0000 C CNN
F 2 "" H 6050 3300 50  0001 C CNN
F 3 "" H 6050 3300 50  0001 C CNN
	1    6050 3300
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0100
U 1 1 5EA61156
P 5450 3300
AR Path="/5EA5DA36/5EA61156" Ref="#PWR0100"  Part="1" 
AR Path="/5EA6C61B/5EA61156" Ref="#PWR0104"  Part="1" 
F 0 "#PWR0100" H 5450 3150 50  0001 C CNN
F 1 "+3V3" H 5465 3473 50  0000 C CNN
F 2 "" H 5450 3300 50  0001 C CNN
F 3 "" H 5450 3300 50  0001 C CNN
	1    5450 3300
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x06_Odd_Even J4
U 1 1 5DB0E5EC
P 5700 3650
AR Path="/5EA5DA36/5DB0E5EC" Ref="J4"  Part="1" 
AR Path="/5EA6C61B/5DB0E5EC" Ref="J5"  Part="1" 
F 0 "J4" H 5750 3950 50  0000 C CNN
F 1 "Conn_02x06_Odd_Even" H 5700 4400 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x06_P2.54mm_Horizontal" H 5700 3650 50  0001 C CNN
F 3 "~" H 5700 3650 50  0001 C CNN
F 4 "0" H 5750 4050 50  0001 C CNN "JLCPCB BOM"
	1    5700 3650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5DD2B31C
P 4500 6350
AR Path="/5DD2B31C" Ref="#PWR?"  Part="1" 
AR Path="/5EA5DA36/5DD2B31C" Ref="#PWR0153"  Part="1" 
AR Path="/5EA6C61B/5DD2B31C" Ref="#PWR0155"  Part="1" 
F 0 "#PWR0153" H 4500 6100 50  0001 C CNN
F 1 "GND" H 4505 6177 50  0000 C CNN
F 2 "" H 4500 6350 50  0001 C CNN
F 3 "" H 4500 6350 50  0001 C CNN
	1    4500 6350
	1    0    0    -1  
$EndComp
$Comp
L Power_Protection:SRV05-4 U?
U 1 1 5DD2B329
P 4500 5800
AR Path="/5DD2B329" Ref="U?"  Part="1" 
AR Path="/5EA5DA36/5DD2B329" Ref="U12"  Part="1" 
AR Path="/5EA6C61B/5DD2B329" Ref="U13"  Part="1" 
F 0 "U12" H 4250 6250 50  0000 C CNN
F 1 "SRV05-4" H 4800 6250 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 5200 5350 50  0001 C CNN
F 3 "~" H 4500 5800 50  0001 C CNN
F 4 "180" H 4250 6350 50  0001 C CNN "JLCPCB Rotation"
F 5 "C85364" H 4500 5800 50  0001 C CNN "LCSC Part"
	1    4500 5800
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0152
U 1 1 5DD2F395
P 4500 5250
AR Path="/5EA5DA36/5DD2F395" Ref="#PWR0152"  Part="1" 
AR Path="/5EA6C61B/5DD2F395" Ref="#PWR0154"  Part="1" 
F 0 "#PWR0152" H 4500 5100 50  0001 C CNN
F 1 "+3V3" H 4515 5423 50  0000 C CNN
F 2 "" H 4500 5250 50  0001 C CNN
F 3 "" H 4500 5250 50  0001 C CNN
	1    4500 5250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5DD3395B
P 6250 6350
AR Path="/5DD3395B" Ref="#PWR?"  Part="1" 
AR Path="/5EA5DA36/5DD3395B" Ref="#PWR0157"  Part="1" 
AR Path="/5EA6C61B/5DD3395B" Ref="#PWR0159"  Part="1" 
F 0 "#PWR0157" H 6250 6100 50  0001 C CNN
F 1 "GND" H 6255 6177 50  0000 C CNN
F 2 "" H 6250 6350 50  0001 C CNN
F 3 "" H 6250 6350 50  0001 C CNN
	1    6250 6350
	1    0    0    -1  
$EndComp
$Comp
L Power_Protection:SRV05-4 U?
U 1 1 5DD33963
P 6250 5800
AR Path="/5DD33963" Ref="U?"  Part="1" 
AR Path="/5EA5DA36/5DD33963" Ref="U14"  Part="1" 
AR Path="/5EA6C61B/5DD33963" Ref="U15"  Part="1" 
F 0 "U14" H 6000 6250 50  0000 C CNN
F 1 "SRV05-4" H 6550 6250 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 6950 5350 50  0001 C CNN
F 3 "~" H 6250 5800 50  0001 C CNN
F 4 "180" H 6000 6350 50  0001 C CNN "JLCPCB Rotation"
F 5 "C85364" H 6250 5800 50  0001 C CNN "LCSC Part"
	1    6250 5800
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0156
U 1 1 5DD33971
P 6250 5250
AR Path="/5EA5DA36/5DD33971" Ref="#PWR0156"  Part="1" 
AR Path="/5EA6C61B/5DD33971" Ref="#PWR0158"  Part="1" 
F 0 "#PWR0156" H 6250 5100 50  0001 C CNN
F 1 "+3V3" H 6265 5423 50  0000 C CNN
F 2 "" H 6250 5250 50  0001 C CNN
F 3 "" H 6250 5250 50  0001 C CNN
	1    6250 5250
	1    0    0    -1  
$EndComp
Text Label 6450 3950 0    50   ~ 0
DATA1
Text Label 6450 3850 0    50   ~ 0
DATA3
Text Label 6450 3750 0    50   ~ 0
DATA5
Text Label 6450 3650 0    50   ~ 0
DATA7
Text Notes 5050 2150 0    50   ~ 0
N.B KiCAD pin numbering is different to PMOD spec pin numbering.
Text Label 4800 3650 0    50   ~ 0
DATA6
Text Label 4800 3750 0    50   ~ 0
DATA4
Text Label 4800 3850 0    50   ~ 0
DATA2
Text Label 4800 3950 0    50   ~ 0
DATA0
Text HLabel 4250 3300 0    50   BiDi ~ 0
DATA[0.7]
Text Label 3750 5700 0    50   ~ 0
DATA0
Text Label 3750 5900 0    50   ~ 0
DATA2
Text Label 5100 5700 0    50   ~ 0
DATA3
Text Label 5100 5900 0    50   ~ 0
DATA1
Text Label 5500 5700 0    50   ~ 0
DATA4
Text Label 5500 5900 0    50   ~ 0
DATA6
Text Label 6850 5700 0    50   ~ 0
DATA7
Text Label 6850 5900 0    50   ~ 0
DATA5
Wire Bus Line
	4650 4400 6900 4400
Wire Bus Line
	4650 3300 4250 3300
Wire Wire Line
	4750 3650 5500 3650
Wire Wire Line
	4750 3750 5500 3750
Wire Wire Line
	4750 3850 5500 3850
Wire Wire Line
	4750 3950 5500 3950
Wire Wire Line
	6000 3650 6800 3650
Wire Wire Line
	6000 3750 6800 3750
Wire Wire Line
	6000 3850 6800 3850
Wire Wire Line
	6000 3950 6800 3950
Wire Wire Line
	5450 3550 5500 3550
Wire Wire Line
	5450 3550 5450 4050
Wire Wire Line
	6050 4050 6050 3550
Wire Wire Line
	6050 3550 6000 3550
Wire Wire Line
	5450 3300 5450 3450
Wire Wire Line
	5450 3450 5500 3450
Wire Wire Line
	6050 3300 6050 3450
Wire Wire Line
	6050 3450 6000 3450
Wire Wire Line
	4500 6300 4500 6350
Wire Wire Line
	3750 5700 4000 5700
Wire Wire Line
	4000 5900 3750 5900
Wire Wire Line
	5000 5700 5100 5700
Wire Wire Line
	5000 5900 5100 5900
Wire Wire Line
	4500 5250 4500 5300
Wire Wire Line
	6250 6300 6250 6350
Wire Wire Line
	5500 5700 5750 5700
Wire Wire Line
	5750 5900 5500 5900
Wire Wire Line
	6750 5700 6850 5700
Wire Wire Line
	6750 5900 6850 5900
Wire Wire Line
	6250 5250 6250 5300
Entry Wire Line
	4650 3550 4750 3650
Entry Wire Line
	4650 3650 4750 3750
Entry Wire Line
	4650 3750 4750 3850
Entry Wire Line
	4650 3850 4750 3950
Entry Wire Line
	6900 3550 6800 3650
Entry Wire Line
	6900 3650 6800 3750
Entry Wire Line
	6900 3750 6800 3850
Entry Wire Line
	6900 3850 6800 3950
Wire Bus Line
	6900 3350 6900 4400
Wire Bus Line
	4650 3300 4650 4400
$EndSCHEMATC
