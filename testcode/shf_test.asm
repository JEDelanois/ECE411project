SEGMENT  CodeSegment:

   LDR  R1, R0, BADD  ; R1 <= -2
   LDR  R2, R0, TEMP1  ; R2 <= 2
   LSHF R4, R1, 4     ; R4 <= 1
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
   RSHFL R3, R1, 4
   RSHFA R2, R1, 4
   BRnzp DONE
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
