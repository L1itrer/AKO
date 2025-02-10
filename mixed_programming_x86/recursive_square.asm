.686
.model flat

.code

_recursive_square PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi
	mov ebx, [ebp+8]
	cmp ebx, 1
	je a_eq_one
	cmp ebx, 0
	je a_eq_zero
	mov esi, ebx ; esi = a
	sub ebx, 2
	push ebx
	call _recursive_square
	add esp, 4
	mov ebx, 0
	add ebx, esi ;normalnie bym tu waln¹³ lea ale nie wiem czy to siê liczy jako mno¿enie
	add ebx, esi
	add ebx, esi
	add ebx, esi
	sub ebx, 4
	add eax, ebx
	jmp square_end
a_eq_one:
	mov eax, 1
	jmp square_end
a_eq_zero:
	mov eax, 0
	jmp square_end
square_end:

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_recursive_square ENDP

END