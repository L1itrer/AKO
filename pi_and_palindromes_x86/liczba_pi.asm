.686
.model flat

.data



.code
_palindrom_tracker = 8
_liczba_pi PROC
	push ebp
	mov ebp, esp
	push ebx
	


	mov ebx, [ebp+8]
	finit
	push 2
	fild dword ptr[esp]
	add esp, 4

	mov ecx, 1
glowna_petla:
	push ecx
	fild dword ptr [esp]
	add dword ptr [esp], 1
	fild dword ptr [esp]
	test ecx, 1
	jz parzysta
	fxch
parzysta:
	add esp, 4
	fdiv
	fmul
	inc ecx
	cmp ecx, ebx
	jna glowna_petla

	pop ebx
	pop ebp
	ret
_liczba_pi ENDP




END