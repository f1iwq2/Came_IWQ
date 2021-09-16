EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 2
Title "Clone de carte CAME BZX6N-7N"
Date "10/09/2021"
Rev "2.0"
Comp "F1IWQ"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Notes 700  800  0    59   ~ 0
entrée 220V
$Comp
L Device:Fuse F1
U 1 1 611260DB
P 1250 1500
F 0 "F1" H 1310 1546 50  0000 L CNN
F 1 "Fuse" H 1310 1455 50  0000 L CNN
F 2 "Fuse:Fuseholder_Cylinder-5x20mm_Schurter_0031_8201_Horizontal_Open" V 1180 1500 50  0001 C CNN
F 3 "~" H 1250 1500 50  0001 C CNN
	1    1250 1500
	1    0    0    -1  
$EndComp
$Comp
L Device:D_TVS D1
U 1 1 61128800
P 1050 1800
F 0 "D1" H 1050 1900 50  0000 C CNN
F 1 "1.5KE400CA" V 750 1750 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0414_L11.9mm_D4.5mm_P15.24mm_Horizontal" H 1050 1800 50  0001 C CNN
F 3 "~" H 1050 1800 50  0001 C CNN
	1    1050 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	950  1200 950  1300
$Comp
L Connector:Conn_01x02_Male J1
U 1 1 6112B59B
P 950 1000
F 0 "J1" V 800 900 50  0000 L CNN
F 1 "Conn_01x02_Male" V 900 650 50  0000 L CNN
F 2 "Connector_Phoenix_MSTB:PhoenixContact_MSTBVA_2,5_2-G-5,08_1x02_P5.08mm_Vertical" H 950 1000 50  0001 C CNN
F 3 "~" H 950 1000 50  0001 C CNN
	1    950  1000
	0    1    1    0   
$EndComp
Wire Wire Line
	3050 1200 3050 1450
Text Label 2750 1350 1    50   ~ 0
L1T
Text Label 2850 1350 1    50   ~ 0
L2T
Text Label 3150 1350 1    50   ~ 0
0
Text Label 3250 1350 1    50   ~ 0
12
Text Label 3350 1350 1    50   ~ 0
24
NoConn ~ 3050 1450
$Comp
L Connector:Conn_01x09_Male J4
U 1 1 6112F200
P 5900 1000
F 0 "J4" V 5900 1500 50  0000 C CNN
F 1 "Conn_01x09_Male" V 5826 978 50  0000 C CNN
F 2 "Connector_Phoenix_MSTB:PhoenixContact_MSTBVA_2,5_9-G-5,08_1x09_P5.08mm_Vertical" H 5900 1000 50  0001 C CNN
F 3 "~" H 5900 1000 50  0001 C CNN
	1    5900 1000
	0    -1   1    0   
$EndComp
Text Notes 2900 800  0    59   ~ 0
Transfo
Text Notes 5700 850  0    59   ~ 0
Commande
Wire Wire Line
	5800 1200 5800 1450
Wire Wire Line
	6000 1200 6000 1450
Text Label 5500 1350 1    50   ~ 0
10
Text Label 5600 1350 1    50   ~ 0
11
Text Label 5700 1350 1    50   ~ 0
TS
Text Label 5900 1350 1    50   ~ 0
2
Text Label 6000 1350 1    50   ~ 0
3P
Text Label 6100 1350 1    50   ~ 0
7
Text Label 6200 1350 1    50   ~ 0
CX
Text Label 6300 1350 1    50   ~ 0
CY
$Comp
L Connector:Conn_01x03_Male J5
U 1 1 6113320E
P 8150 1000
F 0 "J5" V 8000 950 50  0000 L CNN
F 1 "Conn_01x03_Male" V 8100 650 50  0000 L CNN
F 2 "Connector_Phoenix_MSTB:PhoenixContact_MSTBVA_2,5_3-G-5,08_1x03_P5.08mm_Vertical" H 8150 1000 50  0001 C CNN
F 3 "~" H 8150 1000 50  0001 C CNN
	1    8150 1000
	0    -1   1    0   
$EndComp
Text Label 8050 1350 1    50   ~ 0
FC
Text Label 8150 1350 1    50   ~ 0
FA
Text Label 8250 1350 1    50   ~ 0
F
$Comp
L Connector:Screw_Terminal_01x02 J6
U 1 1 611361CB
P 9550 4700
F 0 "J6" V 9550 4500 50  0000 R CNN
F 1 "Screw_Terminal_01x02" V 9550 5650 50  0000 R CNN
F 2 "TerminalBlock:TerminalBlock_bornier-2_P5.08mm" H 9550 4700 50  0001 C CNN
F 3 "~" H 9550 4700 50  0001 C CNN
	1    9550 4700
	0    1    -1   0   
$EndComp
NoConn ~ 5800 1450
$Comp
L power:GND #PWR02
U 1 1 611578AD
P 9550 5150
F 0 "#PWR02" H 9550 4900 50  0001 C CNN
F 1 "GND" H 9555 4977 50  0000 C CNN
F 2 "" H 9550 5150 50  0001 C CNN
F 3 "" H 9550 5150 50  0001 C CNN
	1    9550 5150
	1    0    0    -1  
$EndComp
$Comp
L Diode_Bridge:W04G D2
U 1 1 6115860A
P 3150 3150
F 0 "D2" H 2900 3350 50  0000 L CNN
F 1 "W04G" H 2750 3250 50  0000 L CNN
F 2 "Diode_THT:Diode_Bridge_Round_D8.9mm" H 3300 3275 50  0001 L CNN
F 3 "https://diotec.com/tl_files/diotec/files/pdf/datasheets/abs2.pdf" H 3150 3150 50  0001 C CNN
	1    3150 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:Fuse F2
U 1 1 61159F02
P 3150 2450
F 0 "F2" H 3210 2496 50  0000 L CNN
F 1 "Fuse" H 3210 2405 50  0000 L CNN
F 2 "Fuse:Fuseholder_Cylinder-5x20mm_Schurter_0031_8201_Horizontal_Open" V 3080 2450 50  0001 C CNN
F 3 "~" H 3150 2450 50  0001 C CNN
	1    3150 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 1200 3350 1700
$Comp
L power:GND #PWR01
U 1 1 611616BA
P 6800 4400
F 0 "#PWR01" H 6800 4150 50  0001 C CNN
F 1 "GND" H 6800 4200 50  0000 C CNN
F 2 "" H 6800 4400 50  0001 C CNN
F 3 "" H 6800 4400 50  0001 C CNN
	1    6800 4400
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C2
U 1 1 611627D0
P 4000 3350
F 0 "C2" H 4050 3450 50  0000 L CNN
F 1 "1000µF 35V" H 3500 3200 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D12.5mm_P5.00mm" H 4038 3200 50  0001 C CNN
F 3 "~" H 4000 3350 50  0001 C CNN
	1    4000 3350
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:L7805 U1
U 1 1 6116C876
P 4300 4400
F 0 "U1" H 4300 4650 50  0000 C CNN
F 1 "L7805" H 4300 4550 50  0000 C CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Vertical" H 4325 4250 50  0001 L CIN
F 3 "http://www.st.com/content/ccc/resource/technical/document/datasheet/41/4f/b3/b0/12/d4/47/88/CD00000444.pdf/files/CD00000444.pdf/jcr:content/translations/en.CD00000444.pdf" H 4300 4350 50  0001 C CNN
	1    4300 4400
	1    0    0    -1  
$EndComp
Connection ~ 4300 5100
NoConn ~ 9600 3650
NoConn ~ 9600 2350
NoConn ~ 9600 2450
NoConn ~ 10600 2350
NoConn ~ 10600 2450
NoConn ~ 10600 2750
NoConn ~ 10200 1950
NoConn ~ 10000 1950
$Comp
L Device:Fuse F4
U 1 1 6118246E
P 4450 1700
F 0 "F4" V 4550 1800 50  0000 L CNN
F 1 "Fuse" V 4550 1550 50  0000 L CNN
F 2 "Fuse:Fuseholder_Cylinder-5x20mm_Schurter_0031_8201_Horizontal_Open" V 4380 1700 50  0001 C CNN
F 3 "~" H 4450 1700 50  0001 C CNN
	1    4450 1700
	0    1    1    0   
$EndComp
Wire Wire Line
	5500 1200 5500 1700
$Comp
L Device:D_TVS D4
U 1 1 611860C4
P 4950 1350
F 0 "D4" V 5000 1550 50  0000 C CNN
F 1 "1.5KE39CA" V 4900 1650 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0414_L11.9mm_D4.5mm_P15.24mm_Horizontal" H 4950 1350 50  0001 C CNN
F 3 "~" H 4950 1350 50  0001 C CNN
	1    4950 1350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4600 1700 4950 1700
Wire Wire Line
	4950 1500 4950 1700
Connection ~ 4950 1700
Wire Wire Line
	4950 1700 5500 1700
Wire Wire Line
	4150 1550 4150 1000
Wire Wire Line
	4150 1000 4950 1000
Wire Wire Line
	4950 1000 4950 1200
Text Label 5150 1700 0    50   ~ 0
24VP
Wire Wire Line
	5900 1550 5700 1550
Connection ~ 4150 1550
Wire Wire Line
	5900 1200 5900 1550
