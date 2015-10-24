ORIGIN 4x0000

SEGMENT

	ADD R0, R1, 10
	JMP R0		;;This should jump across the add instructions
	ADD R5, R5, -1
	ADD R4, R4, 0
	ADD R3, R3, 1


	LDR R7, R7, VARIABLE	;;Loads address 1 into R7 to be used by ret
	RET

HALT:
	BRnzp HALT		;;End program and loop infinitely


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Constants used in the program;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
VARIABLE: 	DATA2 4x0002	;;The number
NEG_ONE: 	DATA2 4xFFFF	;;Negative 1 to be put into R0
CLEAR:		DATA2 4x0000	;;Zero used to clear registers
