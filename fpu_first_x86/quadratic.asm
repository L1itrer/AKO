.686
.XMM
.model flat

.data
wsp_a dd +2.0
wsp_b dd -1.0
wsp_c dd -15.0

dwa dd 2.0
cztery dd 4.0
x1 dd ?
x2 dd ?

local_variables_space equ 4

extern _factorial : PROC

.code










_srednia_harm PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi
	
	mov ecx, dword ptr [ebp+12]
	xor edi, edi
	mov ebx, dword ptr [ebp+8]
	
	finit
	fldz
mianownik_loop:
	fld1
	fdiv dword ptr [ebx+edi*4]
	faddp
	inc edi
	cmp edi, ecx
	jnae mianownik_loop

	fild dword ptr [ebp+12]
	fxch
	fdivp


	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_srednia_harm ENDP









_quadratic_func PROC
	finit
	fmul st(1), st(0)
	fld wsp_a
	fld wsp_b
	fst st(2) ; kopiuj wierzcho³ek do st(2)
; st(0) = wsp_b st(1) = wsp_a st(2) = wsp_b
	
	fmul st(0), st(0); b^2
	fld dword ptr cztery
;st(0) = 4.0 st(1) b^2 st2(2) = a st(3) = b
	fmul st(0), st(2) ; 4a teraz jest na st(0)
	fmul dword ptr wsp_c ;st(0) to teraz 4ac

	fsubp st(1), st(0) ;st(0) to teraz delta

	fldz ;wczytaj 0

	fcomi st(0), st(1)
	fstp st(0)

	ja negative_delta ; to jest z³e, porównujemy 0 do st(1) wiêc jeœli 0 jest wiêksze ni¿ st(1)
	;to oczywiœcie st(1) jest mniejsze od zero wiêc ujemne
	fxch
	fadd st(0), st(0); 2a
	fstp st(3)
	;st(0) = delta st(1) = b st(2) = 2a

	fsqrt
	fst st(3)
	fchs
	fsub st(0), st(1)
	fdiv st(0), st(2)
	fstp dword ptr x1

	fchs
	fadd st(0), st(2)
	fdiv st(0), st(1)
	fstp dword ptr x2

	fstp st(0)
	fstp st(0)



negative_delta:
	ret
_quadratic_func ENDP


END