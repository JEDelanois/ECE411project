SEGMENT  CodeSegment:

   ADD R0, R0, 10
   LDR R1, R2, NEG

LOOP:
   ADD R2, R2, 2
   ADD R3, R3, 3
   BRn BAD
   ADD R0, R0, R1
   BRp WAIT
   ADD R6, R6, 6
   ADD R7, R7, 7
   
HALT:
   BRnzp HALT

WAIT:
   ADD R5, R5, 5
   BRnzp LOOP

BAD:
   ADD R2, R1, 0
   ADD R3, R1, 0
   BRnzp BAD
   
NEG: DATA2 4xFFFF