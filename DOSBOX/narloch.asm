.386
.386
rozkazy SEGMENT use16
    ASSUME CS:rozkazy

obsluga_zegara PROC
    dec si
    jnz nie_minela_sekunda

    push AX
    push bx
    push es



    mov ax, 0b800h ;adres pamięci ekranu, prawdziwy jest pomnożony przez 16 ale to robi cpu
    mov es, ax

    mov bx, cs:licznik ;licznik zawiera adres bieżący w pamięci ekranu
    mov byte ptr es:[bx-2], cl
    mov byte ptr es:[bx-1], dl

    mov cl, byte ptr es:[bx]
    mov dl, byte ptr es:[bx+1]

    mov byte ptr es:[bx], '*' ;ascii
    mov byte ptr es:[bx+1], 00001101b    

    add bx, 2

    cmp bx, 4000
    jb wysw_dalej

    mov bx, 0
wysw_dalej:
    mov cs:licznik, bx
    pop es
    pop bx
    pop ax
    mov si, 18

nie_minela_sekunda:
    jmp dword ptr cs:wektor8

    licznik dw 320
    wektor8 dd ?

obsluga_zegara ENDP


zacznij:
    mov al, 0
    mov ah, 5
    int 10

    mov ax, 0b800h ;adres pamięci ekranu, prawdziwy jest pomnożony przez 16 ale to robi cpu
    mov es, ax

    mov si, 18 ;wywołanie zegarowe co sekundę
    mov bx, 318

    mov cl, byte ptr es:[bx]
    mov dl, byte ptr es:[bx+1]

    mov ax, 0
    mov ds, ax
    mov eax, ds:[4*8]
    mov cs:wektor8, eax

    mov ax, SEG obsluga_zegara
    mov bx, OFFSET obsluga_zegara

    cli

    mov ds:[32], bx
    mov ds:[34], ax

    sti
aktywne_oczekiwanie:
    mov ah, 1
    int 16h
    jz aktywne_oczekiwanie

    mov ah, 0
    int 16h
    cmp al, 'x'
    jne aktywne_oczekiwanie

    mov eax, cs:wektor8
    cli
    mov ds:[4*8], eax
    sti

    mov al, 0
    mov ah, 4ch
    int 21h

rozkazy ENDS

nasz_stos SEGMENT stack
    db  128 dup (?)
nasz_stos ENDS

END zacznij