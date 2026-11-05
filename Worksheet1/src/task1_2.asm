; Include the routines used to read and print values.
%include "asm_io.inc"

; Text messages shown to the user. A zero marks the end of each string.
segment .data
    msg1 db "Enter a number: ", 0
    msg2 db "The sum of ", 0
    msg3 db " and ", 0
    msg4 db " is: ", 0

; Reserve memory for the two inputs and their sum.
segment .bss
    integer1 resd 1 ; The first number entered by the user.
    integer2 resd 1 ; The second number entered by the user.
    result resd 1    ; The sum of the two numbers.

; The main program instructions start here.
segment .text
    global asm_main
asm_main:
    pusha                  ; Save the registers before calling the I/O routines.

    mov eax, msg1          ; EAX holds the address of the prompt string.
    call print_string
    call read_int          ; Read the first whole number; it is returned in EAX.
    mov [integer1], eax    ; Store the first number in memory.

    mov eax, msg1          ; Show the prompt again for the second number.
    call print_string
    call read_int          ; Read the second whole number into EAX.
    mov [integer2], eax    ; Store the second number in memory.

    mov eax, [integer1]    ; Load the first number into EAX.
    add eax, [integer2]    ; Add the second number to the value in EAX.
    mov [result], eax      ; Save the sum in memory.

    mov eax, msg2          ; Print the first part of the result sentence.
    call print_string
    mov eax, [integer1]    ; Load the first number into EAX.
    call print_int

    mov eax, msg3          ; Print the word "and" between the numbers.
    call print_string
    mov eax, [integer2]    ; Load the second number into EAX.
    call print_int

    mov eax, msg4          ; Print the text introducing the answer.
    call print_string
    mov eax, [result]      ; Load the sum into EAX.
    call print_int
    call print_nl          ; Finish the output with a new line.

    popa                   ; Restore the registers saved at the start.
    mov eax, 0             ; Return zero to show that the program finished.
    ret                    ; Return to the C driver.