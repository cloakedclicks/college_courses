;;; Library that takes three parameters 1. Line of Text 2. Character to Search for in text 3. Character to replace searched for character
section .text
    global _replaceChar

_replaceChar:

          ;;; takes 3 parameter: searchChar, replaceChar, lineOfText
          ;;;   searchChar ---> [EBP+8], replaceChar ---> [EBP+12], lineOfText ---> [EBP+16], lastInputByte ---> [EBP+20]

    push ebp    ;;; save the "stack frame pointer" of the Caller
    
    mov ebp, esp    ;;; make the current top of stack the "frame pointer" of this function call (the callee)
                    ;;; EBP, the "frame pointer" gives us a reference point to find the parameters and the local variables of our function
                    
    ;sub ESP, 12     ;;; we need 12 bytes for 3 unsigned 32-bit integers as local variables, that we are using for intermediate values
    
    push ebx        ;;; saving registers that we might mess with, and we must restore these before we return!!!
    push esi        ;;; note: we don't need to save/restore these if we're note going to touch them
    push edi
    

    mov esi, [ebp+16]   ;;; move lineOfText address into ESI initializing it to point at first byte
    mov edx, [ebp+16]   ;;; save the address of the beginning byte to return after function runs
    
_readBytesLoop:
    ;;; loop starts by zeroing out EAX and EDX which will be used for comparing bytes from inBuffer and Stack    
    mov eax, 0x00000000  ;;; zero the EAX register
    ;;;mov edx, 0x00000000  ;;; zero the EDX register
    mov byte al, [esi]   ;;; move an input byte to last byte to AL (last byte of EAX register) so if first input byte is 'z', then AL=0x7A
    cmp al, [ebp+8]
    je _charReplace
    inc esi
    cmp esi, [ebp+20]
    jne _readBytesLoop
    jmp _returnValue
    
_charReplace: 
    mov esi, [ebp+12]
    inc esi
    cmp esi, [ebp+20]
    jne _readBytesLoop
    
_returnValue:   
    mov eax, edx    ;;; return address of modified line of text
    
    pop edi     ;;; restore the register that the CAllee is responsible for
    pop esi     ;;; note: reverse order that we pushed them above
    pop ebx  

    ;add ESP, 12 ;;; give back the local variable space that was reserved on the stack
    
    pop ebp     ;;; restoring the Caller's "stack frame pointer"
    
    ret         ;;; pop the return address off the stack and into the IP (Instruction Pointer)
                ;;; so the execution resume where the Caller left off...