Text Notes 6350 5200 0    50   ~ 0
ouv/ferm
NoConn ~ 6000 1450
NoConn ~ 6300 1450
Wire Wire Line
	6850 2750 6750 2750
$Comp
L Device:R R2
U 1 1 6119DB9D
P 6200 2000
F 0 "R2" H 6270 2046 50  0000 L CNN
F 1 "4,7k" H 6270 1955 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 6130 2000 50  0001 C CNN
F 3 "~" H 6200 2000 50  0001 C CNN
	1    6200 2000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 611A547C
P 6550 2750
F 0 "R1" V 6450 2800 50  0000 L CNN
F 1 "47k" V 6450 2600 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 6480 2750 50  0001 C CNN
F 3 "~" H 6550 2750 50  0001 C CNN
	1    6550 2750
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR04
U 1 1 611B0329
P 5100 4150
F 0 "#PWR04" H 5100 4000 50  0001 C CNN
F 1 "+5V" H 5115 4323 50  0000 C CNN
F 2 "" H 5100 4150 50  0001 C CNN
F 3 "" H 5100 4150 50  0001 C CNN
	1    5100 4150
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR05
U 1 1 611B51A1
P 7650 2050
F 0 "#PWR05" H 7650 1900 50  0001 C CNN
F 1 "+5V" H 7750 2200 50  0000 C CNN
F 2 "" H 7650 2050 50  0001 C CNN
F 3 "" H 7650 2050 50  0001 C CNN
	1    7650 2050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 611B5A94
P 7500 3100
F 0 "#PWR06" H 7500 2850 50  0001 C CNN
F 1 "GND" H 7505 2927 50  0000 C CNN
F 2 "" H 7500 3100 50  0001 C CNN
F 3 "" H 7500 3100 50  0001 C CNN
	1    7500 3100
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 611BE871
P 7650 2500
F 0 "R3" H 7450 2450 50  0000 L CNN
F 1 "5,6k" H 7400 2550 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 7580 2500 50  0001 C CNN
F 3 "~" H 7650 2500 50  0001 C CNN
	1    7650 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7650 2650 7650 2750
$Comp
L MCU_Module:Arduino_Nano_v3.x A1
U 1 1 6113747F
P 10100 2950
F 0 "A1" H 9750 2000 50  0000 C CNN
F 1 "Arduino_Nano_v3.x" H 9700 1900 50  0000 C CNN
F 2 "Module:Arduino_Nano" H 10100 2950 50  0001 C CIN
F 3 "http://www.mouser.com/pdfdocs/Gravitech_Arduino_Nano3_0.pdf" H 10100 2950 50  0001 C CNN
	1    10100 2950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 611CA58F
P 8700 2750
F 0 "R4" V 8650 2950 50  0000 C CNN
F 1 "1k" V 8650 2600 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 8630 2750 50  0001 C CNN
F 3 "~" H 8700 2750 50  0001 C CNN
	1    8700 2750
	0    1    1    0   
$EndComp
Wire Wire Line
	4300 5100 4750 5100
$Comp
L power:GND #PWR010
U 1 1 6116942C
P 4000 3700
F 0 "#PWR010" H 4000 3450 50  0001 C CNN
F 1 "GND" H 4005 3527 50  0000 C CNN
F 2 "" H 4000 3700 50  0001 C CNN
F 3 "" H 4000 3700 50  0001 C CNN
	1    4000 3700
	1    0    0    -1  
$EndComp
Text Notes 7850 800  0    59   ~ 0
Fins de course
Text Notes 9500 4600 0    59   ~ 0
Antenne
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 611ECE75
P 3900 4300
F 0 "#FLG0102" H 3900 4375 50  0001 C CNN
F 1 "PWR_FLAG" H 3900 4473 50  0000 C CNN
F 2 "" H 3900 4300 50  0001 C CNN
F 3 "~" H 3900 4300 50  0001 C CNN
	1    3900 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	2750 1200 2750 1700
Wire Wire Line
	2850 1200 2850 1800
$Comp
L power:GND #PWR0101
U 1 1 61234FE4
P 10100 4150
F 0 "#PWR0101" H 10100 3900 50  0001 C CNN
F 1 "GND" H 10105 3977 50  0000 C CNN
F 2 "" H 10100 4150 50  0001 C CNN
F 3 "" H 10100 4150 50  0001 C CNN
	1    10100 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	10100 3950 10100 4050
Wire Wire Line
	10100 4050 10200 4050
Wire Wire Line
	10200 4050 10200 3950
Connection ~ 10100 4050
Wire Wire Line
	10100 4050 10100 4150
$Comp
L power:+5V #PWR0102
U 1 1 6124EDBB
P 10800 1500
F 0 "#PWR0102" H 10800 1350 50  0001 C CNN
F 1 "+5V" H 10815 1673 50  0000 C CNN
F 2 "" H 10800 1500 50  0001 C CNN
F 3 "" H 10800 1500 50  0001 C CNN
	1    10800 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	8250 1200 8250 1600
$Comp
L Device:R R14
U 1 1 61280865
P 9350 1600
F 0 "R14" V 9557 1600 50  0000 C CNN
F 1 "220" V 9466 1600 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 9280 1600 50  0001 C CNN
F 3 "~" H 9350 1600 50  0001 C CNN
	1    9350 1600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9500 1600 9750 1600
Wire Wire Line
	6850 4250 6800 4250
Wire Wire Line
	6850 3600 6800 3600
$Comp
L Device:R R8
U 1 1 612C4B45
P 6500 3400
F 0 "R8" V 6293 3400 50  0000 C CNN
F 1 "2,7k" V 6384 3400 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 6430 3400 50  0001 C CNN
F 3 "~" H 6500 3400 50  0001 C CNN
	1    6500 3400
	0    1    1    0   
$EndComp
$Comp
L Device:R R9
U 1 1 612C4C13
P 6500 4050
F 0 "R9" V 6293 4050 50  0000 C CNN
F 1 "2,7k" V 6384 4050 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 6430 4050 50  0001 C CNN
F 3 "~" H 6500 4050 50  0001 C CNN
	1    6500 4050
	0    1    1    0   
$EndComp
Wire Wire Line
	6350 3400 6200 3400
Wire Wire Line
	6350 4050 6200 4050
Text Label 6200 3400 0    50   ~ 0
FC
Text Label 6200 4050 0    50   ~ 0
FA
Wire Wire Line
	7650 2300 7800 2300
Connection ~ 7650 2300
Wire Wire Line
	7650 2300 7650 2350
$Comp
L Device:R R12
U 1 1 6131772E
P 8700 2850
F 0 "R12" V 8650 3050 50  0000 C CNN
F 1 "1k" V 8650 2700 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 8630 2850 50  0001 C CNN
F 3 "~" H 8700 2850 50  0001 C CNN
	1    8700 2850
	0    1    1    0   
$EndComp
$Comp
L Device:R R13
U 1 1 613178C8
P 8700 2950
F 0 "R13" V 8650 3150 50  0000 C CNN
F 1 "1k" V 8650 2800 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 8630 2950 50  0001 C CNN
F 3 "~" H 8700 2950 50  0001 C CNN
	1    8700 2950
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 613483A8
P 7500 3700
F 0 "#PWR0104" H 7500 3450 50  0001 C CNN
F 1 "GND" H 7505 3527 50  0000 C CNN
F 2 "" H 7500 3700 50  0001 C CNN
F 3 "" H 7500 3700 50  0001 C CNN
	1    7500 3700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 61348739
P 7500 4400
F 0 "#PWR0105" H 7500 4150 50  0001 C CNN
F 1 "GND" H 7505 4227 50  0000 C CNN
F 2 "" H 7500 4400 50  0001 C CNN
F 3 "" H 7500 4400 50  0001 C CNN
	1    7500 4400
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 61400819
P 4750 4750
F 0 "C4" H 4600 4850 50  0000 L CNN
F 1 "100nF" H 4500 4650 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W2.5mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 4788 4600 50  0001 C CNN
F 3 "~" H 4750 4750 50  0001 C CNN
	1    4750 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 4900 4750 5100
Text Notes 9050 3050 0    50   ~ 0
Commande
Text Notes 9050 2850 0    50   ~ 0
Ouvert
Text Notes 9050 2950 0    50   ~ 0
Fermé
Text Notes 9900 6400 2    59   ~ 0
   Récepteur\ntélécommande\n   433 MHz
Wire Wire Line
	9000 5900 9000 6050
$Comp
L power:GND #PWR017
U 1 1 61132DB6
P 9000 6050
F 0 "#PWR017" H 9000 5800 50  0001 C CNN
F 1 "GND" H 9005 5877 50  0000 C CNN
F 2 "" H 9000 6050 50  0001 C CNN
F 3 "" H 9000 6050 50  0001 C CNN
	1    9000 6050
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR016
U 1 1 6113E36B
P 9000 5550
F 0 "#PWR016" H 9000 5400 50  0001 C CNN
F 1 "+5V" H 9015 5723 50  0000 C CNN
F 2 "" H 9000 5550 50  0001 C CNN
F 3 "" H 9000 5550 50  0001 C CNN
	1    9000 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	9000 5550 9000 5600
Text Label 9200 5800 0    50   ~ 0
DATA
Text Notes 9100 3700 0    50   ~ 0
led intégrée
Wire Wire Line
	9600 2550 8900 2550
