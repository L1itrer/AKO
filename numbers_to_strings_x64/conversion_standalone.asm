.686
.model flat

extern _puts : PROC
extern _gets : PROC
extern __read : PROC
extern __write : PROC
extern _ExitProcess@4 : PROC

public _main

.data
;message db "Hello world!", 10, 0
text_data db 11 dup (0)
ten_memory dd 10
format db "%s"
decoder db '0123456789ABCDEF'
temp dd 0

.code

_main PROC

	;call _load_into_EAX_hex
	mov ecx, 000FFFFFFH
	mov edx, 0
	mov eax, 16H
	call _display_EAX_hex

	push dword ptr 0
	call _ExitProcess@4

_main ENDP

_display_EAX_hex PROC
	push eax
	push edi
	push esi
	push edx
	push ecx
	push ebx
	push ebp
	sub esp, 36
	mov ebp, esp

	mov edi, 8
	mov esi, 0
display_HEX_loop_ecx:
	rol ecx, 4
	push esi
	mov esi, ecx
	and esi, 0000000FH
	mov bl, decoder[esi]
	pop esi

	mov [ebp][esi], bl
	inc esi
	dec edi
	jnz display_HEX_loop_ecx

	mov edi, 8
display_HEX_loop_edx:
	rol edx, 4
	push esi
	mov esi, edx
	and esi, 0000000FH
	mov bl, decoder[esi]
	pop esi

	mov [ebp][esi], bl
	inc esi
	dec edi
	jnz display_HEX_loop_edx

	mov edi, 8
display_HEX_loop_eax:
	rol eax, 4
	push esi
	mov esi, eax
	and esi, 0000000FH
	mov bl, decoder[esi]
	pop esi

	mov [ebp][esi], bl
	inc esi
	dec edi
	jnz display_HEX_loop_eax

	mov byte ptr [ebp][24], 10
	mov byte ptr [ebp][25], 0

	xor esi, esi
remove_space_loop:
	cmp byte ptr [ebp][esi], '0'
	jne end_loop
	mov byte ptr [ebp][esi], ' '
	inc esi
	cmp esi, 24
	jb remove_space_loop 

end_loop:
	
	push ebp
	call _puts
	add esp, 40



	pop ebp
	pop ebx
	pop ecx
	pop edx
	pop esi
	pop edi
	pop eax
	ret
_display_EAX_hex ENDP


_load_into_EAX PROC
	push ebx
	push edx
	push esi


	push dword ptr 12
	push dword ptr offset text_data
	push dword ptr 0
	call __read
	add esp, 12

	mov eax, 0
	mov ebx, offset text_data
load_sequence:
	mov cl, [ebx]
	inc ebx
	cmp cl, 10
	je enter_found
	sub cl, 30h
	movzx ecx, cl

	mul dword ptr ten_memory
	add eax, ecx
	jmp load_sequence


enter_found:
	pop esi
	pop edx
	pop ebx	
	ret
_load_into_EAX ENDP


_display_EAX PROC
	push ecx
	push eax
	push ebx
	push esi

	mov esi, 10 ;indeks tablicy
	mov ebx, 10 ;dzielnik

conversion:
	mov edx, 0 ;zerujemy edx przed div!
	div ebx

	add dl, 30h ; zamiana na ascii

	mov text_data[esi], dl
	dec esi
	cmp eax, 0
	jne conversion

fill_blank_space:
	or esi, esi
	jz display
	mov byte ptr text_data[esi], 20h ;spacja
	dec esi
	jmp fill_blank_space

display:
	mov byte ptr text_data[0], 20h

	push dword ptr offset text_data
	call _puts
	add esp, 4

	pop esi
	pop ebx
	pop eax
	pop ecx
	ret
_display_EAX ENDP




_display_96bit PROC
	push eax
	push edi
	push esi
	push edx
	push ecx
	push ebx
	push ebp
	mov esp, esi
	sub esp, 36




	pop ebp
	pop ebx
	pop ecx
	pop edx
	pop esi
	pop edi
	pop eax
	ret
_display_96bit ENDP

_load_into_EAX_hex PROC
	push ebx
	push ecx
	push edx
	push esi
	push edi
	push ebp
	sub esp, 12

	mov esi, esp

	push dword ptr 10
	push esi
	push dword ptr 0
	call __read
	add esp, 12
	xor eax, eax
start_conversion:
	mov dl, [esi]
	inc esi
	cmp dl, 10
	je done

	cmp dl, '0'
	jb start_conversion
	cmp dl, '9'
	ja keep_comparing
	sub dl, '0'
write:
	shl eax, 4
	or al, dl
	jmp start_conversion
keep_comparing:
	cmp dl, 'A'
	jb start_conversion
	cmp dl, 'F'
	ja keep_comparing_more
	sub dl, 'A' - 10
	jmp write
keep_comparing_more:
	cmp dl, 'a'
	jb start_conversion
	cmp dl, 'f'
	ja start_conversion
	sub dl, 'a' - 10
	jmp write
done:
	add esp, 12

	pop ebp
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx

	ret
_load_into_EAX_hex ENDP

END