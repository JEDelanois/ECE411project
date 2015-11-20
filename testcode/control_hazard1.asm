SEGMENT  CodeSegment:

   LDR R1, R0, A
   LDR R2, R0, B
   ADD R1, R1, R2
   BRz BAD
   ADD R1, R1, R2
   BRn BAD
   BRp BAD
   BRz DONE
   ADD R1, R1, R2
   BRnzp BAD


A:    DATA2 4x0002
B:    DATA2 4xFFFF
C:    DATA2 4x600D
D:    DATA2 4xBADD

BAD:
   LDR  R4, R0, D
   BRnzp BAD

DONE:
   LDR  R4, R0, C
   BRnzp DONE
