.686
.model flat

.code
_add_floats_positive PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi

	mov ebx, [ebp+12]
	mov eax, [ebp+8] ; odczytujemy parametry a i b
	cmp eax, ebx
	ja eax_larger

	xchg eax, ebx ; chcemy doda� mniejsz� liczb� do wi�kszej
	; od teraz eax zawiera wi�ksz� liczb�, a ebx mniejsz�
eax_larger:
	mov ecx, eax ; zachowujemy kopi� wi�kszej liczby, chcemy na niej robi� operacje
	shr ecx, 23 ; izolujemy wyk�adnik
	mov edi, ebx 
	shr edi, 23
	sub ecx, edi ; teraz ecx zawiera r�nic� wyk�adnik�w kt�ra jest zawsze dodatnia
	;ecx bo zaraz b�dziemy shiftowali
	mov edi, ebx
	cmp cl, 0 ; je�li wyk�adniki liczb s� identyczne to ten algorytm dzia�a inaczej
	je equal_exponents

	shl edi, 9
	shr edi, 9 ;izolujemy mantys� mniejszej liczby
	bts edi, 23 ; ujawniamy niejawn� jedynk�
	shr edi, cl ;zr�wnujemy wyk�adniki
	add eax, edi
	jmp add_floats_positive_end
equal_exponents:
	mov ecx, eax ;ecx zawiera kopi� wi�kszej liczby, edi nadal ma kopi� mniejszej
	shl ecx, 9 ; ale z tej wi�kszej liczby potrzebujemy tylko mantysy
	shr ecx, 9
	add ecx, edi ; wyk�adniki s� r�wne mo�emy doda� liczby
	shl ecx, 9
	shr ecx, 10 
	;mantysa jest ju� poprawna, teraz musimy zaj�� si� wyk�adnikiem
	shr eax, 23
	add eax, 1 ; zwi�kszamy wyk�adnik o 1
	shl eax, 23

	or eax, ecx

add_floats_positive_end:
	push eax
	fld dword ptr [esp]
	add esp, 4

	pop edi
	pop ebx
	pop ebp
	ret
_add_floats_positive ENDP


END