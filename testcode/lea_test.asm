SEGMENT  CodeSegment:

   LDR  R1, R0, NEGTWO  ; R1 <= -2
   LDR  R2, R0, TEMP1  ; R2 <= 2
   LDR  R4, R0, ONE     ; R4 <= 1
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
   LDB  R1, R5, -2
   LDB  R2, R5, -1
   BRnzp DONE
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
