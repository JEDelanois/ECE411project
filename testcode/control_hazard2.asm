SEGMENT  CodeSegment:

   LDR R1, R0, A
   LDR R2, R0, B
   JSR LOOP1
   BRz BAD
   LEA R3, LOOP2
   JSRR R3
   BRz BAD
   TRAP indirection
NOP
   BRn BAD
   BRp BAD
   BRz DONE
   ADD R1, R1, R2
   LEA R6, BAD
   JMP R6


A:    DATA2 4x0006
B:    DATA2 4xFFFF
C:    DATA2 4xBADD
D:    DATA2 4x600D
indirection: DATA2 LOOP3

BAD:
   LDR R4, R0, C
   BRnzp BAD

DONE:
   LDR  R4, R0, D
   BRnzp DONE
   
LOOP1:
   ADD R1, R1, R2
   RET

LOOP2:
   ADD R1, R1, R2
   ADD R1, R1, R2
   RET

LOOP3:
   ADD R1, R1, R2
   ADD R1, R1, R2
   ADD R1, R1, R2
   RET
