.686
.model flat

public _find_max

.data

.code

_find_max PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp+8]
	cmp eax, [ebp+12]
	cmovl eax, [ebp+12]
	cmp eax, [ebp+16]
	cmovl eax, [ebp+16]
	pop ebp
	ret
_find_max ENDP

_find_4_max PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp+8]
	cmp eax, [ebp+12]
	cmovl eax, [ebp+12]
	cmp eax, [ebp+16]
	cmovl eax, [ebp+16]
	cmp eax, [ebp+20]
	cmovl eax, [ebp+20]
	pop ebp
	ret

_find_4_max ENDP


END