;-------------------------------------------------------------------------------
.model small
.stack
;-------------------------------------------------------------------------------
.data

dom db 'Domingo',00h,'$'
lun db 'Lunes',00h,'$'
mar db 'Martes',00h,'$'
mie db 'Miercoles',00h,'$'
jue db 'Jueves',00h,'$'
vie db 'Viernes',00h,'$'
sab db 'Sabado',00h,'$'


year dw ?
mes db ?
dia db ?
ndia db ?
mens db 'La fecha actual es:',0ah,0dh,'$'

;-------------------------------------------------------------------------------
.code
.startup
;------------principia programa prinicipal---------------------------------------

mov ah,2ah ;rutina para solicitar fecha
int 21h

mov year,cx
mov mes,dh
mov dia,dl
mov ndia,al

mov ah,09h
mov dx,offset mens
int 21h

sub ax,ax
sub bx,bx
sub dx,dx

;.........compara nombre del dia................................................
cmp ndia,00
je ndom
cmp ndia,01
je nlun
cmp ndia,02
je nmar
cmp ndia,03
je nmier
cmp ndia,04
je njue
cmp ndia,05
je nvier
cmp ndia,06
je nsab
jmp fin
;.......domingo..............

ndom: 
mov ah,09
mov dx,offset dom
int 21h
jmp ldia

;.......lunes................

nlun:
mov ah,09
mov dx,offset lun
int 21h
jmp ldia

;........martes...............

nmar:
mov ah,09
mov dx,offset mar
int 21h
jmp ldia

;........miercoles............

nmier:
mov ah,09
mov dx,offset mie
int 21h
jmp ldia

;........jueves...............

njue:
mov ah,09
mov dx,offset jue
int 21h
jmp ldia

;........viernes.............

nvier:
mov ah,09
mov dx,offset vie
int 21h
jmp ldia

;.......sabado...............

nsab:
mov ah,09
mov dx,offset sab
int 21h
jmp ldia

;.......Mostrar dia........................

ldia:

sub ax,ax
sub bx,bx
sub dx,dx

mov al,dia
mov bx,0ah
div bl
or ax,3030h

mov dx,ax
mov ah,02h
int 21h

xchg dh,dl
mov ah,02h
int 21h

mov dl,47
mov ah,02h
int 21h

;.........Mostrar mes....................
sub ax,ax
sub bx,bx
sub dx,dx

mov al,mes
mov bx,0ah
div bl
or ax,3030h

mov dx,ax
mov ah,02h
int 21h

xchg dh,dl
mov ah,02h
int 21h

mov dl,47
mov ah,02h
int 21h


;.........Mostrar a?o.....................

sub ax,ax
sub bx,bx
sub dx,dx

mov ax,year
mov bx,0ah
div bx
or dx,3030h
push dx
sub dx,dx
div bx
or dx,3030h
push dx
sub dx,dx
div bx
or dx,3030h
push dx
or ax,3030h
push ax
pop dx
mov ah,02h
int 21h
pop dx
mov ah,02h
int 21h
pop dx
mov ah,02h
int 21h
pop dx
mov ah,02h
int 21h



;------------termina programa principal----------------------------------
fin:
.exit
end