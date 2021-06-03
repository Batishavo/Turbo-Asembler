Pila SEGMENT Stack ;Define la Pila
DW 64 Dup(' ') ;Espacio para la Pila
Pila ENDS ;Termina la Pila?

Datos SEGMENT ; Define segmento de datos
    Etiqueta LABEL BYTE
    Maxlong DB 30
    Realong DB ?  
    Nombre DB 31 DUP(' ')
    Peticion DB 10,13,"Nombre:","$"  
    Salto db 10,13,"Tu Nombre es:","$"
Datos ENDS;Termina segmento de datos

codigo SEGMENT;Define segmento de codigo
Assume ss:Pila,Ds:Datos,CS:CODIGO;Enlazar la Etiqueta con el registro
Inicio:
MOV AX,Datos
MOV DS,AX
MOV AH,09H
MOV DX,OFFSET Peticion
INT 21H
MOV AH,0AH
LEA DX,Etiqueta
INT 21H
MOV BH,00
MOV BL,Realong
MOV Nombre[BX+1],"$"

MOV AH,09H
LEA DX,Salto
INT 21H

MOV AH,09H
LEA DX,Nombre
INT 21H

MOV AH,4CH;Peticion de terminar
INT 21H;llamada al sistema
Codigo ENDS;termina el codigo
END Inicio;Termina el Programa