section .text
    global _start
_start:
    ; welcome message
    mov edx, welcomeMsgLen
    mov ecx, welcomeMsg
    mov ebx, stdout
    mov eax, sys_write
    int 0x80

    ; start with result at zero
    mov byte [result], 0
    
    ; print equal sign
    mov edx, 1
    mov ecx, equalOutBuf
    mov ebx, stdout
    mov eax, sys_write
    int 0x80 
    
_MathLoop:
    ; read a line -- we're assuming interactive, so always getting one line per sys_read
    ; of course this will not work with a file input
    mov edx, BUFFERSIZE  ;;; BUFFERSIZE is 257, operator + maximum of 255 pebbles +  newline character should be the most we need
    mov ecx, asciiInBuffer 
    mov ebx, stdin       ;;; notice I am using a defined symbol instead of plain 0x00  
    mov eax, sys_read    ;;; again, a defined constant instead of a bare 0x03
    int 0x80             ;;; trigger a system call interrupt for the sys_read

    ;; check for end of file and break out of the InputBufferLoop if we are
    cmp eax, 0x00
    jle _exit            ;;; check return value of sys_read, 0 or less means error or end of file, so jump to _exit

    cmp eax, 257
    jl _continue1
    cmp byte [asciiInBuffer+eax-1], NEWLINE  ;; if we have 257 bytes of input the last one better be a newline, since 255 is max number we will handle
    jne _tooManyBytes
    
_continue1: 
    ;; assuming no invalid characters, then (number of input bytes)-2 will be the (number of pebbles) 
    sub eax, 2   ;;; keep the number of input pebbles in EAX 
                 ;;; we'll be done with it by the time we need EAX again for something else like a sys_write
    
    ;; now a do a loop to make sure everything else on the input line is either a '1' or '0' up to the newline character
    mov esi, asciiInBuffer
    inc esi                 ;; we start looking at the second character, which should be a '1' or '0'
    mov edi, 0              ;; we'll use edi as an offset counter
    mov [binaryLen], eax    ;; save the length of the binary to use later.
    mov eax, 0              ;; zero out registers EAX & EDX to prepare for ascii binary to decimal conversion
    mov edx, 0
    mov dl, 2               ;; move decimal 2 into DL to assist with division for ascii binary to decimal conversion
_convertToDecimalLoop:
    cmp edi, [binaryLen]      ;; have we checked all the input characters that should be ascii binary digits?
    jge _verifiedAllBinary   ;; we do this check at the top of loop, because there might be zero ascii binary digits
    cmp byte [esi+edi], '0'   ;; is it an ascii binary 0?
    je  _binaryZero
    cmp byte [esi+edi], '1'   ;; is it an ascii binary 1?
    je  _binaryOne
    jne _NotBinary           ;; if not an ascii binary digit, jump to the NotBinary error message
_binaryZero:
    mul dl                   ;; multiply dl (which is 2) with eax (we are using data in AL)
    jmp _moveToNextDigit
_binaryOne:
    mul dl                   ;; if the binary is a 1 not only do we multiply by dl which is 2, but we also add 1 to AL the result of the multiplication is stored in AL.
    add al, 1
_moveToNextDigit:    
    inc edi                  ;; moves to the next digit to do the conversion from decimal to binary
    jmp _convertToDecimalLoop
_verifiedAllBinary:

    ;; check for an 'x' as first byte of input and exit
    cmp byte [asciiInBuffer], 'x'
    je _exit
    
    ;; check first byte for valid operation and jump to section that handles it...
    cmp byte [asciiInBuffer], '+'
    je _plus
    cmp byte [asciiInBuffer], '-'
    je _minus
    cmp byte [asciiInBuffer], '*'
    je _multiply
    cmp byte [asciiInBuffer], '/'
    je _divide
    cmp byte [asciiInBuffer], '%'
    je _modulo
    
    ;; if we get here then invalid input -- the user's input line must have started with something other than "+-/*%x"
    jmp _invalidOperator   
    
    ;;;NOTE: we only get here if EAX has a value form 0x00 to 0xFF (0 to 255) 
    ;;;      -- a one byte value, so all bits will be zero except in lowest byte: AL    
_plus:
    add [result], al
    jo _overflow
    jmp _printResultPebbles
