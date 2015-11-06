SEGMENT  CodeSegment:

   LDR  R1, R0, BADD  ; R1 <= -2
   LDR  R2, R0, ONE
   LEA  R3, NEGTWO
   LEA  R4, GOOD
   NOP
   NOP
   NOP
   NOP
   STB  R1, R3, 0
   STB  R1, R4, 1
   LEA  R5, DONE
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   JSRR  R5; change with jsr
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP


ONE:    DATA2 4x0001
TWO:    DATA2 4x0002
NEGTWO: DATA2 4xFFFE
TEMP1:  DATA2 4x0032
GOOD:   DATA2 4x600D
BADD:   DATA2 4xBADD

DONE:
   LDR R5, R0, NEGTWO
   LDR R6, R0, GOOD
   BRnzp DONE
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