Text Notes 9950 6400 0    59   ~ 0
TDCA RX500A\nCHJ-9921\nRXB6
Wire Wire Line
	10600 3350 11100 3350
Wire Wire Line
	10600 3450 11100 3450
Text Label 10700 3350 0    50   ~ 0
SDA
Text Label 10700 3450 0    50   ~ 0
SCL
$Comp
L Connector_Generic:Conn_01x04 J7
U 1 1 611D4E1A
P 1950 6900
F 0 "J7" H 2030 6892 50  0000 L CNN
F 1 "Conn_01x04" H 2030 6801 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x04_P2.54mm_Vertical" H 1950 6900 50  0001 C CNN
F 3 "~" H 1950 6900 50  0001 C CNN
	1    1950 6900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR015
U 1 1 611D647F
P 1600 7400
F 0 "#PWR015" H 1600 7150 50  0001 C CNN
F 1 "GND" H 1605 7227 50  0000 C CNN
F 2 "" H 1600 7400 50  0001 C CNN
F 3 "" H 1600 7400 50  0001 C CNN
	1    1600 7400
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR014
U 1 1 611F9328
P 900 6800
F 0 "#PWR014" H 900 6650 50  0001 C CNN
F 1 "+5V" H 915 6973 50  0000 C CNN
F 2 "" H 900 6800 50  0001 C CNN
F 3 "" H 900 6800 50  0001 C CNN
	1    900  6800
	1    0    0    -1  
$EndComp
Text Label 1150 6900 0    50   ~ 0
SCL
Text Label 1150 6800 0    50   ~ 0
SDA
Text Notes 1900 7350 0    59   ~ 0
Ecran OLED
Text Label 8900 2550 0    50   ~ 0
DATA
Wire Wire Line
	9600 3450 8900 3450
Text Label 8900 3450 0    50   ~ 0
Bp+
$Comp
L Switch:SW_MEC_5E Bp+1
U 1 1 6123876D
P 1750 6000
F 0 "Bp+1" H 1750 6385 50  0000 C CNN
F 1 "SW_MEC_5E" H 1750 6294 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_Omron_B3FS-101xP" H 1750 6300 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 1750 6300 50  0001 C CNN
	1    1750 6000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R16
U 1 1 6123988B
P 1100 6000
F 0 "R16" V 893 6000 50  0000 C CNN
F 1 "5,6k" V 984 6000 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 1030 6000 50  0001 C CNN
F 3 "~" H 1100 6000 50  0001 C CNN
	1    1100 6000
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR019
U 1 1 6123A48B
P 2200 6150
F 0 "#PWR019" H 2200 5900 50  0001 C CNN
F 1 "GND" H 2205 5977 50  0000 C CNN
F 2 "" H 2200 6150 50  0001 C CNN
F 3 "" H 2200 6150 50  0001 C CNN
	1    2200 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 6000 2050 6000
Wire Wire Line
	1950 5900 2050 5900
Wire Wire Line
	2050 5900 2050 6000
Connection ~ 2050 6000
Wire Wire Line
	2050 6000 1950 6000
Wire Wire Line
	1550 5900 1400 5900
Wire Wire Line
	1400 5900 1400 6000
Wire Wire Line
	1550 6000 1400 6000
Connection ~ 1400 6000
Wire Wire Line
	1400 6000 1250 6000
Wire Wire Line
	750  6000 950  6000
$Comp
L power:+5V #PWR018
U 1 1 61283898
P 750 3650
F 0 "#PWR018" H 750 3500 50  0001 C CNN
F 1 "+5V" H 765 3823 50  0000 C CNN
F 2 "" H 750 3650 50  0001 C CNN
F 3 "" H 750 3650 50  0001 C CNN
	1    750  3650
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 5900 1400 5500
Text Label 1400 5650 1    50   ~ 0
Bp+
Wire Wire Line
	5600 1200 5600 1550
Connection ~ 5600 1550
Wire Wire Line
	5600 1550 4150 1550
Wire Wire Line
	2750 1700 2050 1700
Wire Wire Line
	2850 1800 1700 1800
Wire Wire Line
	3350 1700 4300 1700
Wire Wire Line
	3150 1200 3150 1550
$Comp
L Device:LED D9
U 1 1 611EF339
P 5100 4900
F 0 "D9" V 5139 4782 50  0000 R CNN
F 1 "LED" V 5048 4782 50  0000 R CNN
F 2 "LED_THT:LED_D3.0mm" H 5100 4900 50  0001 C CNN
F 3 "~" H 5100 4900 50  0001 C CNN
	1    5100 4900
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R17
U 1 1 611EFC21
P 5100 4550
F 0 "R17" H 4950 4550 50  0000 C CNN
F 1 "330" H 4950 4650 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 5030 4550 50  0001 C CNN
F 3 "~" H 5100 4550 50  0001 C CNN
	1    5100 4550
	-1   0    0    1   
$EndComp
Wire Wire Line
	5100 5050 5100 5100
Wire Wire Line
	4750 5100 5100 5100
Connection ~ 4750 5100
Wire Wire Line
	4750 4400 5100 4400
Connection ~ 5100 4400
Wire Wire Line
	5100 4700 5100 4750
Wire Wire Line
	4750 4400 4750 4600
Wire Wire Line
	4750 4400 4600 4400
Connection ~ 4750 4400
Wire Wire Line
	4300 4700 4300 5100
$Comp
L Device:C C5
U 1 1 6135E0E4
P 1050 2100
F 0 "C5" V 900 2100 50  0000 C CNN
F 1 "100nF 400V" V 1200 2100 39  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L16.5mm_W6.0mm_P15.00mm_MKT" H 1088 1950 50  0001 C CNN
F 3 "~" H 1050 2100 50  0001 C CNN
	1    1050 2100
	0    1    1    0   
$EndComp
Wire Wire Line
	3150 1550 4150 1550
Connection ~ 3150 1550
Wire Wire Line
	3150 1550 3150 2000
$Comp
L Device:D_TVS D10
U 1 1 613F06B1
P 2900 2750
F 0 "D10" H 2900 2850 50  0000 C CNN
F 1 "1.5KE39CA" H 2900 2600 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0414_L11.9mm_D4.5mm_P15.24mm_Horizontal" H 2900 2750 50  0001 C CNN
F 3 "~" H 2900 2750 50  0001 C CNN
	1    2900 2750
	-1   0    0    1   
$EndComp
$Comp
L Connector_Generic:Conn_01x01 J9
U 1 1 6151FF69
P 9000 5000
F 0 "J9" H 9080 4992 50  0000 L CNN
F 1 "Conn_01x04" H 8800 4850 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x01_P2.54mm_Vertical" H 9000 5000 50  0001 C CNN
F 3 "~" H 9000 5000 50  0001 C CNN
	1    9000 5000
	-1   0    0    1   
$EndComp
Wire Wire Line
	9450 5000 9450 4900
Wire Wire Line
	8850 2750 9600 2750
Wire Wire Line
	8850 2850 9600 2850
Wire Wire Line
	8850 2950 9600 2950
Connection ~ 5500 1700
Wire Wire Line
	6850 3400 6650 3400
Wire Wire Line
	6650 4050 6850 4050
Wire Wire Line
	7450 2950 7500 2950
Wire Wire Line
	7450 3600 7500 3600
Wire Wire Line
	7450 4250 7500 4250
Wire Wire Line
	7500 4250 7500 4400
Wire Wire Line
	7500 3600 7500 3700
Wire Wire Line
	7450 4050 7950 4050
Connection ~ 1400 5900
$Sheet
S 2650 5650 1150 550 
U 6130ED2A
F0 "puissance" 50
F1 "puissance.sch" 50
$EndSheet
Text Label 1550 1700 0    50   ~ 0
Ph
Wire Wire Line
	1250 1300 950  1300
Wire Wire Line
	1250 1300 1250 1350
Text Notes 900  6300 0    59   ~ 0
Boutons poussoir
Wire Notes Line
	2550 6550 2550 7650
Wire Notes Line
	600  7650 600  6550
Text GLabel 2150 1400 2    50   Input ~ 0
Ph
Text GLabel 1800 2300 2    50   Input ~ 0
N
Text GLabel 2850 1900 0    50   Input ~ 0
CT
Text GLabel 10900 3050 2    50   Input ~ 0
R2
Text GLabel 10900 3150 2    50   Input ~ 0
R3
Text GLabel 10900 3250 2    50   Input ~ 0
R4
Wire Wire Line
	10900 3050 10600 3050
Wire Wire Line
	10600 3150 10900 3150
Wire Wire Line
	10900 3250 10600 3250
Wire Wire Line
	2850 1900 2950 1900
Wire Wire Line
	2950 1900 2950 1200
Wire Wire Line
	3350 1700 3350 2100
Connection ~ 3350 1700
Text GLabel 5600 3150 2    50   Input ~ 0
24V
Wire Wire Line
	7650 2050 7650 2300
$Comp
L Diode:1N4004 D12
U 1 1 616228B3
P 3450 4400
AR Path="/616228B3" Ref="D12"  Part="1" 
AR Path="/6130ED2A/616228B3" Ref="D?"  Part="1" 
F 0 "D12" H 3400 4250 50  0000 L CNN
F 1 "1N4004" H 3300 4550 50  0000 L CNN
F 2 "Diode_THT:D_DO-41_SOD81_P10.16mm_Horizontal" H 3450 4225 50  0001 C CNN
F 3 "http://www.vishay.com/docs/88503/1n4001.pdf" H 3450 4400 50  0001 C CNN
	1    3450 4400
	-1   0    0    1   