_minus:
    sub [result], al
    ;; check underflow
    jb _underflow  ;; "jb" isn the unsigned "jump if less than"
    jmp _printResultPebbles
_multiply:
    ;;; unsigned multiplication is done by mul (use imul for signed, which is also more versatile)
    ;;; mul only takes one operand and always multiplies times EAX(32bit), AX(16bit), or AL(8bit)
    ;;; the result(which can be twices as many digits or bits) lands in EDX:EAX, or DX:AX, or AH:AL (same thing as AX)
    mul byte [result] 
    jo _overflow 
    ;;; because the result of the mul operation ends up in AL, we need to mov it to [result] for safe keeping
    mov [result], al
    jmp _printResultPebbles
_divide:
    ;;; we use div for unsigned division
    ;;; both div & idiv are somewhat special, using two registers to construct the divided, 
    ;;;      and using two registers for the result: quotient & remainder(modulo)
    ;;; The dividend is either: EDX:EAX, DX:AX, or AH:AL (last one is same as AX by itself)
    ;;; we're doing 1 byte division, so we want AH=0, and our dividend needs to go into AL
    ;;; BUT our divisor is already in AL!!! so we must move things around...
    mov bl, al   ;; put our divisor into BL
    mov al, [result]  ;; current result is our dividend, so put it in AL
    mov ah, 0         ;; not really necessary because AH should already be zero but let's just be explicit about it here
    div bl   ;; the 1-byte version of div has only one operand -- the divisor. The dividend is always AH:AL (or simply AX)  
    mov [result],al   ;; the quotient will land in AL, so copy it back to [result] 
    ;; note that we can't get overflow from doing division in this case
    jmp _printResultPebbles
_modulo:
    ;;; do the same thing as division, but the remainder is the result we want...
    mov bl, al   ;; put our divisor into BL
    mov al, [result]  ;; current result is our dividend, so put it in AL
    mov ah, 0         ;; not really necessary because AH should already ahve been zero...
                      ;; blut let's just be explicit about it here
    div bl   ;; the 1-byte version of div has only one operand -- the divisor. The dividend is always AH:AL (or simply AX)  
    mov [result],ah   ;; the remainder will land in AH, so copy it back to [result] 
    ;;; can't get overflow from doing division, in either the quotient or the remainder       
    jmp _printResultPebbles
    

_NotBinary:
    mov edx, notBinaryMsgLen
    mov ecx, notBinaryMsg
    jmp _finishErrorMsg
_tooManyBytes:
    mov edx, tooManyBytesMsgLen
    mov ecx, tooManyBytesMsg
    jmp _finishErrorMsg
_overflow:
    mov edx, overflowMsgLen
    mov ecx, overflowMsg
    mov byte [result], 0  ;;; reset result to zero on overflow
    jmp _finishErrorMsg
_underflow:
    mov edx, underflowMsgLen
    mov ecx, underflowMsg
    mov byte [result], 0  ;;; reset result to zero on underflow
    jmp _finishErrorMsg
_invalidOperator:
    mov edx, invalidOperatorMsgLen
    mov ecx, invalidOperatorMsg
    jmp _finishErrorMsg

_finishErrorMsg:
    mov ebx, stdout
    mov eax, sys_write   
    int 0x80    
    
_printResultPebbles:

_prepareOutBuffer:
    mov esi, 0     ;; esi will be used to keep the address of where the binaryOutBuffer ends.
    mov esi, binaryOutBuffer
    add esi, 15     ;; we add 8 to the address, because this is where we want to start printing the binary from right to left.
    mov edi, 0     ;; edi will be used as our counter so we know how many digits we need to print out once it is done.
    mov al, [result]    ;; we are adding our decimal result to al
_convertBinaryToAsciiBinary:
    mov dl, 2      ;; similar to what we did earlier in the program. we are moving 2 into dl to use it for modulus and division 
    ;mov al, [result]    ;; we are adding our decimal result to al
    mov ah, 0      ;; zeroing out AH similar to the modulus and division code above
    div dl
    cmp ah, 1      ;; if the reults of the modulus has a remainder of 1, jump to add '1' to the binary outbuffer or add '0' to the binary outbuffer 
    je _addOneToBinaryOutBuffer
    mov byte [esi], '0'  
    dec esi        ;; moves to the next address to add an ascii binary digit to
    inc edi        ;; keeps a count of how many digits have been added
    ;mov al, [result]    ;; moves results into al for division
    mov ah, 0
    div dl
    mov [result], al    ;; moves division results into [results]
    cmp esi, binaryOutBuffer
    jge _convertBinaryToAsciiBinary
    jmp _printBinary   
