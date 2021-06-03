Pila SEGMENT Stack                              ;Define la pila
    DW 64 DUP (' ')                             ;Espacio para la pila
Pila ENDS                                       ;Termina la pila
Datos SEGMENT                                   ;Define segmento de datos
    Cadena1 DB 10,13,"La bota 2",10,13,"$"      ;Define una constante
    Cadena2 DB 10,13,"         ",10,13,"$"      ;Define una constante
    Cadena3 DB 10,13,"         ",10,13,"$"      ;Define una constante
Datos ENDS                                      ;Termina segmento de datos
Codigo SEGMENT                                  ;Define segmento de codigo
    ASSUME SS:Pila,DS:Datos,CS:Codigo           ;Se enlaza etiqueta con registro de segmento
Inicio:                     
    MOV AX,Datos                                ;Direcciona el
    MOV DS,AX                                   ;segmento de datos
    MOV ES,AX                                   ;Segmento para cadenas
    CLD
    MOV CX,12                                   ;El numero indica la cantidad de caracteres que caben en la cadena
    LEA SI,Cadena1
    LEA DI,Cadena2
    REP MOVSB
    CLD
    MOV CX,7
    LEA SI,Cadena1
    LEA DI,Cadena3
    REP MOVSW
    MOV AH,09H                                  ;Peticion de desplegar
    MOV DX,offset Cadena1                       ;Direccionar el mensaje
    INT 21H                                     ;Llamada al sistema
    MOV AH,09H                                  ;Peticion de desplegar
    MOV DX,offset Cadena2                       ;Direccionar el mensaje
    INT 21H                                     ;Llamada al sistema
    MOV AH,09H                                  ;Peticion de desplegar
    MOV DX,offset Cadena3                       ;Direccionar el mensaje
    INT 21H                                     ;Llamada al sistema
    MOV AH,4CH                                  ;Peticion de terminar
    INT 21H                                     ;Llamada al sistema
Codigo ENDS                                     ;Termina el codigo
END Inicio                                      ;Termina el programa