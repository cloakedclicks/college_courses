section .text
    global _start
    extern _replaceChar
    
_start:

_replaceCharLoop:
    ;;; Ask user to enter a line of text or press enter to exit program
    mov edx, getLineOfTextMsgLen
    mov ecx, getLineOfTextMsg
    mov ebx, stdout
    mov eax, sys_write
    int sys_call

    ;;; Read lines of text entered by the user, until they enter a blank line
    mov edx, TEXTBUFFER
    mov ecx, lineOfText
    mov ebx, stdin
    mov eax, sys_read
    int sys_call
    
    ;;; Read first character to see if it is a new line and if so jump to exit ;;;
    mov [modifiedLineLen], eax  ;;; save the number of bytes read in to use for sys_write of modified line of text length
    add eax, lineOfText         ;;; add the number of bytes read (return by sys_read in eax) to start address of input buffer
    sub eax, 1                  ;;; subtract 1 to account for the newline character
    mov [ lastInputByte ], eax  ;;; save that address for later comparison
    mov esi, lineOfText         ;;; use ESI register as pointer to input bytes, initialize it pointing to first byte
    
    ;;; zeroing out EAX which will be used for comparing byte from lineOfText 
    mov eax, 0x00000000         ;;; zero the EAX register
    mov byte al, [esi]          ;;; move an input byte to AL (last byte of EAX register) so if first input byte is newline, then AL=0x0A
    cmp al, 0x0a
    je _exit  

    ;;; Ask user for a character to search for
    mov edx, getSearchCharMsgLen
    mov ecx, getSearchCharMsg
    mov ebx, stdout
    mov eax, sys_write
    int sys_call
    
    ;;; Read what search character the user enters
    mov edx, CHARBUFSIZE
    mov ecx, searchChar
    mov ebx, stdin
    mov eax, sys_read
    int sys_call
    
    ;;; Ask user for replacement character
    mov edx, getReplaceCharMsgLen
    mov ecx, getReplaceCharMsg
    mov ebx, stdout
    mov eax, sys_write
    int sys_call
    
    ;;; Read what character the user enters to replace the search character
    mov edx, CHARBUFSIZE
    mov ecx, replaceChar
    mov ebx, stdin
    mov eax, sys_read
    int sys_call
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CDECL CALL ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;;; save registers to restore after the call
    push eax
    push ecx
    push edx
    
    ;;; push parameters
    push dword lastInputByte    ;;; forth parameter EBP+20
    push dword lineOfText       ;;; third parameter EBP+16 -- dword NASM assembly 4-bytes
    push dword [replaceChar]    ;;; second parameter EBP+12
    push dword [searchChar]     ;;; first parameter EBP+8
    
    ;;; call function
    call _replaceChar
    
    ;;; pop parameters off the stack
    add esp, 16                 ;;; pop 16 bytes off the stack for the four 4-byte pointer parameters we passed above
    
    ;;; move the returned result to where ever we want it...
    mov [modifiedLoT], eax        ;;; put the returned modified line of text in memory    
    
    ;;; restore registers in reverse order
    pop edx        
    pop ecx
    pop eax

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;; FINISH CDECL CALL ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;;; Print modified line of text
    mov edx, modifiedLineLen
    mov ecx, modifiedLoT
    mov ebx, stdout
    mov eax, sys_write
    int sys_call
   
    ;;; loop repeats lines of code to search & replace characters in line of text, then prints modified line of text
    jmp _replaceCharLoop        

_exit:
    mov edx, exitingProgramMsgLen
    mov ecx, exitingProgramMsg
    mov ebx, stdout
    mov eax, sys_write
    int sys_call

    mov ebx, 0
    mov eax, sys_exit
    int sys_call

section .data
    getLineOfTextMsg        db  "Please enter a line of text or press enter to exit program:",NEWLINE
    getLineOfTextMsgLen     equ $ - getLineOfTextMsg

    getSearchCharMsg        db  "Please enter a character to search for in line of text:",NEWLINE
    getSearchCharMsgLen     equ $ - getSearchCharMsg
    
    getReplaceCharMsg       db  "Please enter a character to replace previous searched for character:",NEWLINE
    getReplaceCharMsgLen    equ $ - getReplaceCharMsg
    
    exitingProgramMsg       db  " Exiting program!",NEWLINE
    exitingProgramMsgLen    equ $ - exitingProgramMsg    

section .bss
    searchChar      resd 1      ;;; 4-byte character to search for in the line of text
    replaceChar     resd 1      ;;; 4-byte character to replace the search character with within the line of text
    lineOfText      resb TEXTBUFFER
    modifiedLoT     resd 1      ;;; address for the start of the modified line of text
    modifiedLineLen resd 1      ;;; size length for modifiedLoT
    lastInputByte   resb 4      ;;; reserve 4 byte word to store the count of bytes read in
       

;;;;;;;;;;;;;; define commonly used constants ;;;;;;;;;;;;;;;;;;;;;;
    stdin       equ  0x00
    stdout      equ  0x01
    sys_exit    equ  0x01
    stderr      equ  0x02
    sys_read    equ  0x03
    sys_write   equ  0x04
    sys_call    equ  0x80
    CHARBUFSIZE equ  2
    TEXTBUFFER  equ  100
    NEWLINE     equ  0x0A  ;;; ASCII code for newline
    
    
    
