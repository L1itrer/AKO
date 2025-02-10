.686
.model flat

extern _GetSystemInfo@4 : PROC

.code

_liczba_procesorow PROC
	push ebp
	mov ebp, esp
	sub esp, 36
	push ebx

	lea ebx, [ebp-36]
	push ebx
	call _GetSystemInfo@4

	mov eax, dword ptr [ebp-16]

	pop ebx
	add esp, 36
	pop ebp
	ret
_liczba_procesorow ENDP

END