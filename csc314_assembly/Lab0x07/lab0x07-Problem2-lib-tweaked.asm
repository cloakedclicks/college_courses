section	.text
    global	sumAtoB

sumAtoB:
	push ebp
	mov	 ebp, esp
	sub	 esp, 16
	
	mov	 eax, DWORD [ebp+8] ;;; move 1st parameter into EAX 
	;mov DWORD [ebp-8], eax ;;; move EAX into local variable completes the i=a; command
	mov  ebx, eax
	;mov DWORD [ebp-4], 0   ;;; move zero into local variable completes the s=0; command
	xor  edx, edx
	jmp	_L2
_L3:
	;mov eax, DWORD [ebp-8]
	mov  eax, ebx
	;add DWORD [ebp-4], eax
	add  edx, eax
	;add DWORD [ebp-8], 1
	inc  ebx
_L2:
	;mov eax, DWORD [ebp-8]
	mov  eax, ebx
	cmp	 eax, DWORD [ebp+12]    ;;; compare 2nd parameter with EAX i<=b;
	jle	_L3                     ;;; loop starts if i is less than b
	;mov eax, DWORD [ebp-4]
	mov  eax, edx
	leave
	ret
