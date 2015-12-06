ORIGIN 0

;div instruction
LDR R1, R0, div1
LDR R2, R0, div2  

DIV R3, R1, R2 ; result in R3

ADD R6, R3, 0
AND R1, R0, 0
AND R2, R0, 0
AND R3, R0, 0


;div loop result i R3
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
div1: DATA2 10
div2: DATA2 2

;       			multDATA
mult1: DATA2 1
mult2: DATA2 -6550

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
;mult loop result in R3
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



BRnzp HALT











HALT:
	BRnzp HALT
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP




bits1: DATA2 4x1010
bits2: DATA2 4x1100


