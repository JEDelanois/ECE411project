SEGMENT  CodeSegment:

   LDR  R1, R0, NEGTWO  ; R1 <= -2
   LDR  R2, R0, TWO     ; R2 <= 2
   LDR  R4, R0, ONE     ; R4 <= 1
   LDR  R5, R0, TEMP1
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   JMP  R5             ; change with JMP
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
   LDR  R1, R0, GOOD
   BRnzp DONE
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
