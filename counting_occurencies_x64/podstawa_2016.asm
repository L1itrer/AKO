extern malloc : PROC
extern qsort : PROC

.code

wystapienia PROC
	push rbp
	mov rbp, rsp
	push rbx
	push rdi
	push rsi
	push r12

	mov [rbp+16], rdx 
	mov [rbp+24], rcx

	mov rcx, 5*256
	sub rsp, 32
	call malloc
	add rsp, 32

	mov rdx, 0

inicjalizacja:
	lea rcx, [rdx+rdx*4]
	mov byte ptr [rax+rcx], dl
	mov dword ptr [rax+rcx+1], 0
	inc rdx
	cmp rdx, 256
	jne inicjalizacja
	
	mov rcx, [rbp+16]
	mov rdx, [rbp+24]

petla_liczbowa:
	mov rbx, 0
	mov bl, [rdx+rcx-1]
	lea rbx, [rbx+4*rbx]
	add dword ptr [rax+rbx+1], 1
	dec rcx
	jnz petla_liczbowa


	pop r12
	pop rsi
	pop rdi
	pop rbx
	pop rbp
	ret

wystapienia ENDP

sortuj PROC
	push rbp
	mov rbp, rsp
	push rbx
	push rdi
	push rsi
	push r12

	mov r8, 5
	lea r9, [compare]
	sub rsp, 32
	call qsort
	add rsp, 32

	pop r12
	pop rsi
	pop rdi
	pop rbx
	pop rbp
	ret
sortuj ENDP

compare PROC
	mov rax, 0
	mov ecx, dword ptr [rcx+1]
	mov edx, dword ptr [rdx+1]
	cmp ecx, edx
	mov r10, 1
	mov r11, -1
	cmova rax, r11
	cmovb rax, r10
	ret

compare ENDP

END