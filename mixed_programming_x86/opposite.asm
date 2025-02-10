.686
.model flat

.code

_opposite_number PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	mov eax, sdword ptr [ebp + 8]
	mov edi, -1
	imul edi

	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_opposite_number ENDP


END