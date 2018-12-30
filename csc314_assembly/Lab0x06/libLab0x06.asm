section .text
    global _sumAndPrintList ;;; "global" keyword externalizes a symbol, so the linker can find it
    ;extern printf           ;;; let's the linker to look for the standard C library
    
_sumAndPrintList:           ;;; this function takes two parameters. *list - a pointer to an array of 4-byte integers
                            ;;; and length - a 4 byte integer: a count of how many numbers are in the list (size of the array)
                            
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;;; needs 2 parameter: 
    ;;; *list  - pointer to signed integer array ----> [EBP+8]
    ;;; length - 4-byte integer for size of the array ----> [EBP+12]

    push EBP        ;;; save the "stack frame pointer" of the Caller
    
    mov EBP, ESP    ;;; make the current top of stack the "frame pointer" of this function call (the callee)
                    ;;; EBP, the "frame pointer" gives us a reference point to find the parameters and the local variables of our function
                    
    sub ESP, 4      ;;; we need 4 bytes for 1 unsigned 32-bit integers as local variables, that we are using for intermediate values
    
    push EBX        ;;; saving registers that we might mess with, and we must restore these before we return!!!
    push ESI        ;;; note: we don't need to save/restore these if we're note going to touch them
    push EDI



    mov dword [EBP-4], 0      ;;; zero out local variable to use as running total
    
                        ;;; print headers for the two columns "Numbers" "Running Total"
    
_addAndPrintLoop:       ;;; Move the array address and length into a register to do the math    
    mov ESI, [EBP+8]    ;;; store the address of the integer array into ESI 
    mov EDI, [EBP+12]   ;;; store the length into EDI to decrease as we increase ESI
    
    ;;; store the first integer into EAX
    mov EAX, [ESI]        
    add [EBP-4], EAX
    
                        ;;; print EAX (number from the list) and EBP-4 (running total)

_continue:    
    inc ESI             ;;; move to next index in array
    dec EDI             ;;; decrease length count
    jnz _addAndPrintLoop
    

    mov EAX, [EBP-4]   ;;;     return integer sum of the list;
    
    pop EDI     ;;; restore the register that the CAllee is responsible for
    pop ESI     ;;; note: reverse order that we pushed them above
    pop EBX  

    add ESP, 4 ;;; give back the local variable space that was reserved on the stack
    
    pop EBP     ;;; restoring the Caller's "stack frame pointer"
    
    ret         ;;; pop the return address off the stack and into the IP (Instruction Pointer)
                ;;; so the execution resume where the Caller left off...

    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    
;section .data
    ;;; NOTE:  we have to supply the null terminator for strings "manually", that is why the 0x00's at the ends of these
    ;;;  we did not need these previously because sys_read and sys_write work with arrays of specific *counts* of bytes,
    ;;;  whereas strings require a null terminator byte to indicat the end of the string (so you don't need a count to find the end).

    ;scanFormatStr  db "%100s",0x00   ;;; format string for scanf to use

    ;promptStr      db "Please enter a word: ",0x0A,0x00  ;;; text to print with a printf

    ;printFormatStr db "Here is the word you entered: %s",0x0A,0x00

;section .bss

    ;inputString resb 101   ;;; reserve space for a 100 char array --> C equivalent: char inputString[101]
    
    

