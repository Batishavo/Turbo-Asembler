;=========================================================================================
;ITSUR | Ing. en Sistemas Computacionales
;LENGUAJES DE INTERFAZ | S66A
;Profesor: Jorge Guzman Ramos
;Alumno: Jorge Luis Medina Gaytan - S14120040
;Programa: Conversor ASCII a Binario y Binario a ASCII
;=========================================================================================

Pila SEGMENT Stack                                              ;Define la Pila

    DW 64 Dup(' ')                                              ;Espacio para la Pila

Pila ENDS                                                       ;Termina la Pila?


Datos SEGMENT                                                   ;Define segmento de datos
    
    ASCII       DB "1234"                                       ;Texto de entrada
    Binario     DW 0                                            ;Espacio para datos
    Long        DW 4                                            ;Espacio para datos
    Diez        DW 1                                            ;Espacio para datos
    
    ASCII2      DB 4 DUP (' ')                                  ;Espacio
                DB "$"

                
Datos ENDS                                                      ;Termina segmento de datos




codigo SEGMENT                                                  ;Define segmento de codigo

    Assume SS:Pila,DS:Datos,CS:CODIGO                           ;Enlazar la Etiqueta con el registro

    Inicio:                                                     ;Declara inicio de ejecucion

    
    ;***************************************************************************************************CONVERSION A BINARIO
    MOV AX,Datos                                                ;Direccionamiento
    MOV DS,AX                                                   ;Direccionamiento
    MOV CX,4                                                    ;Divisor       
    LEA SI,ASCII+3                                              ;Lectura de texto
    MOV BX,10                                                   ;Multiplicador
    
    Ciclo1:                                                     ;Declara inicio de ciclo
    
    MOV AL,[SI]                                                 ;Selecciona el ultimo caracter(4)
    AND AX,000FH                                                ;Borra la zona 3
    MUL Diez                                                    ;Multiplica por el valor posiscional
    ADD Binario,AX                                              ;Acumula el binario
    MOV AX,Diez                                                 ;Calcula el siguiente
    MUL BX                                                      ;Valor posicional
    MOV Diez,AX                                                 ;Guarda el valor
    DEC SI                                                      ;Apunta al caracter anterior
    LOOP Ciclo1                                                 ;Repite ciclo / Fin de ciclo
    ;***************************************************************************************************CONVERSION A BINARIO
    
    
    
    ;***************************************************************************************************CONVERSION A ASCII
    MOV CX,10                                                   ;Direccionamiento     
    LEA SI,ASCII2+3                                             ;Lectura de texto
    MOV AX,Binario                                              ;Valor binario
    
    Ciclo2:                                                     ;Declara inicio de ciclo
    
    CMP AX,CX                                                   ;Numero menor a 10
    JB  Salir                                                   ;Saltar al ciclo 3
    XOR DX,DX                                                   ;Limpiar cociente superior
    DIV CX                                                      ;Divide entre 10
    OR  DL,30H
    MOV [SI],DL                                                 ;Almacena caracter ASCII
    DEC SI                                                      
    JMP Ciclo2
    ;***************************************************************************************************CONVERSION A ASCII
    
    
    
    Salir:
    
    OR  AL,30H                                                  ;Almacena ultimo cociente
    MOV [SI],AL                                                 ;Caracter ASCII
    MOV AH,09H                                                  ;Salida
    LEA DX,ASCII2                                               ;Lectura de ASCII2
    INT 21H

    MOV AH,4CH                                                  ;Peticion de terminar
    INT 21H                                                     ;Llamada al sistema

Codigo ENDS                                                     ;Termina el codigo
END Inicio                                                      ;Termina el Programa