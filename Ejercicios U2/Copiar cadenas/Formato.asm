;=========================================================================================
;ITSUR | Ing. en Sistemas Computacionales
;LENGUAJES DE INTERFAZ | S66A
;Profesor: Jorge Guzman Ramos
;Alumno: Jorge Luis Medina Gaytan - S14120040
;Programa: Mover y copiar cadenas
;=========================================================================================

Pila SEGMENT STACK                                          ;Define la pila
    
    DW 64 DUP (' ')                                         ;Espacio para la pila

Pila ENDS                                                   ;Termina la pila

Datos SEGMENT                                               ;Define sgmento de datos
    
    Cadena1 DB 10,13,"TEXTO 1",10,13,"$"                    ;Define constante
    Cadena2 DB 10,13,"       ",10,13,"$"                    ;Define constante
    Cadena3 DB 10,13,"       ",10,13,"$"                    ;Define constante

Datos ENDS                                                  ;Termina segmento



    
Codigo SEGMENT                                              ;Define segmento de codigo 
        
    ASSUME SS:Pila, DS:Datos, CS:Codigo                     ;Asignar datos;
    
    Inicio:                                                 ;Inicia el programa
    
    MOV     AX,Datos                                        ;Direcciona el segmento de datos
    MOV     DS,AX                                           ;Peticion
    MOV     ES,AX                                           ;Segmento para cadenas
    
    ;=====================================================================================================================
    
    
    CLD
    MOV CX,12                                               ;El numero indica la cantidad de caracteres que caben en la cadena
    LEA SI,Cadena1                                          ;Lee la cadena
    LEA DI,Cadena2                                          ;Lee la cadena
    REP MOVSB                                               ;Mueva la cadena
    
    CLD
    MOV CX,7                                                ;El numero indica la cantidad de caracteres que caben en la cadena
    LEA SI,Cadena1                                          ;Lee la cadena
    LEA DI,Cadena3                                          ;Lee la cadena
    REP MOVSW                                               ;Mueva la cadena
    
    MOV     AH,09H                                          ;Peticion de despliegue
    MOV     DX,Offset Cadena1                               ;Direccionar el mensaje
    INT     21H                                             ;Llamada al sistema
   
    MOV     AH,09H                                          ;Peticion de despliegue
    MOV     DX,Offset Cadena2                               ;Direccionar el mensaje
    INT     21H                                             ;Llamada al sistema
    
    MOV     AH,09H                                          ;Peticion de despliegue
    MOV     DX,Offset Cadena3                               ;Direccionar el mensaje
    INT     21H                                             ;Llamada al sistema
    
    
    
    ;=====================================================================================================================
    
    MOV     AH,4CH                                          ;Peticion de terminhar
    INT     21H                                             ;LLamada al sistema

Codigo ENDS                                                 ;Termina el codigo

END Inicio                                                  ;Termina el programa













