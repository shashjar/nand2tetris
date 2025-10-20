// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

(LOOP)
    // If no key pressed → clear the screen
    // If any key pressed → blacken the screen
    @KBD
    D=M
    @WHITE
    D;JEQ
    @BLACK
    0;JMP
(WHITE)
    @color
    M=0 // white = 0
    @FILL
    0;JMP
(BLACK)
    @color
    M=-1 // black = -1
(FILL)
    @SCREEN
    D=A
    @addr
    M=D // addr = SCREEN (start of screen)
(LOOP_FILL)
    @color
    D=M
    @addr
    A=M
    M=D // *addr = color

    @addr
    M=M+1 // addr++

    @KBD
    D=A
    @addr
    D=D-M // D = KBD - addr

    @LOOP_FILL
    D;JGT // if addr < KBD, keep looping

    // when done filling → go back to LOOP to check keyboard again
    @LOOP
    0;JMP
