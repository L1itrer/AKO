.386
rozkazy SEGMENT use16
    ASSUME CS:rozkazy

wyswietl_AL PROC
; wyświetlanie zawartości rejestru AL na ekranie wg adresu
; podanego w ES:BX
; stosowany jest bezpośredni zapis do pamięci ekranu
; przechowanie rejestrów
push ax
push cx
push dx
push bx

mov cl, 10 ; dzielnik
mov ah, 0 ; zerowanie starszej części dzielnej
; dzielenie liczby w AX przez liczbę w CL, iloraz w AL,
; reszta w AH (tu: dzielenie przez 10)
div cl
add ah, 30H ; zamiana na kod ASCII
mov es:[bx+4], ah ; cyfra jedności
mov ah, 0
div cl ; drugie dzielenie przez 10
add ah, 30H ; zamiana na kod ASCII
mov es:[bx+2], ah ; cyfra dziesiątek
add al, 30H ; zamiana na kod ASCII
mov es:[bx+0], al ; cyfra setek
; wpisanie kodu koloru (intensywny biały) do pamięci ekranu
mov al, 00001111B
mov es:[bx+1],al
mov es:[bx+3],al
mov es:[bx+5],al
; odtworzenie rejestrów

pop bx
pop dx
pop cx
pop ax
ret ; wyjście z podprogramu
wyswietl_AL ENDP

wyswietl_data PROC
    push ax
    push cx
    push dx
    push bx
    push si
    mov si, cx

    mov cl, 10
    mov bx, 0b800h
    mov es, BX
    xor bx, bx
    mov bl, al
    cmp bl, 7
    jne dalej
    mov bl, 00001100b
    mov byte ptr cs:kolor, bl
dalej:
    xor bx, bx
    mov al, dl

    mov ah, 0 ; zerowanie starszej części dzielnej
    ; dzielenie liczby w AX przez liczbę w CL, iloraz w AL,
    ; reszta w AH (tu: dzielenie przez 10)
    div cl
    add ah, 30H ; zamiana na kod ASCII
    mov es:[bx+4], ah ; cyfra jedności
    mov ah, 0
    div cl ; drugie dzielenie przez 10
    add ah, 30H ; zamiana na kod ASCII
    mov es:[bx+2], ah ; cyfra dziesiątek
    ; wpisanie kodu koloru (intensywny biały) do pamięci ekranu
    mov al, byte ptr cs:kolor
    mov es:[bx+5],al
    mov es:[bx+3],al

    mov al, dh


    mov ah, 0 ; zerowanie starszej części dzielnej
    ; dzielenie liczby w AX przez liczbę w CL, iloraz w AL,
    ; reszta w AH (tu: dzielenie przez 10)
    div cl
    add ah, 30H ; zamiana na kod ASCII
    mov es:[bx+10], ah ; cyfra jedności
    mov ah, 0
    div cl ; drugie dzielenie przez 10
    add ah, 30H ; zamiana na kod ASCII
    mov es:[bx+8], ah ; cyfra dziesiątek

    mov al, byte ptr cs:kolor
    mov es:[bx+11],al
    mov es:[bx+9],al


    mov al, 00001111B
    mov byte ptr cs:kolor, al


    pop si
    pop bx
    pop dx
    pop cx
    pop ax
    ret 
wyswietl_data ENDP

przechwycenie_klawiatury PROC
    push AX
    push bx
    push es

    push ax
    in al, 60h
    cmp al, 77
    jne nie_strzalka_w_prawo
    add dl, 1
    cmp dl, 31
    jne nie_strzalka_w_prawo
    call wyswietl_data
    jmp koniec
nie_strzalka_w_prawo:
    cmp al, 75
    jne nie_strzalka_w_lewo
    cmp dl, 1
    je nie_strzalka_w_lewo
    sub dl, 1

nie_strzalka_w_lewo:
    pop ax
    call wyswietl_data

    in al, 60h
    cmp al, 46
    je koniec
    pop ax
    pop bx
    pop es
    jmp dword ptr cs:wektor8_klawiatura
koniec:
    
    pop ax
    pop bx
    pop es

    mov eax, cs:wektor8_klawiatura
    mov ds:[36], eax

    mov eax, cs:wektor8_zegar
    mov ds:[32], eax

    mov ax, 4c00h
    int 21h

    jmp dword ptr cs:wektor8_klawiatura
wektor8_klawiatura dd ?
przechwycenie_klawiatury ENDP


przechwycenie_zegara PROC

    jmp dword ptr cs:wektor8_zegar
wektor8_zegar dd ?
kolor db 00001111b
przechwycenie_zegara ENDP

zacznij:
    mov al, 0
    mov ah, 5
    int 10

    mov ax, 0
    mov ds, ax
    mov eax, ds:[9*4]
    mov cs:wektor8_klawiatura, eax

    mov ax, SEG przechwycenie_klawiatury
    mov bx, OFFSET przechwycenie_klawiatury

    cli
    mov ds:[36], bx
    mov ds:[38], ax
    sti

    mov ax, 0
    mov ds, ax
    mov eax, ds:[8*4]
    mov cs:wektor8_zegar, eax

    mov ax, SEG przechwycenie_zegara
    mov bx, OFFSET przechwycenie_zegara

    cli
    mov ds:[32], bx
    mov ds:[34], ax
    sti

    mov ah, 2ah
    int 21h

    call wyswietl_data


petelka:
    nop
    jmp petelka

    mov eax, cs:wektor8_klawiatura
    mov ds:[36], eax

    mov eax, cs:wektor8_zegar
    mov ds:[32], eax

    mov ax, 4c00h
    int 21h
rozkazy ENDS

nasz_stos SEGMENT stack
    db  256 dup (?)
nasz_stos ENDS

END zacznij