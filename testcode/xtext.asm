ORIGIN 0

;div instruction
LDR R1, R0, div1
LDR R2, R0, div2  
ADD R7, R0, 1

DIV R3, R1, R2 ; result in R3

AND R7, R0, 0
AND R1, R0, 0
AND R2, R0, 0
AND R3, R0, 0


;div loop result i R3
LDR R1, R0, div1
LDR R2, R0, div2
AND R3, R0, 0

ADD R7, R0, 1

divStart:
SUB R4, R1, R2
BRnz divDone
SUB R1, R1, R2
ADD R3, R3, 1
BRnzp divStart


divDone:
AND R7, R0, 0
BRnzp multInstruction
;				DATA
div1: DATA2 10
div2: DATA2 2




multInstruction:
LDR R1, R0, mult1
LDR R2, R0, mult2

MULT R4, R1, R2

AND R1, R0, 0
AND R2, R0, 0



;mult loop



BRnzp HALT
mult1: DATA2 267
mult2: DATA2 5










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


