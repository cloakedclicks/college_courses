section .text
    global _start
_start:
    mov edx, BUFFERSIZE  ;;; use sys_read to read a line or buffer full of bytes
    mov ecx, inBuffer 
    mov ebx, stdin       ;;; notice I am using a defined symbol instead of plain 0x00  
    mov eax, sys_read    ;;; again, a defined constant instead of a bare 0x03
    int 0x80             ;;; trigger a system call interrupt for the sys_read
    
    add eax, inBuffer    ;;; add the number of bytes read (return by sys_read in eax) to start address of input buffer
    sub eax, 1
    mov [ LastInputByte ], eax   ;;; save that address for later comparison
    
    mov esi, inBuffer    ;;; use ESI register as pointer to input bytes, initialize it pointing to first byte
    mov ebx, esp         ;;; save original esp address to use for comparision
    
_readBytesLoop:
    ;;; loop starts by zeroing out EAX and EDX which will be used for comparing bytes from inBuffer and Stack    
    mov eax, 0x00000000  ;;; zero the EAX register
    mov edx, 0x00000000  ;;; zero the EDX register
    mov byte al, [esi]   ;;; move an input byte to last byte to AL (last byte of EAX register) so if first input byte is 'z', then AL=0x7A
    
    cmp al, ']'
    je _cmpWithStack
    
    cmp al, ')'
    je _cmpWithStack
    
    cmp al, '}'
    je _cmpWithStack
    
    cmp al, '['
    je _pushToStack
    
    cmp al, '('
    je _pushToStack
    
    cmp al, '{'
    je _pushToStack
    
    inc esi
    jmp _readBytesLoop
    
_cmpWithStack:
    ;;; first test if stack has values if it does not jump to error message else compares with AL to find bracket matches
    cmp ebx, esp
    je _noValuesInStack
    
    cmp al, ']'
    je _findBracketMatch
    
    cmp al, ')'
    je _findParenthesisMatch
    
    cmp al, '}'
    je _findCurlyMatch
    
_findBracketMatch:
    mov dl, [esp]
    cmp dl, '['
    je _popEAX
    jmp _noBracketFound
    
_findParenthesisMatch:
    mov dl, [esp]
    cmp dl, '('
    je _popEAX
    jmp _noParenthesisFound
    
_findCurlyMatch:
    mov dl, [esp]
    cmp dl, '{'
    je _popEAX
    jmp _noCurlyFound
    
_popEAX:
    ;;; pops if matches are found and increments pointer to point at the next address byte in ESI, also checks if ESI is pointing to last input byte if it is it jumps to more error checks
    pop eax
    inc esi
    cmp esi, [ LastInputByte ]
    je  _lastInputByte
    jmp _readBytesLoop
    
_pushToStack:
    ;;; all open brackets are pushed ot the stack and ESI is incremented to point at the next address byte, also checks if ESI is at the last input byte and if so jumps to more error checks
    push eax
    inc esi
    cmp esi, [ LastInputByte ]
    je  _lastInputByte
    jmp _readBytesLoop
    
_noValuesInStack:
    ;;; error message if a close bracket is the first input and there isn't any data in the stack. Also if inBuffer ends with an unmatching close bracket.
    mov edx, noValuesInStackMsgLen
    mov ecx, noValuesInStackMsg
    mov ebx, stdout
    mov eax, sys_write
    int sys_call
    
    jmp _exit
    
_noBracketFound:
    ;;; error message if there isn't a matching square bracket found.
    mov edx, noBracketFoundMsgLen
    mov ecx, noBracketFoundMsg
    mov ebx, stdout
    mov eax, sys_write
    int sys_call
    
    jmp _exit
    
_noParenthesisFound:
    ;;; error message if there isn't a matching parenthesis found.
    mov edx, noParenthesisFoundMsgLen
    mov ecx, noParenthesisFoundMsg
    mov ebx, stdout
    mov eax, sys_write
    int sys_call
    
    jmp _exit