$EndComp
Text Label 1750 1800 0    50   ~ 0
N
Wire Wire Line
	2050 1400 2150 1400
Wire Wire Line
	2050 1400 2050 1700
Text Notes 3750 4050 0    50   ~ 0
Alimentation 5V arduino
Text Notes 4550 2850 0    50   ~ 0
Alimentation 24V relais
Wire Wire Line
	5700 1200 5700 1550
Connection ~ 5700 1550
Wire Wire Line
	5700 1550 5600 1550
Text Label 5800 1350 1    50   ~ 0
1
$Comp
L Connector:Conn_01x03_Male J10
U 1 1 61167225
P 7200 1000
F 0 "J10" V 7050 950 50  0000 L CNN
F 1 "Conn_01x03_Male" V 7150 700 50  0000 L CNN
F 2 "Connector_Phoenix_MSTB:PhoenixContact_MSTBVA_2,5_3-G-5,08_1x03_P5.08mm_Vertical" H 7200 1000 50  0001 C CNN
F 3 "~" H 7200 1000 50  0001 C CNN
	1    7200 1000
	0    -1   1    0   
$EndComp
Text Notes 7000 800  0    59   ~ 0
Encodeur
Wire Wire Line
	7100 1450 7100 1200
Wire Wire Line
	7200 1200 7200 1450
$Comp
L power:+5V #PWR03
U 1 1 6118B8D3
P 6600 1400
F 0 "#PWR03" H 6600 1250 50  0001 C CNN
F 1 "+5V" H 6615 1573 50  0000 C CNN
F 2 "" H 6600 1400 50  0001 C CNN
F 3 "" H 6600 1400 50  0001 C CNN
	1    6600 1400
	1    0    0    -1  
$EndComp
Text Label 7100 1400 1    59   ~ 0
+
Text Label 7200 1400 1    59   ~ 0
E
Text Label 7300 1400 1    59   ~ 0
D
$Comp
L Isolator:TLP290-4 U2
U 1 1 6119BE53
P 7150 2850
F 0 "U2" H 7150 3175 50  0000 C CNN
F 1 "ACPL-844" H 7150 3084 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_LongPads" H 6300 2650 50  0001 L CIN
F 3 "https://toshiba.semicon-storage.com/info/docget.jsp?did=12855&prodName=TLP290-4" H 7175 2850 50  0001 L CNN
	1    7150 2850
	1    0    0    -1  
$EndComp
$Comp
L Isolator:TLP290-4 U2
U 2 1 611AB675
P 7150 3500
F 0 "U2" H 7150 3825 50  0000 C CNN
F 1 "ACPL-844" H 7150 3734 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_LongPads" H 6300 3300 50  0001 L CIN
F 3 "https://toshiba.semicon-storage.com/info/docget.jsp?did=12855&prodName=TLP290-4" H 7175 3500 50  0001 L CNN
	2    7150 3500
	1    0    0    -1  
$EndComp
$Comp
L Isolator:TLP290-4 U2
U 3 1 611AC361
P 7150 4150
F 0 "U2" H 7150 4475 50  0000 C CNN
F 1 "ACPL-844" H 7150 4384 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_LongPads" H 6300 3950 50  0001 L CIN
F 3 "https://toshiba.semicon-storage.com/info/docget.jsp?did=12855&prodName=TLP290-4" H 7175 4150 50  0001 L CNN
	3    7150 4150
	1    0    0    -1  
$EndComp
$Comp
L Isolator:TLP290-4 U2
U 4 1 611AD44D
P 7150 5000
F 0 "U2" H 7150 5325 50  0000 C CNN
F 1 "ACPL-844" H 7150 5234 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_LongPads" H 6300 4800 50  0001 L CIN
F 3 "https://toshiba.semicon-storage.com/info/docget.jsp?did=12855&prodName=TLP290-4" H 7175 5000 50  0001 L CNN
	4    7150 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6800 3600 6800 4250
Connection ~ 7650 2750
$Comp
L Device:R R24
U 1 1 61276231
P 8100 2500
F 0 "R24" H 8050 2900 50  0000 L CNN
F 1 "5,6k" H 8050 2800 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 8030 2500 50  0001 C CNN
F 3 "~" H 8100 2500 50  0001 C CNN
	1    8100 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R25
U 1 1 6128DE0E
P 8700 3050
F 0 "R25" V 8650 3250 50  0000 C CNN
F 1 "1k" V 8650 2900 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 8630 3050 50  0001 C CNN
F 3 "~" H 8700 3050 50  0001 C CNN
	1    8700 3050
	0    1    1    0   
$EndComp
Wire Wire Line
	9600 3050 8850 3050
Text Notes 9050 2750 0    50   ~ 0
Cellule
$Comp
L power:GND #PWR0112
U 1 1 612B5263
P 7500 5350
F 0 "#PWR0112" H 7500 5100 50  0001 C CNN
F 1 "GND" H 7505 5177 50  0000 C CNN
F 2 "" H 7500 5350 50  0001 C CNN
F 3 "" H 7500 5350 50  0001 C CNN
	1    7500 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	7450 5100 7500 5100
$Comp
L Device:R R26
U 1 1 612E7DDA
P 8700 2650
F 0 "R26" V 8650 2850 50  0000 C CNN
F 1 "1k" V 8650 2500 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 8630 2650 50  0001 C CNN
F 3 "~" H 8700 2650 50  0001 C CNN
	1    8700 2650
	0    1    1    0   
$EndComp
Text Label 8200 2650 0    59   ~ 0
Encod
Wire Wire Line
	7450 2750 7650 2750
Wire Wire Line
	7650 2750 8550 2750
$Comp
L Device:R R10
U 1 1 612E84C9
P 7800 2500
F 0 "R10" H 7750 2900 50  0000 L CNN
F 1 "5,6k" H 7750 2800 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 7730 2500 50  0001 C CNN
F 3 "~" H 7800 2500 50  0001 C CNN
	1    7800 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 612E90C8
P 7950 2500
F 0 "R11" H 7900 2900 50  0000 L CNN
F 1 "5,6k" H 7900 2800 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 7880 2500 50  0001 C CNN
F 3 "~" H 7950 2500 50  0001 C CNN
	1    7950 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 2650 7800 2850
Wire Wire Line
	7800 2300 7800 2350
Connection ~ 7800 2300
Wire Wire Line
	7800 2300 7950 2300
Wire Wire Line
	7950 2650 7950 2950
Wire Wire Line
	8550 2850 7800 2850
Connection ~ 7800 2850
Wire Wire Line
	7800 2850 7800 3400
Wire Wire Line
	7950 2950 8550 2950
Connection ~ 7950 2950
Wire Wire Line
	7950 2950 7950 4050
Wire Wire Line
	7950 2350 7950 2300
Connection ~ 7950 2300
Wire Wire Line
	7950 2300 8100 2300
Wire Wire Line
	8100 2350 8100 2300
Wire Wire Line
	8100 2650 8100 3050
Wire Wire Line
	8100 3050 8550 3050
Connection ~ 8100 3050
Wire Wire Line
	8100 3050 8100 4900
Wire Wire Line
	2500 2000 2500 2750
Wire Wire Line
	2500 2000 3150 2000
Wire Wire Line
	2500 2750 2750 2750
Connection ~ 2500 2750
$Comp
L Device:R R15
U 1 1 611662B3
P 1500 6800
F 0 "R15" V 1400 6700 50  0000 C CNN
F 1 "330" V 1400 6900 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 1430 6800 50  0001 C CNN
F 3 "~" H 1500 6800 50  0001 C CNN
	1    1500 6800
	0    1    1    0   
$EndComp
Wire Wire Line
	1650 6800 1750 6800
Wire Wire Line
	1750 6900 1650 6900
$Comp
L Device:R R28
U 1 1 611A524B
P 1500 6900
F 0 "R28" V 1650 6700 50  0000 C CNN
F 1 "330" V 1650 6900 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 1430 6900 50  0001 C CNN
F 3 "~" H 1500 6900 50  0001 C CNN
	1    1500 6900
	0    1    1    0   
$EndComp
Wire Wire Line
	1350 6800 1150 6800
Wire Wire Line
	1350 6900 1150 6900
Wire Notes Line
	600  6550 2550 6550
Wire Notes Line
	600  7650 2550 7650
$Comp
L Connector:Conn_01x07_Male J3
U 1 1 611FA63C
P 3050 1000
F 0 "J3" V 2885 978 50  0000 C CNN
F 1 "Conn_01x07_Male" V 2976 978 50  0000 C CNN
F 2 "Connector_Phoenix_MSTB:PhoenixContact_MSTBVA_2,5_7-G-5,08_1x07_P5.08mm_Vertical" H 3050 1000 50  0001 C CNN
F 3 "~" H 3050 1000 50  0001 C CNN
	1    3050 1000
	0    -1   1    0   
