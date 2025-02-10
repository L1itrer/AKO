.686
.model flat


.code

_avg_wg PROC
	push ebp
	mov ebp, esp
	push ebx

	finit
	mov ecx, [ebp+8] ;n
	mov eax, [ebp+16];weights
	mov ebx, 0
	fld dword ptr [eax+4*ebx]
	inc ebx ; bootstraping the additon
weights_loop:
	fld dword ptr [eax+4*ebx]
	fadd
	inc ebx
	cmp ebx, ecx
	jne weights_loop
	mov ebx, 0
	mov edx, [ebp+12]
	fld dword ptr [eax + 4*ebx]
	fld dword ptr [edx + 4*ebx]
	fmul
	inc ebx
licznik_loop:
	fld dword ptr [eax + 4*ebx]
	fld dword ptr [edx + 4*ebx]
	fmul
	fadd
	inc ebx
	cmp ebx, ecx
	jne licznik_loop
	fxch
	fdiv


	pop ebx
	pop ebp
	ret
_avg_wg ENDP

END