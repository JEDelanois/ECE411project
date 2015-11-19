SEGMENT  CodeSegment:

   LDR R1, R0, A
   LDR R2, R0, B
   ADD R1, R1, R2
   STR R1, R0, C
   AND R3, R1, 4
   ADD R3, R1, R3
   BRnzp DONE


A:    DATA2 4x0001
B:    DATA2 4x0002
C:    DATA2 4xBADD

DONE:
   LDR  R4, R0, C
   BRnzp DONE
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
