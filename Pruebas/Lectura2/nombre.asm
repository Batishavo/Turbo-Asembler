.model small
.stack
.data

mensaje1 db 'Programa para Introducir datos','$'
mensaje2 db '1.?Cual es tu nombre?: ','$'

cadena1 db 30 dup(' ')



namepar label byte
maxlen   db    20
actlen   db    ?
namefld  db 20 dup(' ')

.code

iniciar:
mov ax,@data
mov ds,ax
;------------------------crear una pantalla
mov ax,0600h
mov bh,71h
mov cx,0000h
mov dx,184fh
int 10h
;------------------------mensaje inicial
;--------fijar el cursor
mov ah,02h
mov bh,00
mov dh,00
mov dl,20
int 10h
mov ah,09h
lea dx,mensaje1
int 21h
;-----------------------primera pregunta
;-------------fijar el cursor
mov ah,02h
mov bh,00
mov dh,03
mov dl,00
int 10h
mov ah,09h
lea dx,mensaje2
int 21h
;----------pausa
mov ah,08h
int 21h
;---------capturar cadena
mov ah,3fh
mov bx,00
mov cx,30 ;defines la longitud de la cadena
lea dx,cadena1 ; donde la guardaras
int 21h
;-------------------------termina primera pregunta
;-------------------------escribes la cadena en pantalla
;-------------fijas el cursor de nuevo
mov ah,02h
mov bh,00
mov dh,05
mov dl,00
int 10h


;---------escribir la cadena
mov ah,40h
mov bx,01
mov cx,30
lea dx,cadena1
int 21h

mov ax,4c00h
int 21h

end iniciar










