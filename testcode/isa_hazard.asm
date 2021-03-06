SEGMENT CodeSegment:    ; Version 0.11  1/13/2005
    LEA R0, DataSegment
    BRnzp skip
    
SEGMENT DataSegment:
ZERO:       DATA2 0
ONETWELVE:  DATA2 112
ENT:        DATA2 10
NINER:      DATA2 9999
GECKO:      DATA2 42
NOT6:       DATA2 4xBAC8
THREE:      DATA2 7
TREE:       DATA2 3
BADBAD:     DATA2 4x0BAD
PAT1:       DATA2 4x0D0D
PAT2:       DATA2 4x9884
PAT3:       DATA2 4xAE85
GOOD:       DATA2 4x5460
five:       DATA2 5
TT:         DATA2 4x646
RES1:       DATA2 0
RES2:       DATA2 0
RES3:       DATA2 0
RES4:       DATA2 0
RES5:       DATA2 0
RES6:       DATA2 0
RES7:       DATA2 0
RES8:       DATA2 0
RES9:       DATA2 0
RES10:      DATA2 0
RES11:      DATA2 0
RES12:      DATA2 0
RES13:      DATA2 0
RES14:      DATA2 0
RES15:      DATA2 0
RES16:      DATA2 0
Bear:       DATA2 CatchMe
Owl:        DATA2 paris

skip:
    LDR R1, R0, ZERO
    LDR R2, R0, ONETWELVE
    LDR R7, R0, ENT
    ADD R1, R2, R7
    ADD R3, R1, -4
    ADD R1, R1, R3
    ADD R1, R1, R1
    STR R1, R0, RES1
    LDR R1, R0, NINER
    LDR R2, R0, GECKO
    AND R6, R1, R2
    AND R5, R6, 10
    STR R5, R0, RES2
    LDR R7, R0, NOT6
    NOT R7, R7
    STR R7, R0, RES3
    LDR R1, R0, PAT1
    LSHF R2, R1, 4
    RSHFL R3, R1, 2
    LSHF R2, R2, 1
    RSHFL R3, R3, 1
    ADD R2, R2, R3
    ADD R2, R2, 1
    RSHFA R4, R1, 3
    LDR R1, R0, PAT2
    RSHFA R5, R1, 6
    STR R2, R0, RES4
    STR R4, R0, RES5
    STR R5, R0, RES6
    LEA R1, RES7
    STR R1, R0, RES8
    ADD R5, R5, 13
    STI R5, R0, RES8
    LDR R1, R0, TREE
    LDR R2, R0, THREE
    AND R3, R3, 0
loop1:
    ADD R2, R2, 5
    ADD R1, R1, -1
    BRp loop1
loop2:
    ADD R1, R1, 7
    ADD R2, R2, -6
    BRp loop2
    BRz loop1
    BRn miami
    LDR R2, R0, five
miami:
    ADD R2, R2, R1
    STR R2, R0, RES8
    LDR R6, R0, ZERO
    JSR dallas
    STR R6, R0, RES9
    AND R5, R5, 13
    LEA R3, portland
    JMP R3
    LDR R5, R0, BADBAD
portland:
    STR R5, R0, RES10
    LDR R5, R0, BADBAD
    TRAP Bear
    STR R5, R0, RES11
    AND R1, R1, 0
    ADD R1, R1, 8
    ADD R1, R1, 9
    LDB R2, R0, PAT3
    LDB R3, R1, PAT3
    ADD R4, R3, R2
    STR R4, R0, RES12
    ADD R2, R2, 11
    ADD R3, R3, -2
    LEA R1, DataSegment2
    ;the following STB instructions store to mem[RES17]
    BRnzp skip2

SEGMENT DataSegment2:
TS:     DATA2 4x646
RES17:  DATA2 0
RES18:  DATA2 0
RES19:  DATA2 0
CatchMe:
    LDR R5, R0, PAT3
    NOT R5, R5
    RET
OverHere:
    LDR R3, R0, GOOD
    ADD R1, R1, R3
    RET

