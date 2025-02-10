.686
.model flat

puts PROTO C :DWORD
;printf PROTO C :VARARG

mem2mem MACRO m1, m2
	push m1
	pop m2
ENDM



.data

msg db "ale jak", 0

.code


_nie_zadziala PROC
	push ebp
	mov ebp, esp
	push ebx

	
	push -1
	mov ebx, 10
	.while ebx >= sdword ptr 0
		dec ebx
		push offset msg
		call puts
		add esp, 4
		;invoke printf, offset msg

	.endw
	add esp, 4



	mov eax, 5
	mov ebx, 5
	.if eax == ebx
		mov eax, 2137h
	.else
		mov eax, 69h
	.endif



	je jej
	jz jej
jej:

	mem2mem dword ptr [eax], dword ptr [eax]

	pop ebx
	pop ebp
	ret
_nie_zadziala ENDP
END