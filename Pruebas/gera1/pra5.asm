Pila SEGMENT stack                                    ;Define la pila
    DW 64 DUP('')                                     ;Espacio para la pila
Pila ENDS                                             ;termina la pila
Datos SEGMENT                                         ;Define segmentos de datos
    Saludo DB 10,13,"Cambio de MAYUSCULAS",10,13,"$"  ;Define una constante
Datos ENDS                                            ;Termina Segmento de datos
Codigo SEGMENT                                        ;define segmento de codigo
    ASSUME ss:Pila,DS:Datos,cs:Codigo       
Inicio:
    MOV AX,Datos
    MOV DS,AX
    ;*****Macro de despliegue*****
    Display MACRO MSG
        MOV AH,09H
        MOV DX,offset MSG
        INT 21H;
        ENDM
     ;****************************
     Display Saludo
     LEA BX,Saludo
     Mayusc:
        MOV AH,[BX]
        CMP AH,61H
        JB Brincala
        CMP AH,7AH
        JA Brincala
        AND AH, 11011111B
        MOV [BX],AH
        MOV CX,21
        Brincala:
        INC BX
      LOOP Mayusc 
      Display Saludo
      MOV AX,4C00H
INT 21H                         ;Llamada al sistema
MOV AH,4CH                      ;Peticion de terminar
INT 21H                         ;Llamada al sistema
Codigo ENDS                     ;Termina codigo
END Inicio                      ;Termina el programa