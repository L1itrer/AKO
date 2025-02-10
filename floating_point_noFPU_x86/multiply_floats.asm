.686
.model flat

.code

_multiply_floats PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

	mov eax, [ebp+12]
	mov ebx, [ebp+8]
	shl eax, 9
	shr eax, 9
	shl ebx, 9
	shr ebx, 9
	bts eax, 23
	bts ebx, 23
	mov edx, 0
	mul ebx
	mov ecx, 23
konwersja:
	shr edx, 1
	rcr eax, 1
	dec ecx
	jnz konwersja


	fldz

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_multiply_floats ENDP

END