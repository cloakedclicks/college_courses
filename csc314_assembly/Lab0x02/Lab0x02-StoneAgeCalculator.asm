section .text
    global _start
_start:
    mov edx, msgLen         ; setting up sys_write for beginning of program greeting
    mov ecx, msg
    mov ebx, stdout
    mov eax, sys_write
    int 0x80                ; interrupt to call sys_write
    
_InputBufferLoop:
    mov edx, msgEqualLen    ; setting up sys_write to write '=' to screen (stdout)
    mov ecx, msgEqual
    mov ebx, stdout
    mov eax, sys_write
    int 0x80                ; interrupt to call sys_write
    
    mov edx, 1              ; setup a sys_write to print just a newline,
    mov ecx, newlineOutBuf 
    mov ebx, stdout
    mov eax, sys_write
    int 0x80                ; interrupt to call sys_write 
    
    mov edx, BUFFERSIZE     ; use sys_read to read a line or buffer full of bytes
    mov ecx, inBuffer 
    mov ebx, stdin          ; code for sys_read to read input from user 
    mov eax, sys_read    
    int 0x80                ; interrupt to call sys_read
    
    cmp eax, 0x00
    jle _exit               ; check return value of sys_read, 0 or less means error or end of file, so jump to _exit
    
    mov edi, [eax]          ; moving byte count to edi 
    sub edi, 2              ; subtracting 2 to count for newline and beginning symbol
    mov [new], edi          ; copyiing count to memory to use later in program
    
    add eax, inBuffer       ; add the number of bytes read (return by sys_read in eax) to start address of input buffer
    sub eax, 1
    mov [ LastInputByte ], eax  ; save that address for later comparison
    
    ;mov edi, 0x00           ; we will use EDI as counter. Starts at 0.
    mov esi, inBuffer       ; use ESI register as pointer to input bytes, initialize it pointing to first byte
    
_MathOps:
    mov bl, [esi]           ; get first byte to find what type of math operations is requested
    cmp bl, 0x2B            ; looking for a '+' symbol
    je _Add
    cmp bl, 0x2D            ; looking for a '-' symbol
    je _Sub
    cmp bl, 0x2A            ; looking for a '*' symbol
    je _Mul             
    cmp bl, 0x2F            ; looking for a '/' symbol
    je _Div
    cmp bl, 0x25            ; looking for a '%' symbol
    je _Mod
    cmp bl, 0x78            ; looking for a 'x' symbol
    je _Ex
    
_Add:
    add byte [total], new   ; add new pebbles to running total
    
    mov edx, msgEqualLen    ; setting up sys_write to write '=' to screen (stdout)
    mov ecx, msgEqual
    mov ebx, stdout
    mov eax, sys_write      ; interrupt to call sys_write
    int 0x80

_AddLoop:
    inc byte [counter]      ; counter to assist in printing pebbles
    mov al, PEBBLE
    mov [writePebble], al
    
    mov edx, 1              ; setting up sys_write to print pebbles
    mov ecx, writePebble
    mov ebx, stdout
    mov eax, sys_write
    int 0x80                ; interrupt to call sys_write
    
    cmp dword [counter], total  ; check with running total to see if more pebbles need to be printed
    jne _AddLoop
    jmp _InputBufferLoop    ; jump back to buffer loop to read in more data from user
    
_Sub:

_Mul:

_Div:

_Mod:

_Ex:
    mov edx, msgExitLen     ; setting up sys_write to print exit message
    mov ecx, msgExit
    mov ebx, stdout
    mov eax, sys_write      ; interrupt to call sys_write
    int 0x80      

_exit:
    mov ebx, 0              ; only parameter of sys_exit is the return code for the program
    mov eax, 1              ; 1 is the code for sys_exit
    int 0x80                ; once again we do a system call interrupt  

section .data
    msg    db   "Welcome to the stone age.",0x0A, \     ; program greeting
                "We do math with pebbles.",0x0A, \

    msgLen equ $ - msg

    msgerr1 db  "Error",0x3A," negative result.",0x0A,"=",0x0A      ; error message for negative results
    msgerr1Len  equ $ - msgerr1

    msgerr2 db  "Error",0x3A," unrecognized symbol.",0x0A           ; error message for unrecognized symbol
    msgerr2Len  equ $ - msgerr2

    msgerr3 db  "Error",0x3A," result larger than 255.",0x0A,"=",0x0A   ; error message for larger results over 255
    msgerr3Len  equ $ - msgerr3
    
    msgExit db  "…returning to your proper time in history.",0x0A       ; exiting message
    msgExitLen  equ $ - msgExit
    
    msgEqual db "="     ; used to be able to write equal sign when needed
    msgEqualLen equ $ - msgEqual
    
    newlineOutBuf  db   0x0A   ;;; a very small "output buffer" containing just a newline character

section .bss
    inBuffer    resb BUFFERSIZE
    outBuffer   resd 1
    LastInputByte   resd 1  ; reserve 4 bytes to store the count of bytes read in
    addSpace    resb 1      ; 1 byte to add space
    counter resd 1     ; used as a counter for _SpaceLoop
    writePebble      resb 1      ; used to print 'o'
    total   resd 1
    new     resd 1
    
;;;;;;;;;;;;;;;; define commonly used constants ;;;;;;;;;;;;;;;;;;;
sys_read    equ 0x03
sys_write   equ 0x04
stdin       equ 0x00
stdout      equ 0x01
stderr      equ 0x02
BUFFERSIZE  equ 100
SPACE       equ 0x20        ; ASCII code for space (32 decimal)
PEBBLE      equ 0x6F
NEWLINE     equ 0x0A        ; ASCII dode for new line
