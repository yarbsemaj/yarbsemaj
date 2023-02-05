

CR          .EQU     0DH
LF          .EQU     0AH    
starState   .EQU     0A000H    

    .ORG 09000H

    LD		HL, cls			;Clear screen
	CALL	print
    LD      BC ,0F0EH       ;Print Banner
    LD      HL,logo
    CALL    printAtPos

twinkle:
    JR      randomStar      ;Pick a random star
drawStar:        
    LD      B ,(HL)
    INC     HL
    LD      C ,(HL)         
    CALL    moveCursor      ;Move the cursor to a star
drawChar
    LD      A, (DE)         ;Get star state
    PUSH    DE
    POP     HL              ;Copy Registers
    INC     (HL)
    AND     00000111b       ;Mask star data
    LD      HL,stars        ;Get star char
    JR      Z, printStar    ;If the star is in state 0, just print the char
    LD      B,A
starCharLoop:               ;If not, get the right vhar
    INC     HL
    DJNZ    starCharLoop
printStar:
    LD      A,(HL)          ;Print the star
    RST     08H
    CALL    randomA         ;Wait a random time
    LD      B,A
    PUSH    BC
    CALL    randomA
    POP     BC
    LD      C,A

    CALL 	DELAY

    JR      twinkle         ;Do it all again

randomStar:
    CALL    randomA     
    AND     00011111b   ;Mask random number, to 0-32 stars
    LD      HL,startPos
    LD      DE,starState
    AND     A
    JR      Z, drawStar
    LD      B,A
randomStarLoop:    
    INC     HL          ;Getr the star pos
    INC     HL
    INC     DE          ;Get the twinkel state
    DJNZ    randomStarLoop
    JR      drawStar

include 'libs.asm'

cls: .BYTE 1BH,"[H",1BH,"[2J",1BH,"[?25l",0

logo:
    .byte 1BH,"[94m"   ;RED
    .byte " _    _      _ _         _______ _                   _ ",0
    .byte " | |  | |    | | |       |__   __| |                 | |",0
    .byte " | |__| | ___| | | ___      | |  | |__   ___ _ __ ___| |",0
    .byte " |  __  |/ _ \ | |/ _ \     | |  | '_ \ / _ \ '__/ _ \ |",0
    .byte " | |  | |  __/ | | (_) |    | |  | | | |  __/ | |  __/_|",0
    .byte " |_|  |_|\___|_|_|\___/     |_|  |_| |_|\___|_|  \___(_)", 1BH,"[93m", 0,0 ;Yellow


stars           .byte       '.+o*o+. '
startPos        
include 'stars.asm'         