; read in lines of text from standard input (nomrally means input typed by the user)
; print each line individually in hex digits
; we will assume that each line is never longer than 80 characters (including newline symbol)

bufferSize equ 80

section .text
    global _start
_start:

    ; read in one line of text (up to bufferSize max characters)
    ; setup a sys_read...
    mov edx, bufferSize ; size of input buffer (in bytes)
    mov ecx, inBuffer   ; address of input buffer to store the bytes of data we read
    mov ebx, 0x00       ; file descriptor -- 0 for stdin (standard input)
    mov eax, 0x03       ; 3 is the code for sys_read
    int 0x80            ; interrupt code 0x80 (128 in decimal) which is a system call interrupt
                        ; sys_read will read up to bufferSize bytes or until it hits a newline character, whichever comes first
    ; AFTER the sys_read the return value, number of bytes read, will be in EAX
    mov [inputLength], eax    ; save the number of bytes read in out in memory

    cmp eax, 0          ; comparing sys_read return value to 0
    jle _exit           ; jump to exit if sys_read returned <= 0 (end of file or error condition

    sub eax, [inputLength] ; subtract [inputLength] from eax, to get index of first byte
    mov ebx, 0x00       ; index of destination byte
_Loop:
    mov esi, inBuffer
    mov edi, outBuffer  ; do you understand why I am not using [inBuffer] and [outBuffer] ???
    mov byte ch,[esi + eax]  ; moving byte from address esi+eax into the ch register. byte keyword not really necessary.
    mov byte [edi+ebx], ch   ; move byte from register ch to memory location edi+ebx
    cmp byte [edi+ebx], 9
    jle _thenblock
    jmp _elseblock
_thenblock:
    add byte [edi+ebx], '0'
    inc ebx
    mov byte [edi+ebx], 0x7f ; testing to add space after bite
    jmp _next
_elseblock:
    add byte [edi+ebx], ('A' - 10)
    inc ebx
    mov byte [edi+ebx], 0x7f ; testing to add space after bite
    jmp _next
_next:   
    inc eax
    inc ebx
    cmp eax, [inputLength]
    jl _Loop
    
    ;mov byte [edi+ebx], 0x0A ; put a newline character at the end of the reverse text. byte keyword IS NECCESSARY HERE

    ; now just print the line back out...
    mov edx, [inputLength]    ; copy the number of byte read (return val of sys_read) into edx
                        ; this will only work, if the sys_read is the last thing we did!!!!!!!!
    mov ecx, outBuffer  ; using address of inBuffer, because for now, we're just printing the line we read in
    mov ebx, 0x01       ; file descriptor 1, for stdout (standard output)
    mov eax, 0x04       ; 4 is the code for sys_write
    int 0x80            ; again we do a system call interrupt
    
_exit:
    mov ebx, 0          ; only parameter of sys_exit is the return code for the program
    mov eax, 1          ; 1 is the code for sys_exit
    int 0x80            ; another system call, this time to the "sys_exit" to end the program cleanly.
    
section .bss
    inBuffer    resb bufferSize
    outBuffer   resb bufferSize
    inputLength resd 1  ;reserving a double-word to store the input length (number of bytes)
    