$EndComp
Text Label 4950 5600 3    50   ~ 0
24VR
$Comp
L Device:R R30
U 1 1 611758AB
P 5600 6800
F 0 "R30" V 5450 6800 50  0000 C CNN
F 1 "1k" V 5700 6800 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 5530 6800 50  0001 C CNN
F 3 "~" H 5600 6800 50  0001 C CNN
	1    5600 6800
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 611918E0
P 4950 7400
F 0 "#PWR0103" H 4950 7150 50  0001 C CNN
F 1 "GND" H 4955 7227 50  0000 C CNN
F 2 "" H 4950 7400 50  0001 C CNN
F 3 "" H 4950 7400 50  0001 C CNN
	1    4950 7400
	1    0    0    -1  
$EndComp
Text Notes 5200 750  0    50   ~ 0
la manoeuvre du portail est réalisée\n      par un BP connecté 5 et 7\n             (mise au 0V de 7)
Text Notes 1000 1150 0    50   ~ 0
Phase
Text Notes 500  1150 0    50   ~ 0
Neutre
Text Notes 1950 1950 0    50   ~ 0
Phase réduite 220V
$Comp
L Mechanical:MountingHole H2
U 1 1 611780DA
P 3000 6900
F 0 "H2" H 3100 6946 50  0000 L CNN
F 1 "MountingHole" H 3100 6855 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 3000 6900 50  0001 C CNN
F 3 "~" H 3000 6900 50  0001 C CNN
	1    3000 6900
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 6117858B
P 3000 7100
F 0 "H3" H 3100 7146 50  0000 L CNN
F 1 "MountingHole" H 3100 7055 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 3000 7100 50  0001 C CNN
F 3 "~" H 3000 7100 50  0001 C CNN
	1    3000 7100
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 61178754
P 3000 7300
F 0 "H4" H 3100 7346 50  0000 L CNN
F 1 "MountingHole" H 3100 7255 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 3000 7300 50  0001 C CNN
F 3 "~" H 3000 7300 50  0001 C CNN
	1    3000 7300
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H1
U 1 1 6117899C
P 3000 6700
F 0 "H1" H 3100 6746 50  0000 L CNN
F 1 "MountingHole" H 3100 6655 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3" H 3000 6700 50  0001 C CNN
F 3 "~" H 3000 6700 50  0001 C CNN
	1    3000 6700
	1    0    0    -1  
$EndComp
Text Notes 3250 6500 0    59   ~ 0
Trous de montage
Wire Wire Line
	1750 7100 1600 7100
Wire Wire Line
	1750 7000 900  7000
Wire Wire Line
	900  6800 900  7000
$Comp
L Mechanical:MountingHole H5
U 1 1 6120601D
P 3800 6700
F 0 "H5" H 3900 6746 50  0000 L CNN
F 1 "MountingHole" H 3900 6655 50  0000 L CNN
F 2 "MountingHole:MountingHole_6.4mm_M6" H 3800 6700 50  0001 C CNN
F 3 "~" H 3800 6700 50  0001 C CNN
	1    3800 6700
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H6
U 1 1 612061F0
P 3800 6900
F 0 "H6" H 3900 6946 50  0000 L CNN
F 1 "MountingHole" H 3900 6855 50  0000 L CNN
F 2 "MountingHole:MountingHole_6.4mm_M6" H 3800 6900 50  0001 C CNN
F 3 "~" H 3800 6900 50  0001 C CNN
	1    3800 6900
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H7
U 1 1 6120648A
P 3800 7100
F 0 "H7" H 3900 7146 50  0000 L CNN
F 1 "MountingHole" H 3900 7055 50  0000 L CNN
F 2 "MountingHole:MountingHole_6.4mm_M6" H 3800 7100 50  0001 C CNN
F 3 "~" H 3800 7100 50  0001 C CNN
	1    3800 7100
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H8
U 1 1 6120667B
P 3800 7300
F 0 "H8" H 3900 7346 50  0000 L CNN
F 1 "MountingHole" H 3900 7255 50  0000 L CNN
F 2 "MountingHole:MountingHole_6.4mm_M6" H 3800 7300 50  0001 C CNN
F 3 "~" H 3800 7300 50  0001 C CNN
	1    3800 7300
	1    0    0    -1  
$EndComp
Wire Notes Line
	2650 7650 4550 7650
Wire Wire Line
	3050 2750 3150 2750
$Comp
L Diode:1N4004 D5
U 1 1 6118107C
P 4950 6050
AR Path="/6118107C" Ref="D5"  Part="1" 
AR Path="/6130ED2A/6118107C" Ref="D?"  Part="1" 
F 0 "D5" V 4900 5850 50  0000 L CNN
F 1 "1N4004" V 5000 5650 50  0000 L CNN
F 2 "Diode_THT:D_DO-41_SOD81_P10.16mm_Horizontal" H 4950 5875 50  0001 C CNN
F 3 "http://www.vishay.com/docs/88503/1n4001.pdf" H 4950 6050 50  0001 C CNN
	1    4950 6050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4950 5600 4950 5900
Wire Wire Line
	4950 6200 4950 6350
$Comp
L Diode:1N4004 D13
U 1 1 6132A5A8
P 10500 1700
AR Path="/6132A5A8" Ref="D13"  Part="1" 
AR Path="/6130ED2A/6132A5A8" Ref="D?"  Part="1" 
F 0 "D13" H 10450 1550 50  0000 L CNN
F 1 "1N4004" H 10350 1850 50  0000 L CNN
F 2 "Diode_THT:D_DO-41_SOD81_P10.16mm_Horizontal" H 10500 1525 50  0001 C CNN
F 3 "http://www.vishay.com/docs/88503/1n4001.pdf" H 10500 1700 50  0001 C CNN
	1    10500 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	10650 1700 10800 1700
Wire Wire Line
	10800 1500 10800 1700
Wire Wire Line
	10300 1950 10300 1700
Wire Wire Line
	10300 1700 10350 1700
Wire Wire Line
	8450 3350 9600 3350
Text Notes 9050 3350 0    50   ~ 0
PWM
Text GLabel 8450 3350 0    50   Input ~ 0
Var
$Comp
L Device:R R32
U 1 1 611D879B
P 4950 7100
F 0 "R32" H 4800 7100 50  0000 C CNN
F 1 "1k" H 5100 7100 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4880 7100 50  0001 C CNN
F 3 "~" H 4950 7100 50  0001 C CNN
	1    4950 7100
	-1   0    0    1   
$EndComp
Wire Wire Line
	4950 6950 4950 6800
$Comp
L Device:R R31
U 1 1 6125A219
P 4950 6500
F 0 "R31" H 4800 6500 50  0000 C CNN
F 1 "6,8k" H 5150 6500 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4880 6500 50  0001 C CNN
F 3 "~" H 4950 6500 50  0001 C CNN
	1    4950 6500
	-1   0    0    1   
$EndComp
Wire Wire Line
	4950 6650 4950 6800
Connection ~ 4950 6800
Text Notes 5000 6250 0    50   ~ 0
32V PkPk
$Comp
L Device:D_Zener D14
U 1 1 6127CA36
P 5850 7100
F 0 "D14" V 5804 7180 50  0000 L CNN
F 1 "DZ5.1V" V 5895 7180 50  0000 L CNN
F 2 "Diode_THT:D_A-405_P7.62mm_Horizontal" H 5850 7100 50  0001 C CNN
F 3 "~" H 5850 7100 50  0001 C CNN
	1    5850 7100
	0    1    1    0   
$EndComp
Wire Wire Line
	5850 6800 5850 6950
$Comp
L power:GND #PWR011
U 1 1 6129A8CF
P 5850 7400
F 0 "#PWR011" H 5850 7150 50  0001 C CNN
F 1 "GND" H 5855 7227 50  0000 C CNN
F 2 "" H 5850 7400 50  0001 C CNN
F 3 "" H 5850 7400 50  0001 C CNN
	1    5850 7400
	1    0    0    -1  
$EndComp
Text Notes 5000 6750 0    50   ~ 0
4,7V PkPk
Wire Wire Line
	4950 6800 5450 6800
Wire Wire Line
	5750 6800 5850 6800
Connection ~ 5850 6800
$Comp
L Device:C C7
U 1 1 611A407B
P 9000 5750
F 0 "C7" H 8850 5850 50  0000 L CNN
F 1 "100nF" H 8750 5650 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W2.5mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 9038 5600 50  0001 C CNN
F 3 "~" H 9000 5750 50  0001 C CNN
	1    9000 5750
	1    0    0    -1  
$EndComp
Connection ~ 9000 5600
$Comp
L Device:C C8
U 1 1 6121E52E
P 900 7150
F 0 "C8" H 750 7250 50  0000 L CNN
F 1 "100nF" H 650 7050 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W2.5mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 938 7000 50  0001 C CNN
F 3 "~" H 900 7150 50  0001 C CNN
	1    900  7150
	1    0    0    -1  
$EndComp
Connection ~ 900  7000
Wire Wire Line
	900  7300 1600 7300
Wire Wire Line
	1600 7100 1600 7300
Wire Wire Line
	1600 7300 1600 7400
Connection ~ 1600 7300
$Comp
L Device:R R33
U 1 1 6118ABFA
P 7200 1600
F 0 "R33" H 7000 1650 50  0000 L CNN
F 1 "150" H 7000 1550 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 7130 1600 50  0001 C CNN
F 3 "~" H 7200 1600 50  0001 C CNN
	1    7200 1600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR012
