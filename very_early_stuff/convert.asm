.686
.model flat

extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
extern __write : PROC
extern __read : PROC
extern _gets : PROC

;printf PROTO C : VARARG ;magic printf prototype

.data
w_title				db "Tekst zamieniony na wielkie litery", 0
w_title_utf16		dw 'W', 'i', 'e', 'l', 'k', 'i', 'e', ' ','l', 'i', 't', 'e', 'r', 'y', 0
message				db "Write a string to display: ", 0
endmessage			db 0
polish_lower		db 165, 134, 169, 136, 228, 162, 152, 171, 190;latin-2
polish_upper		db 164, 143, 168, 157, 227, 224, 151, 141, 189;latin-2

;polish_lower_1250	db 0B9H, 0E6H, 0EAH, 0B3H, 0F1H, 0F3H, 9CH, 9FH, 0BFh; 1250
;polish_upper_1250	db 0A5H, 0C6H, 0CAH, 0A3H, 0D1H, 0D3H, 8CH, 8FH, 0AFH;1250

polish_lower_utf16 dw 0105H, 0107H, 0119H, 0142H, 0144H, 00F3H, 015BH, 017AH, 017CH
polish_upper_utf16 dw 104H, 106H, 118H, 141H, 143H, 0D3H, 15AH, 179H, 17BH

sequence_czerwiec db 'czerwiec'
sequence_grudzien db 228, 'zie'
buffer db 80 dup (0)
output_buffer db 160 dup (0)

.code

;10.02 note - i think this converts every string "czerwiec" into 6
;and every "grudzien" into 12

_main PROC
	mov ecx, (OFFSET endmessage) - (OFFSET message)
	push ecx
	push OFFSET message
	push 1
	call __write

	push 80
	push offset buffer
	push 0
	call __read
	add esp, 24

	mov ecx, eax
	mov edx, 0
	mov ebx, 0
	mov esi, 0
petla:
	mov bl, buffer[edx]
	cmp bl, 'a'
	jb next
	cmp bl, 'z'
	jbe ascii
	call compare_utf16
	add edx, 1
	add esi, 1
	loop petla
	jmp end_program
ascii:
	;sub bl, 20H
next:	
	mov output_buffer[2 * esi], bl
	mov output_buffer[2 * esi + 1], 0
	call check_czerwiec
	add edx, 1
	add esi, 1
	loop petla
	jmp end_program

check_czerwiec:
	push ebx
	mov ebx, 'rezc'; czer rezc
	cmp ebx, dword ptr buffer[edx]
	jne check_grudzien
	mov ebx, 'ceiw'
	add edx, 4
	cmp ebx, dword ptr buffer[edx]
	jne check_grudzien_sub4
	add edx, 3
	mov output_buffer[2 * esi], '6'
	mov output_buffer[2 * esi + 1], 0
	jmp check_end
check_grudzien_sub4:
	sub edx, 4
check_grudzien:
	mov ebx, 'durg'; grud durg
	cmp ebx, dword ptr buffer[edx]
	jne check_end
	add edx, 4
	mov ebx, 65697AE4H;zie 228 228, zie
	cmp ebx, dword ptr buffer[edx]
	jne check_end_sub4
	mov output_buffer[2 * esi], '1'
	mov output_buffer[2 * esi + 1], 0
	mov output_buffer[2 * esi + 2], '2'
	mov output_buffer[2 * esi + 3], 0
	add edx, 3
	add esi, 1
	jmp check_end
check_end_sub4:
	sub edx, 4
check_end:
	pop ebx
	ret
	

compare_utf16:
	mov al, buffer[edx]
	push ecx
	mov ecx, -1
compare_loop_utf16:
	inc ecx
	cmp ecx, 8
	ja compare_loop_escape_utf16
	mov al, buffer[edx]
	cmp al, polish_lower[ecx]
	je compare_loop_lower
	cmp al, polish_upper[ecx]
	je compare_loop_upper
	jne compare_loop_utf16
compare_loop_escape_utf16:
compare_loop_lower:
	mov ax, polish_lower_utf16[2*ecx]
	jmp compare_loop_end
compare_loop_upper:
	mov ax, polish_upper_utf16[2*ecx]
compare_loop_end:
	mov output_buffer[2 * esi], al
	mov output_buffer[2 * esi + 1], ah
	pop ecx
	ret


end_program:

	push 0
	push offset w_title_utf16
	push offset output_buffer
	push 0
	call _MessageBoxW@16


	push 0
	call _ExitProcess@4

_main ENDP
END