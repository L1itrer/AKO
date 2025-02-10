.686
.model flat

printf PROTO C :VARARG
extern _printf : PROC

.data

message db "The value of EAX: %d", 10, 0

.code

_calling_printf_example PROC
	push ebp
	mov ebp, esp
	mov eax, 2137


	mov eax, ebx
	and al, 0FH
	xor edx, ecx
	inc esi
	dec edi
	mov ecx, [ebp]

	push eax
	push offset message
	call _printf
	add esp, 8

	pop ebp
	ret
_calling_printf_example ENDP

END