U 1 1 6118B21A
P 7300 2300
F 0 "#PWR012" H 7300 2050 50  0001 C CNN
F 1 "GND" H 7150 2250 50  0000 C CNN
F 2 "" H 7300 2300 50  0001 C CNN
F 3 "" H 7300 2300 50  0001 C CNN
	1    7300 2300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R34
U 1 1 6119A8AB
P 7300 1600
F 0 "R34" H 7100 1550 50  0000 L CNN
F 1 "1k" H 7100 1650 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 7230 1600 50  0001 C CNN
F 3 "~" H 7300 1600 50  0001 C CNN
	1    7300 1600
	-1   0    0    1   
$EndComp
Wire Wire Line
	7300 1200 7300 1450
$Comp
L Device:R R35
U 1 1 611B9EE5
P 7300 2050
F 0 "R35" H 7100 2000 50  0000 L CNN
F 1 "10k" H 7100 2100 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 7230 2050 50  0001 C CNN
F 3 "~" H 7300 2050 50  0001 C CNN
	1    7300 2050
	-1   0    0    1   
$EndComp
Wire Wire Line
	7300 1750 7300 1800
Wire Wire Line
	7300 2200 7300 2250
Wire Wire Line
	7300 2250 7200 2250
Wire Wire Line
	7200 1750 7200 2250
Connection ~ 7300 2250
Wire Wire Line
	7300 2250 7300 2300
Wire Wire Line
	7300 1800 7650 1800
Connection ~ 7300 1800
Wire Wire Line
	7300 1800 7300 1900
Text Label 7450 1800 0    50   ~ 0
Encod
Text Notes 4900 1950 0    50   ~ 0
1=arrêt mvt\n3P=ouverture partielle
$Comp
L Device:C C10
U 1 1 6118EDE9
P 6400 7100
F 0 "C10" H 6500 7200 50  0000 L CNN
F 1 "1nF" H 6500 7000 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W2.5mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 6438 6950 50  0001 C CNN
F 3 "~" H 6400 7100 50  0001 C CNN
	1    6400 7100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C9
U 1 1 611DD439
P 3900 4750
F 0 "C9" H 3950 4850 50  0000 L CNN
F 1 "100nF" H 3950 4650 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W2.5mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 3938 4600 50  0001 C CNN
F 3 "~" H 3900 4750 50  0001 C CNN
	1    3900 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 4900 3900 5100
Connection ~ 3900 5100
Wire Wire Line
	3900 5100 4300 5100
Wire Wire Line
	3900 4600 3900 4400
Connection ~ 3900 4400
Wire Wire Line
	3900 4400 4000 4400
$Comp
L power:GND #PWR013
U 1 1 611FDC1C
P 6400 7400
F 0 "#PWR013" H 6400 7150 50  0001 C CNN
F 1 "GND" H 6405 7227 50  0000 C CNN
F 2 "" H 6400 7400 50  0001 C CNN
F 3 "" H 6400 7400 50  0001 C CNN
	1    6400 7400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 6950 6400 6800
Wire Wire Line
	6400 6800 5850 6800
$Comp
L Device:C C15
U 1 1 6136DF6F
P 5350 3350
F 0 "C15" H 5400 3450 50  0000 L CNN
F 1 "100nF" H 5400 3250 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W2.5mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 5388 3200 50  0001 C CNN
F 3 "~" H 5350 3350 50  0001 C CNN
	1    5350 3350
	1    0    0    -1  
$EndComp
Text Notes 5200 6500 0    50   ~ 0
Numérisation de la sinusoïde\n        du secteur
Text GLabel 9750 1600 2    50   Input ~ 0
24V
Text Notes 5050 5550 2    50   ~ 0
24V Ac
Wire Wire Line
	6400 6800 6600 6800
Connection ~ 6400 6800
Text Label 10700 3550 0    50   ~ 0
Onde
Wire Wire Line
	10600 3550 11100 3550
Text Label 6600 6800 0    50   ~ 0
Onde
$Comp
L Regulator_Linear:L7805 U4
U 1 1 612165CD
P 4900 3150
F 0 "U4" H 4900 3392 50  0000 C CNN
F 1 "7824" H 4900 3301 50  0000 C CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Vertical" H 4925 3000 50  0001 L CIN
F 3 "http://www.st.com/content/ccc/resource/technical/document/datasheet/41/4f/b3/b0/12/d4/47/88/CD00000444.pdf/files/CD00000444.pdf/jcr:content/translations/en.CD00000444.pdf" H 4900 3100 50  0001 C CNN
	1    4900 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 3600 5350 3500
Wire Wire Line
	4900 3450 4900 3600
Connection ~ 4900 3600
Wire Wire Line
	4900 3600 5350 3600
Wire Wire Line
	5200 3150 5350 3150
Wire Wire Line
	5350 3200 5350 3150
Connection ~ 5350 3150
Wire Wire Line
	5350 3150 5600 3150
Wire Wire Line
	6800 4250 6800 4400
Connection ~ 6800 4250
$Comp
L power:PWR_FLAG #FLG0104
U 1 1 612E9C63
P 4500 3600
F 0 "#FLG0104" H 4500 3675 50  0001 C CNN
F 1 "PWR_FLAG" H 4500 3550 50  0000 C CNN
F 2 "" H 4500 3600 50  0001 C CNN
F 3 "~" H 4500 3600 50  0001 C CNN
	1    4500 3600
	1    0    0    -1  
$EndComp
Connection ~ 4500 3600
Wire Wire Line
	4500 3600 4900 3600
$Comp
L power:GND #PWR0113
U 1 1 612F6F19
P 3900 5200
F 0 "#PWR0113" H 3900 4950 50  0001 C CNN
F 1 "GND" H 3905 5027 50  0000 C CNN
F 2 "" H 3900 5200 50  0001 C CNN
F 3 "" H 3900 5200 50  0001 C CNN
	1    3900 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 5200 3900 5100
Text Notes 6200 4700 0    50   ~ 0
24Vac
Text Notes 6300 4300 0    50   ~ 0
24Vcc
Text Notes 6350 3600 0    50   ~ 0
24Vcc
Text Notes 6700 1850 2    50   ~ 0
24Vac\n34VPkPk
Text Notes 4400 1950 0    50   ~ 0
1A-F
Text Notes 3300 2350 0    50   ~ 0
1A-F
Text Notes 1300 1400 0    50   ~ 0
5A-F
Wire Wire Line
	6400 7250 6400 7400
Wire Wire Line
	5850 7250 5850 7400
Wire Wire Line
	4950 7250 4950 7400
Wire Notes Line
	4650 7650 4650 5450
Wire Notes Line
	4650 5450 6850 5450
Wire Notes Line
	6850 5450 6850 7650
Wire Notes Line
	6850 7650 4650 7650
$Comp
L Mechanical:MountingHole H9
U 1 1 611C0B77
P 3000 7500
F 0 "H9" H 3100 7546 50  0000 L CNN
F 1 "MountingHole" H 3100 7455 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.7mm_M2.5" H 3000 7500 50  0001 C CNN
F 3 "~" H 3000 7500 50  0001 C CNN
	1    3000 7500
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H10
U 1 1 611C0E5F
P 3800 7500
F 0 "H10" H 3900 7546 50  0000 L CNN
F 1 "MountingHole" H 3900 7455 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.7mm_M2.5" H 3800 7500 50  0001 C CNN
F 3 "~" H 3800 7500 50  0001 C CNN
	1    3800 7500
	1    0    0    -1  
$EndComp
Wire Notes Line
	2650 6350 4550 6350
Text Notes 10050 6050 0    50   ~ 0
connecteurs femelle
$Comp
L Connector_Generic:Conn_01x04 J8
U 1 1 6112687D
P 10700 5800
F 0 "J8" H 10780 5792 50  0000 L CNN
F 1 "Conn_01x04" H 10450 5450 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x04_P2.54mm_Vertical" H 10700 5800 50  0001 C CNN
F 3 "~" H 10700 5800 50  0001 C CNN
	1    10700 5800
	1    0    0    1   
$EndComp
$Comp
L Device:C C16
U 1 1 611A21A9
P 4300 3350
F 0 "C16" H 4350 3450 50  0000 L CNN
F 1 "100nF" H 4300 3250 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W2.5mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 4338 3200 50  0001 C CNN
F 3 "~" H 4300 3350 50  0001 C CNN
	1    4300 3350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R36
U 1 1 61262C17
P 6500 4900
F 0 "R36" V 6600 4750 50  0000 L CNN
F 1 "47k" V 6600 4950 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 6430 4900 50  0001 C CNN
F 3 "~" H 6500 4900 50  0001 C CNN
	1    6500 4900
	0    1    1    0   
$EndComp
$Comp
L Device:R R27
U 1 1 612F69D2
P 6100 2000
F 0 "R27" H 5950 2050 50  0000 C CNN
F 1 "4,7k" H 5950 1950 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 6030 2000 50  0001 C CNN
F 3 "~" H 6100 2000 50  0001 C CNN
	1    6100 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 5100 6250 5100
Wire Wire Line
	6100 2150 6100 2500
Wire Wire Line
	6000 2500 6100 2500
Wire Wire Line
	6000 2500 6000 5100
