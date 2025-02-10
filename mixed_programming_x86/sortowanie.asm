.686
.model flat

.code

sortowanie PROC stdcall, arr : dword, n : dword
	push ebx
	push edi
	push esi

	mov esi, n
	dec esi ; ecx to n - 1
	mov ecx, 0
sortowanie_outer_loop:

	mov edx, 0
	mov edi, esi
	sub edi, ecx
sortowanie_inner_loop:
	mov eax, dword ptr [arr+edx]
	mov ebx, dword ptr [arr+edx+1]
	cmp eax, ebx
	jl eax_is_smaller
	mov eax, dword ptr [arr+edx+1]
	mov ebx, dword ptr [arr+edx]
eax_is_smaller:
	inc edx

	cmp edx, edi
	jne sortowanie_inner_loop

	inc ecx
	cmp ecx, esi
	jne sortowanie_outer_loop

sortowanie_end:
	pop esi
	pop edi
	pop ebx
	ret 8
sortowanie ENDP

END