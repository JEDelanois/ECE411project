ORIGIN 0

;div instruction
LDR R1, R0, div1
LDR R2, R0, div2  

DIV R3, R1, R2 ; result in R3

ADD R6, R3, 0
AND R1, R0, 0
AND R2, R0, 0
AND R3, R0, 0


;div loop result i R3  doesnt work for negatives cannot hadle dive by zero
LDR R1, R0, div1
LDR R2, R0, div2
AND R3, R0, 0
AND R6, R0, 0

divStart:
SUB R4, R1, R2
BRn divDone
SUB R1, R1, R2
ADD R3, R3, 1
BRnzp divStart


divDone:
ADD R6, R3, 0
AND R7, R0, 0
AND R1, R0, 0
AND R2, R0, 0
AND R3, R0, 0
AND R4, R0, 0
BRnzp multInstruction
;				div DATA
div1: DATA2 100
div2: DATA2 5

;       			multDATA
mult1: DATA2 1
mult2: DATA2 7

multInstruction:
AND R6, R0, 0
LDR R1, R0, mult1
LDR R2, R0, mult2

MULT R3, R1, R2

ADD R6, R3, 0
AND R1, R0, 0
AND R2, R0, 0
AND R3, R0, 0



;mult loop
;mult loop result in R3 works with negative but super slow
AND R3, R0, 0
ADD R4, R0, 1
AND R6, R0, 0
LDR R1, R0, mult1
LDR R2, R0, mult2
BRz multDone

multStart:
ADD R3, R3, R1
SUB R2, R2, R4
BRz multDone
BRnzp multStart


multDone:
ADD R6, R3, 0
AND R1, R0, 0
AND R2, R0, 0
AND R3, R0, 0


LEA R0, bits1
LDR R1, R0, 0
LEA R0, bits2
LDR R2, R0, 0
AND R0, R0,0

ADD R6, R0, 6
SUB R6, R6, R4
AND R6, R0, 0

XOR R0, R1, R2
AND R0, R0, 0


OR R0, R1, R2
AND R0, R0, 0

NAND R0, R1, R2
AND R0, R0, 0

NOR R0, R1, R2
AND R0, R0, 0

XNOR R0, R1, R2
AND R0, R0, 0



HALT:
	BRnzp HALT


bits1: DATA2 4x1010
bits2: DATA2 4x1100




