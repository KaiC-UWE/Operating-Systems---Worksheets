; Include the routines used to read input and print messages.
%include "asm_io.inc"

; Strings printed by the program. Each string ends with a zero byte.
segment .data
    name_prompt db "Enter your name (up to 40 characters): ", 0
    number_prompt db "How many times should I print your welcome message? ", 0
    welcome_message db "Welcome: ", 0
    too_small_msg db "Error: the number must be at least 50.", 0
    too_large_msg db "Error: the number must be less than 100.", 0

; Reserve space for the user's name and the number of messages still to print.
segment .bss
    user_name resb 50 ; Space for up to 49 name characters and a zero terminator.
    remaining resd 1  ; Stores the number of welcome messages left to print.

; The main program instructions start here.
segment .text
    global asm_main
asm_main:
    pusha                    ; Save the registers before using the I/O routines.

    mov eax, name_prompt
    call print_string

    mov ecx, 0               ; ECX counts the characters stored in the name.
read_name:
    call read_char           ; Read one character; the character is returned in EAX.
    cmp eax, 10              ; Check for the Enter key (line feed).
    je name_done             ; Stop reading the name when Enter is pressed.
    cmp eax, -1              ; Check whether the input has ended.
    je name_done
    cmp eax, 13              ; Ignore a carriage return if one is supplied.
    je read_name
    cmp ecx, 40              ; Do not store more than 40 name characters.
    jae read_name            ; Ignore extra characters until Enter is pressed.
    mov [user_name + ecx], al ; Store this character at the next free position.
    inc ecx                  ; Move to the next position in the name buffer.
    jmp read_name

name_done:
    mov byte [user_name + ecx], 0 ; Mark the end of the name string.

    call print_nl
    mov eax, number_prompt
    call print_string
    call read_int            ; Read the requested number of welcome messages.
    mov [remaining], eax     ; Keep a copy so it can be counted down later.

    cmp eax, 50              ; The minimum allowed value is 50.
    jl number_too_small      ; If it is below 50, print an error.
    cmp eax, 100             ; The maximum allowed value is 99.
    jge number_too_large     ; If it is 100 or more, print an error.

print_welcome:
    mov eax, welcome_message
    call print_string
    call print_nl

    dec dword [remaining]    ; One message has been printed, so reduce the count.
    jnz print_welcome        ; Repeat while there are messages left to print.
    jmp task2_done

number_too_small:
    mov eax, too_small_msg
    call print_string
    call print_nl
    jmp task2_done

number_too_large:
    mov eax, too_large_msg
    call print_string
    call print_nl

task2_done:
    popa                     ; Restore the registers saved at the start.
    mov eax, 0               ; Return zero to show that the program finished.
    ret                      ; Return to the C driver.