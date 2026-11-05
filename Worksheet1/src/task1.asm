; Include the supplied routines for printing values.
%include "asm_io.inc"

; Data that is given an initial value when the program starts.
segment .data
    integer1 dd 12 ; The first number to add.
    integer2 dd 13 ; The second number to add.

; Space reserved for values that the program calculates.
segment .bss
    result resd 1 ; One 32-bit space to store the answer.

; The program instructions start here.
segment .text
    global asm_main
asm_main:
    pusha                 ; Save the registers so the I/O routines do not change them.

    mov eax, [integer1]   ; Put the first number into EAX.
    add eax, [integer2]   ; Add the second number to the value in EAX.
    mov [result], eax     ; Save the answer in the result space.
    call print_int        ; Print the answer currently held in EAX.

    popa                  ; Restore the saved registers.
    mov eax, 0            ; Return zero to show that the program finished.
    ret                   ; Return to the C driver.