Wire Wire Line
	6100 2600 6100 4750
Wire Wire Line
	6700 2750 6750 2750
Connection ~ 6750 2750
Wire Wire Line
	6350 4900 6250 4900
Wire Wire Line
	6250 4900 6250 5100
Connection ~ 6250 5100
Wire Wire Line
	6250 5100 6850 5100
Wire Wire Line
	6700 4900 6700 4750
Wire Wire Line
	6700 4750 6100 4750
Wire Wire Line
	6650 4900 6700 4900
Connection ~ 6700 4900
Wire Wire Line
	6700 4900 6850 4900
Wire Wire Line
	6100 1200 6100 1850
Wire Wire Line
	6200 1200 6200 1850
Wire Wire Line
	6200 2150 6200 2750
Connection ~ 6200 2750
Wire Wire Line
	6200 2750 6200 2950
Wire Wire Line
	6200 2750 6400 2750
Wire Wire Line
	6200 2950 6850 2950
Wire Wire Line
	6300 1200 6300 1450
Wire Wire Line
	5500 1700 6750 1700
Wire Wire Line
	6100 2600 6750 2600
Wire Wire Line
	6750 2600 6750 2750
Wire Wire Line
	8900 3550 9600 3550
Text Label 8900 3550 0    50   ~ 0
Bp-
$Comp
L Switch:SW_MEC_5E Bp-1
U 1 1 6120DF9E
P 1750 5350
F 0 "Bp-1" H 1750 5735 50  0000 C CNN
F 1 "SW_MEC_5E" H 1750 5644 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_Omron_B3FS-101xP" H 1750 5650 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 1750 5650 50  0001 C CNN
	1    1750 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 5350 2050 5350
Wire Wire Line
	2200 5350 2200 6000
Connection ~ 2200 6000
Wire Wire Line
	1950 5250 2050 5250
Wire Wire Line
	2050 5250 2050 5350
Connection ~ 2050 5350
Wire Wire Line
	2050 5350 2200 5350
Wire Wire Line
	1550 5350 1400 5350
Wire Wire Line
	1550 5250 1400 5250
Wire Wire Line
	1400 5250 1400 5350
Connection ~ 1400 5350
$Comp
L Device:R R23
U 1 1 6125FE46
P 1100 5350
F 0 "R23" V 893 5350 50  0000 C CNN
F 1 "5,6k" V 984 5350 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 1030 5350 50  0001 C CNN
F 3 "~" H 1100 5350 50  0001 C CNN
	1    1100 5350
	0    1    1    0   
$EndComp
Wire Wire Line
	1250 5350 1400 5350
Wire Wire Line
	1400 5250 1400 4850
Connection ~ 1400 5250
Text Label 1400 5000 1    50   ~ 0
Bp-
Wire Wire Line
	950  5350 750  5350
Wire Notes Line
	2350 3350 600  3350
Wire Notes Line
	2350 6450 600  6450
Text Notes 1750 6700 0    50   ~ 0
connecteur femelle
$Comp
L Device:R R37
U 1 1 611F818F
P 6800 1450
F 0 "R37" V 6900 1400 50  0000 L CNN
F 1 "0" V 6700 1400 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 6730 1450 50  0001 C CNN
F 3 "~" H 6800 1450 50  0001 C CNN
	1    6800 1450
	0    1    1    0   
$EndComp
Wire Wire Line
	6950 1450 7100 1450
Wire Wire Line
	6650 1450 6600 1450
Wire Wire Line
	6600 1450 6600 1400
$Comp
L Device:R R38
U 1 1 612CC0F5
P 9700 5800
F 0 "R38" V 9600 5950 50  0000 C CNN
F 1 "1,2k" V 9600 5700 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 9630 5800 50  0001 C CNN
F 3 "~" H 9700 5800 50  0001 C CNN
	1    9700 5800
	0    1    1    0   
$EndComp
Wire Wire Line
	9000 5600 10250 5600
Wire Notes Line
	8700 4450 10950 4450
Wire Notes Line
	8700 6450 10950 6450
Wire Wire Line
	9600 3250 8900 3250
Text Label 8900 3250 0    50   ~ 0
BpEnt
Wire Wire Line
	750  3650 750  4050
$Comp
L Switch:SW_MEC_5E BpEch1
U 1 1 612A020B
P 1750 4050
F 0 "BpEch1" H 1750 4435 50  0000 C CNN
F 1 "SW_MEC_5E" H 1750 4344 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_Omron_B3FS-101xP" H 1750 4350 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 1750 4350 50  0001 C CNN
	1    1750 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 4050 2050 4050
Wire Wire Line
	1950 3950 2050 3950
Wire Wire Line
	2050 3950 2050 4050
Connection ~ 2050 4050
Wire Wire Line
	2050 4050 2200 4050
Wire Wire Line
	1550 4050 1400 4050
Wire Wire Line
	1550 3950 1400 3950
Wire Wire Line
	1400 3950 1400 4050
Connection ~ 1400 4050
$Comp
L Device:R R39
U 1 1 612A021A
P 1100 4050
F 0 "R39" V 893 4050 50  0000 C CNN
F 1 "5,6k" V 984 4050 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 1030 4050 50  0001 C CNN
F 3 "~" H 1100 4050 50  0001 C CNN
	1    1100 4050
	0    1    1    0   
$EndComp
Wire Wire Line
	1250 4050 1400 4050
Wire Wire Line
	1400 3950 1400 3550
Connection ~ 1400 3950
Text Label 1400 3700 1    50   ~ 0
BpEch
Wire Wire Line
	950  4050 750  4050
Connection ~ 750  4050
Wire Wire Line
	750  4050 750  4700
Wire Wire Line
	2200 6000 2200 6150
NoConn ~ 10600 2950
$Comp
L Switch:SW_MEC_5E Bp-Ent1
U 1 1 6125B828
P 1750 4700
F 0 "Bp-Ent1" H 1750 5085 50  0000 C CNN
F 1 "SW_MEC_5E" H 1750 4994 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_Omron_B3FS-101xP" H 1750 5000 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 1750 5000 50  0001 C CNN
	1    1750 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 4700 2050 4700
Wire Wire Line
	1950 4600 2050 4600
Wire Wire Line
	2050 4600 2050 4700
Connection ~ 2050 4700
Wire Wire Line
	2050 4700 2200 4700
Wire Wire Line
	1550 4700 1400 4700
Wire Wire Line
	1550 4600 1400 4600
Wire Wire Line
	1400 4600 1400 4700
Connection ~ 1400 4700
$Comp
L Device:R R5
U 1 1 6125C1E5
P 1100 4700
F 0 "R5" V 893 4700 50  0000 C CNN
F 1 "5,6k" V 984 4700 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 1030 4700 50  0001 C CNN
F 3 "~" H 1100 4700 50  0001 C CNN
	1    1100 4700
	0    1    1    0   
$EndComp
Wire Wire Line
	1250 4700 1400 4700
Wire Wire Line
	1400 4600 1400 4200
Connection ~ 1400 4600
Text Label 1400 4350 1    50   ~ 0
BpEnt
Wire Wire Line
	950  4700 750  4700
Wire Wire Line
	750  4700 750  5350
Connection ~ 750  4700
Connection ~ 750  5350
Wire Wire Line
	750  5350 750  6000
Wire Notes Line
	2350 3350 2350 6450
Wire Notes Line
	600  3350 600  6450
Text Label 8900 3150 0    50   ~ 0
BpEch
Text Notes 8150 1700 1    50   ~ 0
fermé
Text Notes 8050 1700 1    50   ~ 0
ouvert
$Comp
L Connector_Generic:Conn_01x04 J11
U 1 1 612AA2D1
P 10700 5200
F 0 "J11" H 10780 5192 50  0000 L CNN
F 1 "Conn_01x04" H 10450 4850 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x04_P2.54mm_Vertical" H 10700 5200 50  0001 C CNN
F 3 "~" H 10700 5200 50  0001 C CNN
	1    10700 5200
	1    0    0    1   
$EndComp
Wire Wire Line
	10500 5300 10250 5300
Wire Wire Line
	10250 5300 10250 5600
Connection ~ 10250 5600
Wire Wire Line
	10250 5600 10500 5600
Wire Wire Line
	9850 5800 10500 5800
Wire Wire Line
	9550 5800 9200 5800
Connection ~ 9000 5900
Wire Wire Line
	9000 5900 10500 5900
Wire Wire Line
	10500 5200 10000 5200
Wire Wire Line
	10500 5100 10000 5100
Wire Wire Line
	10000 5100 10000 5200
Wire Wire Line
	10000 5200 10000 5300
Connection ~ 10000 5200
$Comp
L power:GND #PWR020
U 1 1 6137DFF0
P 10000 5300
F 0 "#PWR020" H 10000 5050 50  0001 C CNN
F 1 "GND" H 10005 5127 50  0000 C CNN
F 2 "" H 10000 5300 50  0001 C CNN
F 3 "" H 10000 5300 50  0001 C CNN
	1    10000 5300
	1    0    0    -1  
$EndComp
Connection ~ 9450 5000
Text Notes 9900 5000 0    50   ~ 0
ANT
Wire Notes Line
	10950 4450 10950 6450
Wire Notes Line
	8700 4450 8700 6450
Wire Wire Line
	9450 5000 10500 5000
