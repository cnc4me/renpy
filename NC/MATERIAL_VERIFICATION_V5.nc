%
O7999(MATERIAL VERIFICATION V5)

( G65 P7999 X2.5 Y-1. U.3 V-.3 Q.05)
( G65 P7999 X2.5 Y-1. R.125 U.3 V-.3)
( G65 P7999 X3.1 Y1.0 Z.05 U-.3 V.3 A.05 B.03 C.05)
( X - X LOC. OF CORNER )
( Y - Y LOC. OF CORNER )
( U - X SHIFT AMOUNT )
( V - Y SHIFT AMOUNT )
( R - RAW STOCK Z PLANE )
( Q - DEFAULT TOLERANCE, ALL AXES )
( A - X AXIS TOLERANCE )
( B - Y AXIS TOLERANCE )
( C - Z AXIS TOLERANCE )

( V1 - INITIAL WORKING VERSION )
( V2 - ADDED TOLERANCE PARAMS, PARAM CHECKING, RAW STOCK ALLOWANCE IN Z )
( V3 - ADDED OP1 ERROR FLAG FOR OP2 TO CHECK IF PROBING FAILS )
( V4 - REMOVING ERROR FLAG AND FIXING SHALLOW Z BUG )
( V5 - DETECTING TOUCH BEFORE MEASURE MOVEMENT )

#26=-.2 ( PROBE DEPTH )
#9=100. ( PROTECTED POSITIONING FEEDRATE )

( CHECK FOR MANDATORY PARAMETERS )
IF[#24 EQ #0] GOTO942
IF[#25 EQ #0] GOTO943
IF[#21 EQ #0] GOTO944
IF[#22 EQ #0] GOTO945

( USE PASSED DATUM TOLERANCE IF GIVEN )
( OTHERWISE DEFAULTS TO .03" )
IF[#17 NE #0] GOTO10
#17=.04
N10 #17=ABS[#17]

( USE PASSED X TOLERANCE IF GIVEN )
( OTHERWISE USE DEFAULT )
IF[#1 NE #0] GOTO20
#1=#17
N20 #1=ABS[#1]

( USE PASSED Y TOLERANCE IF GIVEN )
( OTHERWISE USE DEFAULT )
IF[#2 NE #0] GOTO30
#2=#17
N30 #2=ABS[#2]

( USE PASSED Z TOLERANCE IF GIVEN )
( OTHERWISE USE DEFAULT )
IF[#3 NE #0] GOTO40
#3=#17
N40 #3=ABS[#3]

( USE PASSED RAW STOCK Z PLANE AMOUNT IF GIVEN )
( OTHERWISE DEFAULTS TO 0 )
IF[#18 NE #0] GOTO50
#18=0
N50 IF[#18 LT 0] GOTO941

G65 P9832

( APPROACH MATERIAL )
G65 P9810 Z2. M1.
IF[#148 NE 0] GOTO911 ( PATH OBSTRUCTION )

( MOVE X,Y SHIFT AMOUNT FROM CURRENT POS. )
( IN OPPOSITE DIRECTION TO POSITION OVER )
( MATERIAL FOR Z CHECK )
G65 P9810 X[#24 + [-#21]] Y[#25 + [-#22]]

( TRY AND TOUCH SURFACE OF MATERIAL )
( IF NOTHING IS THERE, JUMP TO Tnnn )
G229 Z-2.03 T910

( MATERIAL FOUND, MOVE TO MEASURE POSITION )
G65 P9810 Z[.3 + #18] M1.
IF[#148 NE 0] GOTO911 ( PATH OBSTRUCTION )

( MEASURE Z SURFACE AND CHECK IF )
( IT IS MORE THAN ERROR AMOUNT )
G65 P9811 Z#18
IF[#142 GT #3] GOTO914

G65 P9810 X[#24 + #21] F#9 M1.
IF[#148 NE 0] GOTO911 ( PATH OBSTRUCTION )

G65 P9810 Z#26 M1.
IF[#148 NE 0] GOTO911 ( PATH OBSTRUCTION )

( MEASURE X SURFACE AND CHECK IF )
( IT IS MORE THAN ERROR AMOUNT )
G65 P9811 X#24
IF[#140 GT #1] GOTO912

G65 P9810 Z[.25 + #18] F#9
G65 P9810 X[#24 + [-#21]] F#9
G65 P9810 Y[#25 + #22] M1.
IF[#148 NE 0] GOTO911 ( PATH OBSTRUCTION )

G65 P9810 Z#26 M1.
IF[#148 NE 0] GOTO911 ( PATH OBSTRUCTION )

( MEASURE Y SURFACE AND CHECK IF )
( IT IS MORE THAN ERROR AMOUNT )
G65 P9811 Y#25
IF[#141 GT #2] GOTO913

G65 P9810 Z2. F#9

G65 P9833
M107
M01 ( CORRECT MATERIAL, MAKE SOME CHIPS! )
M99


(---------------------------)
(  CHECKS FAILED SOMEWHERE  )
(---------------------------)
N910
M01 ( MATERIAL NOT FOUND! )
GOTO3000

N911
M01 ( THERE SHOULD BE... NO TOUCHING! )
GOTO3000

N912
M01 ( OUT OF TOLERANCE [X] )
GOTO3000

N913
M01 ( OUT OF TOLERANCE [Y] )
GOTO3000

N914
M01 ( OUT OF TOLERANCE [Z] )
GOTO3000

N3000
G91 G1 Z1. F50.
G65 P9833
M107
M30


N941#3000=1(STOCK ABOVE Z0 MUST BE POSITIVE)
N942#3000=2(X DATUM LOCATION MUST BE GIVEN [X])
N943#3000=3(Y DATUM LOCATION MUST BE GIVEN [Y])
N944#3000=4(X SHIFT AMOUNT MUST BE GIVEN [U])
N945#3000=5(Y SHIFT AMOUNT MUST BE GIVEN [V])
M99
%
