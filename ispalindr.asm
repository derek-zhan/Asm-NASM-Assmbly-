
; define offsets of parameters
%define n [ebp+8]
%define string [ebp+12]

	segment .data
flag	db 0
	
segment .text
global ispalindr

ispalindr:	
	enter 0,0
	pusha	
	mov eax, n		; eax=n

	cmp eax, 2
	jl palindrome

	dec eax			; eax=n-1
	mov esi, string		; esi pointer to the array
	mov edx, esi		; edx = string
	add edx, eax		; edx = string+(n-1)
	mov bl, [edx]		; ebx=string[n-1]
	
	cmp bl, [esi]		; string[0]==string[n-1]
	jnz not_palindrome	; string[0]!=string[n-1]

	dec eax			; eax=n-2
	inc esi			; string+1
	push esi
	push eax
	call ispalindr
	pop  ecx
	pop  ecx
	cmp eax,1		; palindrome found
	jz  palindrome
	jnz not_palindrome
		
palindrome:	
	mov byte [flag], 1
	jmp done

not_palindrome:	
	mov byte [flag], 0	

done:		
	popa
	mov eax, [flag]
	leave
	ret
