extern malloc : PROC
extern chuj : dword

public convert_to_string


.data

.code

change PROC

change ENDP



convert_to_string PROC
	push rbp
	mov rbp, rsp
	push rbx
	push rsi
	push rdi
	push r12

	mov rsi, [rcx]
	mov rdi, rdx
	
	mov rcx, 260
	sub rsp, 32
	call malloc
	add rsp, 32




	mov r8d, 10 ;dzielnik
	mov r9, 0 ;dlugosc tablicy
	mov rcx, 0
	mov r12, rax ;r12 to wskaünik na tablice
	mov rax, rsi
conversion_first:
	xor rdx, rdx
	div r8d
	add dl, 30h
	push rdx
	inc r9
	cmp rax, 0
	jne conversion_first

store_in_memory:
	pop rdx
	mov byte ptr [r12+rcx], dl
	inc rcx
	mov byte ptr [r12+rcx], 0
	inc rcx
	dec r9
	jnz store_in_memory

	mov rax, rdi
conversion_second:
	xor rdx, rdx
	div r8d
	add dl, 30h
	push rdx
	inc r9
	cmp rax, 0
	jne conversion_second


store_in_memory_second:
	pop rdx
	mov byte ptr [r12+rcx], dl
	inc rcx
	mov byte ptr [r12+rcx], 0
	inc rcx
	dec r9
	jnz store_in_memory_second


	

	mov word ptr [r12+rcx], 0
	
	mov rax, r12
	pop r12
	pop rdi
	pop rsi
	pop rbx
	pop rbp
	ret
convert_to_string ENDP


END