skip2:
    STB R2, R1, 3
    STB R3, R1, 2
    LDR R4, R1, RES17
    STR R4, R0, RES13
    LEA R3, TS
    STR R3, R0, RES15
    LDI R3, R0, RES15
    STR R3, R0, RES14
SEGMENT CodeSegment2:
    LEA R4, DataSegment4
    LDR R2, R4, Indy
    ADD R2, R2, 3
    AND R1, R1, 0
    ; To test self-modifying code, uncomment
    ; the following lines and use the first 'Indy'
    ; STR R2, R4, Indy
SEGMENT DataSegment4:
; Indy:
;     ADD R1, R1, 9
Indy:
    ADD R1, R1, 12
    STR R1, R0, RES16
    ADD R1, R0, 1
    LDR R3, R1, PAT3
    LEA R6, DataSegment2
    STR R3, R6, RES17
    LDR R1, R0, PAT3
    BRn Nati
    TRAP Owl
Nati:
    LDR R1, R0, BADBAD
    LEA R2, OverHere
    JSRR R2
    STR R1, R6, RES18
    ADD R1, R0, 2
    AND R6, R6, 0
    BRz dulles
    ADD R1, R1, R1
dulles:
    LEA R6, DataSegment2
    STR R1, R6, RES19

bloomington:
    LEA R5, DataSegment3
    LDR R6, R5, DSP
    LDR R0, R6, RES1
    LDR R1, R6, RES2
    JSR atlanta
    LDR R1, R6, RES3
    JSR atlanta
    STR R0, R5, CS1
    LDR R0, R6, RES4
    LDR R1, R6, RES5
    JSR atlanta
    LDR R1, R6, RES6
    JSR atlanta
    STR R0, R5, CS2
    LDR R0, R6, RES7
    LDR R1, R6, RES8
    JSR atlanta
    STR R0, R5, CS3
    LDR R0, R6, RES9
    LDR R1, R6, RES10
    JSR atlanta
    STR R0, R5, CS4
    LDR R0, R6, RES11
    LDR R1, R6, RES12
    JSR atlanta
    STR R0, R5, CS5
    LDR R0, R6, RES13
    LDR R1, R6, RES14
    JSR atlanta
    STR R0, R5, CS6
    LDR R0, R6, RES15
    LDR R1, R6, RES16
    JSR atlanta
    STR R0, R5, CS7
    LDR R6, R5, DS2P
    LDR R0, R6, RES17
    LDR R1, R6, RES18
    JSR atlanta
    LDR R1, R6, RES19
    JSR atlanta
    STR R0, R5, CS8
    LEA R7, DataSegment3
    LDR R0, R7, CS1
    LDR R1, R7, CS2
    LDR R2, R7, CS3
    LDR R3, R7, CS4
    LDR R4, R7, CS5
    LDR R5, R7, CS6
    LDR R6, R7, CS7
    LDR R7, R7, CS8
Nowhere:
    BRnzp nowhere

SEGMENT DataSegment3:
NINE:       DATA2 4x0009
BIGNUMBER:  DATA2 4x70CF
BYP1:       DATA2 4x0000
BYP2:       DATA2 4x0000
CS1:        DATA2 4x0000
CS2:        DATA2 4x0000
CS3:        DATA2 4x0000
CS4:        DATA2 4x0000
CS5:        DATA2 4x0000
CS6:        DATA2 4x0000
CS7:        DATA2 4x0000
CS8:        DATA2 4x0000
DSP:        DATA2 DataSegment
DS2P:       DATA2 DataSegment2

dallas:
    NOT R6, R7
    RET
atlanta:
    AND R2, R0, R1
    NOT R2, R2
    NOT R0, R0
    NOT R1, R1
    AND R0, R0, R1
    NOT R0, R0
    AND R0, R0, R2
    RET
paris:
    LDR R1, R0, BADBAD
    LDB R1, R0, NINER
    LDB R2, R0, GECKO
    LDR R3, R0, THREE
    LDR R4, R0, ZERO
