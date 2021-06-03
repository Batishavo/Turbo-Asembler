;=========================================================================================
;ITSUR | Ing. en Sistemas Computacionales
;LENGUAJES DE INTERFAZ | S66A
;Profesor: Jorge Guzman Ramos
;Alumno: Jorge Luis Medina Gaytan - S14120040
;Programa: Comparar dos cadenas iguales
;=========================================================================================

Pila SEGMENT STACK                                          ;Define la pila
    
    DW 64 DUP (' ')                                         ;Espacio para la pila

Pila ENDS                                                   ;Termina la pila


Datos SEGMENT                                               ;Define sgmento de datos
    
    
    msj1    db  0ah,0dh, 'Ingresa cadena 1: ', '$'
    msj2    db  0ah,0dh, 'Ingresa cadena 2: ', '$'
    msj3    db  0ah,0dh, 'Son iguales ', '$'
    msj4    db  0ah,0dh, 'Son diferentes ', '$'
    
    vec1    db  50 dup(' '), '$'                            ;Espacio para ingreso 1
    vec2    db  50 dup(' '), '$'                            ;Espacio para ingreso 2
    
    
Datos ENDS                                                  ;Termina segmento

    
Codigo SEGMENT                                              ;Define segmento de codigo 
        
    ASSUME SS:Pila, DS:Datos, CS:Codigo                     ;Asignar datos;
    
    Inicio:                                                 ;Inicia el programa
    
    MOV     AX,Datos                                        ;Direcciona el segmento de datos
    MOV     DS,AX                                           ;Peticion
    
    ;=====================================================================================================================
    
    MOV AH,09
    MOV DX,OFFSET msj1                                      ;Mostrar el mensaje 1
    INT 21H
  
    LEA SI,vec1                                             ;Cargamos en el registro de la primera cadena

    pedir1:                                                 ;Inicia ciclo pedir1
    MOV AH,01H                                              ;Pedir un car?cter
    INT 21H
    MOV [SI],AL                                             ;Se guarda en el registro indexado al espacio asignado para la cadena
    INC SI
    CMP AL,0DH                                              ;Se cicla hasta que se digite un Enter
    JA pedir1
    JB pedir1

    MOV AH,09
    MOV DX,OFFSET msj2                                      ;Imprime el mensaje  2
    INT 21H
    LEA SI,vec2                                             ;Se carga en SI el espacio 2


    pedir2:                                                 ;Inicia ciclo pedir2
    MOV AH,01H                                              ;Mismo procedimiento que en el ciclo pedir1
    INT 21H
    MOV [SI],AL                                             ;Se guarda en el registro indexado al espacio asignado para la cadena
    INC SI
    CMP AL,0DH                                              ;Se cicla hasta que se digite un Enter
    JA pedir2
    JB pedir2
   
    MOV CX,50                                               ;Determina la cantidad de datos a leer/comparar
    MOV AX,DS                                               ;Mueve el segmento datos a AX
    MOV ES,AX                                               ;Mueve los datos al segmento extra


    compara:                                                ;Inicia ciclo compara
    LEA SI,vec1                                             ;Carga en SI la cadena que contiene el espacio 1
    LEA DI,vec2                                             ;Carga en DI la cadena que contiene el espacio 2
    REPE CMPSB                                              ;Compara las dos cadenas
    JNE diferente                                           ;Si no fueron iguales
    JE iguales                                              ;Si fueron iguales
  

    iguales:                                                ;Inicia proceso de cadenas iguales
    MOV AH,09
    MOV DX,OFFSET msj3                                      ;Imprime el mensaje 3 que son iguales y finaliza el programa.
    INT 21H
    MOV AH,04CH
    INT 21H

    
    diferente:                                              ;Inicia proceso de cadenas diferentes
    MOV AH,09
    MOV DX,OFFSET msj4                                      ;Imprime el mensaje 4 que son diferentes y finaliza el programa.
    INT 21H
    MOV AH,04CH
    INT 21H
    
    ;=====================================================================================================================
    
    MOV     AH,4CH                                          ;Peticion de terminar
    INT     21H                                             ;LLamada al sistema

Codigo ENDS                                                 ;Termina el codigo

END Inicio                                                  ;Termina el programa