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

	xchg eax, ebx ; chcemy dodaæ mniejsz¹ liczbê do wiêkszej
	; od teraz eax zawiera wiêksz¹ liczbê, a ebx mniejsz¹
eax_larger:
	mov ecx, eax ; zachowujemy kopiê wiêkszej liczby, chcemy na niej robiæ operacje
	shr ecx, 23 ; izolujemy wyk³adnik
	mov edi, ebx 
	shr edi, 23
	sub ecx, edi ; teraz ecx zawiera ró¿nicê wyk³adników która jest zawsze dodatnia
	;ecx bo zaraz bêdziemy shiftowali
	mov edi, ebx
	cmp cl, 0 ; jeœli wyk³adniki liczb s¹ identyczne to ten algorytm dzia³a inaczej
	je equal_exponents

	shl edi, 9
	shr edi, 9 ;izolujemy mantysê mniejszej liczby
	bts edi, 23 ; ujawniamy niejawn¹ jedynkê
	shr edi, cl ;zrównujemy wyk³adniki
	add eax, edi
	jmp add_floats_positive_end
equal_exponents:
	mov ecx, eax ;ecx zawiera kopiê wiêkszej liczby, edi nadal ma kopiê mniejszej
	shl ecx, 9 ; ale z tej wiêkszej liczby potrzebujemy tylko mantysy
	shr ecx, 9
	add ecx, edi ; wyk³adniki s¹ równe mo¿emy dodaæ liczby
	shl ecx, 9
	shr ecx, 10 
	;mantysa jest ju¿ poprawna, teraz musimy zaj¹æ siê wyk³adnikiem
	shr eax, 23
	add eax, 1 ; zwiêkszamy wyk³adnik o 1
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