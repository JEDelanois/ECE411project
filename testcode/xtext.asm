ORIGIN 0

ADD R1, R0, 3
ADD R2, R0, 4
MULT R3, R1, R2
ADD R7, R7, 7

HALT:
	BRnzp HALT
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP

WIN: DATA2 8
LOC: DATA2 4x001C   
