section .text
    global _start
_start:
    mov byte [outBuffer+1], NEWLINE ; copy ascii code of a newline to the second byte in outBuffer (it will just stay there always)
    
_InputBufferLoop:           ; we jump back to this point to read another line (or buffer full) of input
    mov edx, BUFFERSIZE     ; use sys_read to read a line or buffer full of bytes
    mov ecx, inBuffer 
    mov ebx, stdin          ; Using a defined symbol instead of plain 0x00  
    mov eax, sys_read       ; again, a defined constant instead of a bare 0x03
    int 0x80                ; trigger a system call interrupt for the sys_read
    cmp eax, 0x00
    jle _exit               ; check return value of sys_read, 0 or less means error or end of file, so jump to _exit   
    add eax, inBuffer       ; add the number of bytes read (return by sys_read in eax) to start addres of input buffer
    sub eax, 1              ; remove newline
    mov [LastInputByte], eax    ; save that address for later comparison
    mov edi, 0x00           ; we will use EDI as bytes-per-line counter. Starts at 0.
    mov esi, inBuffer       ; use ESI register as pointer to input bytes, initialize it pointing to first byte 
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_ByteLoop:
    mov byte [spaceCounter], 0x00   ; zero out spaceCounter
    cmp edi, 0x00           ; compares 0x00 to EDI to see if spaces need to be added before byte
    jg _SpaceLoop           ; if edi is greater than 0x00 jumps to _SpaceLoop.                                                                   
    jmp _Continue           ; else jmp to Continue if EDI isn't greater than 0x00
    
_SpaceLoop:                 ; loop that controls how many spaces are added before byte
    inc byte [spaceCounter] ; increment 1 to spaceCounter (also happens to be the number of spaces added before char)
    mov al, SPACE           ; using a defined symbol for 0x20 and moving the byte into register AL (lower half of AX)
    mov [addSpace], al      ; moving 0x20 from AL "into" addSpace which is the outbuffer. 
    
    mov edx, 1              ; setting up sys_write to write space
    mov ecx, addSpace       ; this could be any symbol or register. I'm using a defined symbol to help me know it's job
    mov ebx, stdout         ; defined symbol to print/write to screen
    mov eax, sys_write      ; defined symbol to state the code to do a sys_write
    int 0x80                ; code to execute system call
    cmp [spaceCounter], edi ; compares "contents" of spaceCounter to register EDI. 
    jne _SpaceLoop          ; if spaceCounter doesn't equal register EDI another space is needed to be written.
            
_Continue:    
    mov eax, 0x0000000      ; zero the EAX register
    mov byte AL, [esi]      ; move an input byte to last byte to AL (last byte of EAX register)
    mov [outBuffer],AL
    
    mov edx, 2              ; setting up a sys_write to print byte and a newline from the output buffer
    mov ecx, outBuffer
    mov ebx, stdout
    mov eax, sys_write
    int 0x80                ; trigger a system call interrupt for the sys_write
        
    inc esi                 ; increment the address in ESI to point to the next input byte
    inc edi                 ; increment bytes counter to keep how many bytes have been printed

    cmp esi,[LastInputByte]
    jl _ByteLoop            ; still bytes left to process in input buffer, jump back to _ByteLoop        
    jmp _InputBufferLoop    ; jump back up to grab another line or buffer full of input bytes
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
_exit:
    mov ebx, 0              ; only parameter of sys_exit is the return code for the program
    mov eax, 1              ; 1 is the code for sys_exit
    int 0x80                ; once again we do a system call interrupt  
    
section .data
    
section .bss
    inBuffer    resb BUFFERSIZE
    outBuffer   resb 2      ; all we need is 2 bytes here.
    LastInputByte   resb 4  ; reserve 4 byte word to store the count of bytes read in
    addSpace    resb 1      ; 1 byte to add space
    spaceCounter resd 1     ; used as a counter for _SpaceLoop
    
;;;;;;;;;;;;;;;; define commonly used constants ;;;;;;;;;;;;;;;;;;;
sys_read    equ 0x03
sys_write   equ 0x04
stdin       equ 0x00
stdout      equ 0x01
stderr      equ 0x02
BUFFERSIZE  equ 100
SPACE       equ 0x20        ; ASCII code for space (32 decimal)
NEWLINE     equ 0x0A        ; ASCII dode for new line

