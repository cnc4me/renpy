%
O00911 (Macro: Single Blade Clamp Op1)

(~~~~~~~~~ SETUP ~~~~~~~~~)
(FIRST THRU HOLE X LOC:)
#850= .875
(FIRST THRU HOLE Y LOC:)
#851= .790
(SPREAD DISTANCE:)
#852= 5.9371
(FINISH LENGTH:)
#853= 43.310
(ORIENT WITH RADIUS HEEL FACING)
(DOWN AND TOWARDS OPERATOR)

(~~~~~~~~~ TOOLS ~~~~~~~~~)
(T26: DRILL & CSINK COMBO)
(T25: 1/2" CARBIDE 3FLT ENDMILL)

(~~~~~~~~~ ZEROS ~~~~~~~~~)
( G54 )
(X0 - RHS OF FIXTURE, +1/4" TO AVOID MILLING FIXTURE)
(Y0 - BACK RAIL OF FIXTURE)
(Z0 - TOP OF FLAT MATERIAL, NOT RADIUS)




(~~~~~~~~~ BEGIN ~~~~~~~~~)
T25 M06 (1/2" CARBIDE 3FLT ENDMILL)
M01 (1/2" CARBIDE 3FLT ENDMILL)
G00 G90 G54 X.25 Y.4
S7500 M03
G43 H25 Z1. T26
G00 Z0.1
M08
G01 Z-.4 F20.
G01 Y-1.4
G00 Z1.
M09
M05
G91 G28 Z0.
M01

G00 G17 G20 G40 G49 G80 G90
T26 M06 (DRILL & CSINK COMBO)
M01 (DRILL & CSINK COMBO)
G00 G90 G54 X-#850 Y-#851
S2300 M03
G43 H26 Z1. T1
M08
G81 G98 R0.1 Z-0.407 F10.
G91 X-#852 L[ FIX[ #853 / #852 ]]
G80
G00 Z1.
M09
M05
G91 G28 Z0.
( CENTER AND PRESENT TO OPERATOR )
G00 G90 G53 X-[ #853 / 2 ] Y0.
T25 M06
M30

(~~~~~~~~~ CHANGELOG ~~~~~~~~~)
(11/15/2018 KKH - INITIAL PROGRAM)
(11/16/2018 KKH - PART CENTERING AND PRESENTING)
%
