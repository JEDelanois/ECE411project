ORIGIN 0

	LDI R0, R1, LOC
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP

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