SEGMENT  CodeSegment:

   ADD R1, R0, 1
   BRnzp DONE
   ADD R2, R0, 2
   ADD R3, R0, 3
   ADD R4, R0, 4
   ADD R5, R0, 5
   ADD R6, R0, 6

BAD:
   ADD R7, R0, 4
   BRnzp BAD

DONE:
   ADD R7, R0, 7
   BRnzp DONE

