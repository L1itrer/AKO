.686
.model flat

.code

_subtract_one PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	mov eax, [ebp + 8]
	mov eax, [eax]
	dec sdword ptr [eax]

	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_subtract_one ENDP

END