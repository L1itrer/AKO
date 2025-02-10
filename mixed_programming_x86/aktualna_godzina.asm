.686
.model flat

extern _GetSystemTime@4 : PROC

.code

_aktualna_godzina PROC
	push ebp
	mov ebp, esp
	sub esp, 16
	push ebx
	push esi
	lea esi, [ebp-16]
	push esi
	call _GetSystemTime@4
	mov ax, word ptr [ebp-8]
	movzx eax, ax
	mov esi, dword ptr [ebp+8]
	mov ebx, 10
	mov edx, 0
	div ebx
	add dl, 30h
	mov byte ptr [esi+1], dl
	mov edx, 0
	div ebx
	add dl, 30h
	mov byte ptr [esi], dl
	mov byte ptr [esi+2], 0

	pop esi
	pop ebx
	add esp, 16
	pop ebp
	ret
_aktualna_godzina ENDP


END