ORIGIN 0

	LDI R0, R1, LOC
	DIV R0,R0,  R0
	MULT R0,R0,  R0
	SUB R0,R0,  R0
	XOR R0,R0,  R0
	OR R0,R0,  R0

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
