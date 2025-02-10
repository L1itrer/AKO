.686
.model flat

.code 
_exponent PROC
	push ebp
	mov ebp, esp
	sub esp, 4
	push ebx
	
	mov ebx, [ebp+12]
	fld dword ptr [ebp+8]
	fst dword ptr [ebp-4]
	cmp ebx, 1
	je end_exp
	
	dec ebx
exponent_loop:
	fmul dword ptr [ebp-4]
	dec ebx
	jnle exponent_loop
end_exp:
	pop ebx
	add esp, 4
	pop ebp
	ret
_exponent ENDP

_factorial PROC
	push ebp
	mov ebp, esp
	push ebx
	push eax
	mov edx, 0
	mov ebx, [ebp+8] ;ebx ma n
	fld1
factorial_loop:
	push ebx
	fild dword ptr [esp]
	pop ebx
	fmul
	dec ebx
	jnz factorial_loop
	

	pop eax
	pop ebx
	pop ebp
	ret
_factorial ENDP

_nowy_exp PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi
	mov ecx, 1

	finit
	fld1
nowy_exp_loop:
	push ecx
	mov edx, [ebp+8]
	push ecx ; do jakiej potêgi
	push edx ; jaki wyraz
	call _exponent 
	add esp, 8
	call _factorial ; na st(0) jest silnia danego wyrazu
	add esp, 4
	fdivp st(1), st(0)
	fadd
	inc ecx
	cmp ecx, 20
	jne nowy_exp_loop


	pop esi
	pop edi
	pop edx
	pop ebp
	ret
_nowy_exp ENDP

END