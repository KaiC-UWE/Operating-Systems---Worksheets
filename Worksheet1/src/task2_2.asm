; Include the routines used to print the result.
%include "asm_io.inc"

; Store the message printed before the answer.
segment .data
    start_prompt db "Enter the first number in the range (1-100): ", 0 ; Prompt for the first value.
    end_prompt db "Enter the last number in the range (1-100): ", 0 ; Prompt for the last value.
    result_msg db "The sum of the numbers in that range is: ", 0 ; Label printed before the sum.
    invalid_start_msg db "Error: the first number must be between 1 and 100.", 0 ; Error for an invalid first value.
    invalid_end_msg db "Error: the last number must be between 1 and 100.", 0 ; Error for an invalid last value.
    invalid_order_msg db "Error: the last number must not be less than the first.", 0 ; Error if the range is reversed.

; Reserve memory for the array, the selected range and its total.
segment .bss
    numbers resd 100 ; Each array element reserves space for one 32-bit number.
    range_start resd 1 ; Stores the first number in the requested range.
    range_end resd 1   ; Stores the last number in the requested range.
    total resd 1      ; Stores the running sum of the selected array elements.

; The main program instructions start here.
segment .text
    global asm_main
asm_main:
    pusha                    ; Save the registers before calling the print routines.

    ; Fill the array with the numbers 1 to 100.
    mov esi, 0               ; ESI is the array index, starting at element zero.
    mov eax, 1               ; EAX holds the next number to put in the array.
initialize_array:
    mov [numbers + esi * 4], eax ; Store the number at the current array index.
    inc eax                  ; Prepare the next number for the next element.
    inc esi                  ; Move to the next array element.
    cmp esi, 100             ; Check whether all 100 elements have been filled.
    jl initialize_array      ; Continue while the index is below 100.

    ; Read and validate the inclusive range to sum.
    mov eax, start_prompt
    call print_string        ; Display the prompt for the first number.
    call read_int            ; Read the first number into EAX.
    mov [range_start], eax   ; Save the first number for validation and summing.
    cmp eax, 1               ; Check that the first number is at least 1.
    jl invalid_start         ; Print an error if it is less than 1.
    cmp eax, 100             ; Check that the first number is at most 100.
    jg invalid_start         ; Print an error if it is greater than 100.

    mov eax, end_prompt
    call print_string        ; Display the prompt for the last number.
    call read_int            ; Read the last number into EAX.
    mov [range_end], eax     ; Save the last number for validation and summing.
    cmp eax, 1               ; Check that the last number is at least 1.
    jl invalid_end           ; Print an error if it is less than 1.
    cmp eax, 100             ; Check that the last number is at most 100.
    jg invalid_end           ; Print an error if it is greater than 100.
    cmp eax, [range_start]   ; Ensure the last number is not before the first.
    jl invalid_order         ; Print an error if the range is reversed.

    ; Add the array elements from the first number through the last number.
    mov esi, [range_start]
    dec esi                  ; Convert the first number to a zero-based index.
    mov dword [total], 0     ; The running total starts at zero.
sum_array:
    mov eax, [numbers + esi * 4] ; Read the current array element.
    add [total], eax         ; Add it to the running total.
    inc esi                  ; Move to the next array element.
    cmp esi, [range_end]     ; Stop after including the selected last number.
    jl sum_array             ; Continue while the index is below the last number.

    ; Display the calculated total.
    mov eax, result_msg
    call print_string        ; Display the result label.
    mov eax, [total]
    call print_int           ; Display the sum.
    call print_nl            ; Finish the output with a new line.
    jmp task2_done           ; Skip the error handlers and finish the program.

invalid_start:
    mov eax, invalid_start_msg
    call print_string        ; Display the first-number validation error.
    call print_nl            ; Finish the error message with a new line.
    jmp task2_done           ; Skip the remaining handlers and finish.

invalid_end:
    mov eax, invalid_end_msg
    call print_string        ; Display the last-number validation error.
    call print_nl            ; Finish the error message with a new line.
    jmp task2_done           ; Skip the remaining handler and finish.

invalid_order:
    mov eax, invalid_order_msg
    call print_string        ; Display the reversed-range error.
    call print_nl            ; Finish the error message with a new line.

task2_done:
    popa                     ; Restore the registers saved at the start.
    mov eax, 0               ; Return zero to show that the program finished.
    ret                      ; Return to the C driver.