_addOneToBinaryOutBuffer:
    mov byte [esi], '1'  
    dec esi
    inc edi
    ;mov al, [result]
    mov ah, 0
    div dl
    ;mov [result], al
    cmp esi, binaryOutBuffer
    jge _convertBinaryToAsciiBinary
    
_printBinary:    
    mov [binaryOutBuffer], esi
    
    
    mov edx, 0  ;; make sure edx is clear
    mov edx, edi
    
    mov ecx, binaryOutBuffer ;; address of our result ascii binary buffer
    mov ebx, stdout
    mov eax, sys_write
    int 0x80
    
_printNewline:
    ;; now print the newline character separately
    mov edx, 1
    mov ecx, newlineOutBuf
    mov ebx, stdout
    mov eax, sys_write
    int 0x80
    ;;
    
    jmp _MathLoop ;; unconditional jump back up to repeat InputBufferLoop, 
                         ;; because exiting that loop is handled just after reading the input buffer
    
_exit:
    mov edx, exitMsgLen       ;;; setup a sys_write to print just a final newline, just to make things look nice
    mov ecx, exitMsg 
    mov ebx, stdout
    mov eax, sys_write
    int 0x80             ;;; interrupt to call sys_write 

    mov ebx, 0          ; only parameter of sys_exit is the return code for the program
    mov eax, 1          ; 1 is the code for sys_exit
    int 0x80            ; once again we do a system call interrupt   


section .data
    newlineOutBuf          db   NEWLINE   ;;; a very small "output buffer" containing just a newline character
    
    equalOutBuf            db   EQUAL

    welcomeMsg             db  "C3PO say: C3PO is programmed for Binary Math",NEWLINE
    welcomeMsgLen          equ $ - welcomeMsg

    invalidOperatorMsg     db  "C3PO say:  C3PO has not been programmed to understand that!",NEWLINE
    invalidOperatorMsgLen  equ $ - invalidOperatorMsg

    notBinaryMsg          db   "C3PO say:  I've only been programmed to do Binary Math!",NEWLINE
    notBinaryMsgLen       equ $ - notBinaryMsg

    tooManyBytesMsg       db   "C3PO say:  That will fry my data banks!  Too many bytes!",NEWLINE
    tooManyBytesMsgLen    equ $ - tooManyBytesMsg

    overflowMsg            db   "C3PO say:  Memory overflow threat detected! Please try again.",NEWLINE
    overflowMsgLen         equ $ - overflowMsg

    underflowMsg           db   "C3PO say:  There is no such thing as negative binary digits!",NEWLINE
    underflowMsgLen        equ $ - underflowMsg

    exitMsg                db   "C3PO say:  I think the Empire is near, R2D2 notify the rebel fleet!",NEWLINE
    exitMsgLen             equ $ - exitMsg
    


    ;binaryOutBuffer        db "=00000000"
    ;binaryOutBufferLen     equ $ - binaryOutBufferLen
section .bss  
    result resb 4   ;  4 byte (32 bit) unsigned integer
    binaryLen resb 4    ; 4 byte (32 bit) unsigned integer  
    AddressOfLastBytePlusOne resb 4 ;; place to store the address of the last input byte in the input buffer
    asciiInBuffer   resb BUFFERSIZE
    LastOutputByte  resb 4    ;;; reserve 4 byte word to store the address of the last output bytes so we can use it to convert decimal to binary and print it.
    binaryOutBuffer resb 32
    
;;;;;;;;;;;;;; define commonly used constants ;;;;;;;;;;;;;;;;;;;;;;
sys_read  equ 0x03
sys_write equ 0x04
stdin     equ 0x00
stdout    equ 0x01
stderr    equ 0x02
BUFFERSIZE equ 257
SPACE     equ 0x20  ;;; ASCII code for space (32 decimal)
NEWLINE   equ 0x0A  ;;; ASCII code for newline
EQUAL     equ 0x3D  ;;; ASCII code for equal sign

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