Wire Wire Line
	9550 4900 9550 5150
Wire Wire Line
	10500 5700 10150 5700
NoConn ~ 10150 5700
Text Label 10250 5700 0    50   ~ 0
ERR
Wire Wire Line
	8850 2650 9600 2650
Wire Wire Line
	8200 2650 8550 2650
Wire Wire Line
	8900 3150 9600 3150
Wire Wire Line
	9200 5000 9450 5000
Wire Wire Line
	7450 3400 7800 3400
$Comp
L Device:EMI_Filter_LL FL1
U 1 1 613951C8
P 1050 2500
F 0 "FL1" V 1004 2644 50  0000 L CNN
F 1 "Wurth 7446223001" H 750 2200 50  0000 L CNN
F 2 "Filter:Filtre_wurth" H 1050 2540 50  0001 C CNN
F 3 "~" H 1050 2540 50  0001 C CNN
	1    1050 2500
	0    1    1    0   
$EndComp
Wire Wire Line
	1200 2100 1250 2100
Wire Wire Line
	900  2100 850  2100
Wire Wire Line
	850  2100 850  2300
Wire Wire Line
	850  2300 950  2300
Connection ~ 850  2100
Wire Wire Line
	1150 2300 1250 2300
Wire Wire Line
	1250 2300 1250 2100
Connection ~ 1250 2100
Wire Wire Line
	1200 1800 1250 1800
Connection ~ 1250 1800
Wire Wire Line
	1250 1800 1250 2100
Wire Wire Line
	900  1800 850  1800
Connection ~ 850  1800
Wire Wire Line
	850  1800 850  2100
Wire Wire Line
	1250 1650 1250 1800
$Comp
L Device:C C18
U 1 1 61441522
P 1050 2900
F 0 "C18" V 900 2900 50  0000 C CNN
F 1 "100nF 400V" V 1200 2950 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L16.5mm_W6.0mm_P15.00mm_MKT" H 1088 2750 50  0001 C CNN
F 3 "~" H 1050 2900 50  0001 C CNN
	1    1050 2900
	0    1    1    0   
$EndComp
Wire Wire Line
	950  2700 850  2700
Wire Wire Line
	850  2700 850  2900
Wire Wire Line
	1250 2700 1250 2900
Wire Wire Line
	1150 2700 1250 2700
Wire Wire Line
	1200 2900 1250 2900
Connection ~ 1250 2900
Wire Wire Line
	1250 2900 1250 3000
Wire Wire Line
	900  2900 850  2900
Connection ~ 850  2900
Wire Wire Line
	1250 3000 1400 3000
Wire Wire Line
	1400 3000 1400 1700
Wire Wire Line
	1400 1700 2050 1700
Connection ~ 2050 1700
Wire Wire Line
	850  3150 1700 3150
Wire Wire Line
	1700 3150 1700 2300
Wire Wire Line
	850  2900 850  3150
Wire Wire Line
	1800 2300 1700 2300
Connection ~ 1700 2300
Wire Wire Line
	1700 2300 1700 1800
Wire Wire Line
	850  1200 850  1800
Wire Wire Line
	2200 4050 2200 4700
Wire Wire Line
	2200 4700 2200 5350
Connection ~ 2200 4700
Connection ~ 2200 5350
Wire Wire Line
	3250 1200 3250 1450
NoConn ~ 3250 1450
Wire Wire Line
	3900 4400 3900 4300
Text Notes 3500 3050 0    50   ~ 0
32V\nPkPk
Text GLabel 3150 4400 0    50   Input ~ 0
24V
Wire Wire Line
	3150 4400 3300 4400
Wire Wire Line
	2750 3600 2750 3150
Wire Wire Line
	2750 3150 2850 3150
Wire Wire Line
	3150 3450 3150 3850
Wire Wire Line
	2500 2750 2500 3850
Text Label 3450 3150 0    50   ~ 0
24VR
$Comp
L Device:R R40
U 1 1 613E5332
P 6750 2000
F 0 "R40" H 6820 2046 50  0000 L CNN
F 1 "220" H 6820 1955 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 6680 2000 50  0001 C CNN
F 3 "~" H 6750 2000 50  0001 C CNN
	1    6750 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6750 1700 6750 1850
Wire Wire Line
	6750 2150 6750 2600
Connection ~ 6750 2600
NoConn ~ 10600 3650
Wire Wire Line
	5100 4150 5100 4400
Wire Wire Line
	3150 3850 2500 3850
Wire Wire Line
	3150 2850 3150 2750
Connection ~ 3150 2750
Wire Wire Line
	3150 2750 3150 2600
Wire Wire Line
	3150 2300 3150 2100
Wire Wire Line
	3150 2100 3350 2100
$Comp
L Diode:1N4004 D3
U 1 1 614864E8
P 3750 3150
AR Path="/614864E8" Ref="D3"  Part="1" 
AR Path="/6130ED2A/614864E8" Ref="D?"  Part="1" 
F 0 "D3" H 3700 3000 50  0000 L CNN
F 1 "1N4004" H 3600 3300 50  0000 L CNN
F 2 "Diode_THT:D_DO-41_SOD81_P10.16mm_Horizontal" H 3750 2975 50  0001 C CNN
F 3 "http://www.vishay.com/docs/88503/1n4001.pdf" H 3750 3150 50  0001 C CNN
	1    3750 3150
	-1   0    0    1   
$EndComp
$Comp
L power:PWR_FLAG #FLG0103
U 1 1 612D7398
P 4300 3100
F 0 "#FLG0103" H 4300 3175 50  0001 C CNN
F 1 "PWR_FLAG" H 4400 3250 50  0000 C CNN
F 2 "" H 4300 3100 50  0001 C CNN
F 3 "~" H 4300 3100 50  0001 C CNN
	1    4300 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 3100 4300 3150
Wire Wire Line
	4300 3500 4300 3600
Connection ~ 4300 3600
Wire Wire Line
	4300 3600 4500 3600
Wire Wire Line
	2750 3600 4000 3600
Wire Wire Line
	4000 3500 4000 3600
Connection ~ 4000 3600
Wire Wire Line
	4000 3600 4300 3600
Wire Wire Line
	4000 3600 4000 3700
Wire Wire Line
	4000 3200 4000 3150
Connection ~ 4000 3150
Wire Wire Line
	4000 3150 4300 3150
Wire Wire Line
	3900 3150 4000 3150
Wire Wire Line
	3450 3150 3600 3150
Connection ~ 4300 3150
Wire Wire Line
	4300 3150 4300 3200
Wire Wire Line
	4300 3150 4600 3150
Wire Wire Line
	3600 4400 3900 4400
Wire Wire Line
	8150 1200 8150 1700
Wire Wire Line
	8050 1200 8050 1750
$Comp
L power:GND #PWR021
U 1 1 61475235
P 8450 2200
F 0 "#PWR021" H 8450 1950 50  0001 C CNN
F 1 "GND" H 8600 2100 50  0000 C CNN
F 2 "" H 8450 2200 50  0001 C CNN
F 3 "" H 8450 2200 50  0001 C CNN
	1    8450 2200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C19
U 1 1 61476166
P 8750 1950
F 0 "C19" H 8600 2050 50  0000 L CNN
F 1 "100nF" H 8500 1850 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W2.5mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 8788 1800 50  0001 C CNN
F 3 "~" H 8750 1950 50  0001 C CNN
	1    8750 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 61477B49
P 8450 1950
F 0 "C1" H 8300 2050 50  0000 L CNN
F 1 "100nF" H 8200 1850 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W2.5mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 8488 1800 50  0001 C CNN
F 3 "~" H 8450 1950 50  0001 C CNN
	1    8450 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8450 2200 8450 2150
Wire Wire Line
	8450 2150 8750 2150
Wire Wire Line
	8750 2150 8750 2100
Connection ~ 8450 2150
Wire Wire Line
	8450 2150 8450 2100
Wire Wire Line
	8450 1800 8450 1750
Wire Wire Line
	8450 1750 8050 1750
Connection ~ 8050 1750
Wire Wire Line
	8050 1750 8050 1850
Wire Wire Line
	8150 1700 8750 1700
Wire Wire Line
	8750 1700 8750 1800
Connection ~ 8150 1700
Wire Wire Line
	8150 1700 8150 1850
$Comp
L Device:C C20
U 1 1 6152F293
P 9050 1950
F 0 "C20" H 8900 2050 50  0000 L CNN
F 1 "100nF" H 8800 1850 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W2.5mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 9088 1800 50  0001 C CNN
F 3 "~" H 9050 1950 50  0001 C CNN
	1    9050 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8250 1600 9050 1600
Wire Wire Line
	9050 1800 9050 1600
Connection ~ 9050 1600
Wire Wire Line
	9050 1600 9200 1600
Wire Wire Line
	8750 2150 9050 2150
Wire Wire Line
	9050 2150 9050 2100
Connection ~ 8750 2150
Wire Wire Line
	7500 2950 7500 3100
Wire Wire Line
	7450 4900 8100 4900
Wire Wire Line
	7500 5100 7500 5350
Wire Notes Line
	4550 6350 4550 7650
Wire Notes Line
	2650 7650 2650 6350
Text Notes 6900 5350 0    50   ~ 0
ACPL-844 ou\n4xSFH620
$EndSCHEMATC