_noCurlyFound:
    ;;; error message if there isn't a matching curly bracket found.
    mov edx, noCurlyFoundMsgLen
    mov ecx, noCurlyFoundMsg
    mov ebx, stdout
    mov eax, sys_write
    int sys_call
    
    jmp _exit
    
_lastInputByte:
    ;;; last input byte comparison and error checks
    cmp ebx, esp
    je _bracketsBalanced
    jmp _whatIsRemaining
    
_bracketsBalanced:
    ;;; success message if everything checks out successfully
    mov edx, bracketsBalancedMsgLen
    mov ecx, bracketsBalancedMsg
    mov ebx, stdout
    mov eax, sys_write
    int sys_call
    
    jmp _exit
       
_whatIsRemaining:
    ;;; finds what is remaining and jumps to error message
    mov dl, [esp]
    
    cmp dl, '['
    je _openBracketRemaining
    
    cmp dl, '('
    je _openParenthesisRemaining
    
    cmp dl, '{'
    je _openCurlyRemaining   
    
_openBracketRemaining:
    mov edx, bracketRemainingMsgLen
    mov ecx, bracketRemainingMsg
    mov ebx, stdout
    mov eax, sys_write
    int sys_call
    
    jmp _exit

_openParenthesisRemaining:
    mov edx, parenthesisRemainingMsgLen
    mov ecx, parenthesisRemainingMsg
    mov ebx, stdout
    mov eax, sys_write
    int sys_call
    
    jmp _exit

_openCurlyRemaining:
    mov edx, curlyRemainingMsgLen
    mov ecx, curlyRemainingMsg
    mov ebx, stdout
    mov eax, sys_write
    int sys_call
    
    jmp _exit
        
    
_exit:
    mov edx, exitingProgramMsgLen
    mov ecx, exitingProgramMsg
    mov ebx, stdout
    mov eax, sys_write
    int sys_call

    mov ebx, 0      ;; only parameter of sys_exit is the return code for the program
    mov eax, sys_exit
    int sys_call
    
section .data
    newlineOutBuf db NEWLINE ; output buffer containing newline character
    
    noValuesInStackMsg            db  "No values in stack to compare."
    noValuesInStackMsgLen         equ $ - noValuesInStackMsg
    
    bracketsBalancedMsg           db  "All brackets are balanced."
    bracketsBalancedMsgLen        equ $ - bracketsBalancedMsg        
    
    noBracketFoundMsg             db  "Expecting a [, but found a different character."
    noBracketFoundMsgLen          equ $ - noBracketFoundMsg
    
    noParenthesisFoundMsg         db  "Expecting a (, but found a different character."
    noParenthesisFoundMsgLen      equ $ - noParenthesisFoundMsg
    
    noCurlyFoundMsg               db  "Expecting a {, but found a different character."
    noCurlyFoundMsgLen            equ $ - noCurlyFoundMsg
    
    bracketRemainingMsg           db  "Input ended with open [."
    bracketRemainingMsgLen        equ $ - bracketRemainingMsg
    
    parenthesisRemainingMsg       db  "Input ended with open [."
    parenthesisRemainingMsgLen    equ $ - parenthesisRemainingMsg
    
    curlyRemainingMsg             db  "Input ended with open [."
    curlyRemainingMsgLen          equ $ - curlyRemainingMsg
    
    exitingProgramMsg             db  " Exiting program!",NEWLINE
    exitingProgramMsgLen          equ $ - exitingProgramMsg
    
section .bss
    inBuffer resb BUFFERSIZE
    LastInputByte resb 4    ;;; reserve 4 byte word to store the count of bytes read in

;;;;;;;;;;;;;; define commonly used constants ;;;;;;;;;;;;;;;;;;;;;;
stdin     equ 0x00
stdout    equ 0x01
sys_exit  equ 0x01
stderr    equ 0x02
sys_read  equ 0x03
sys_write equ 0x04
sys_call  equ 0x80
BUFFERSIZE equ 100
NEWLINE   equ 0x0A  ;;; ASCII code for newline
