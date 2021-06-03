;=========================================================================================
;ITSUR | Ing. en Sistemas Computacionales
;LENGUAJES DE INTERFAZ | S66A
;Profesor: Jorge Guzman Ramos
;Alumno: Jorge Luis Medina Gaytan - S14120040
;Programa: Comparaciones y cambio de minusculas a MAYUSCULAS
;=========================================================================================

Pila SEGMENT STACK                                          ;Define la pila
    
    DW 64 DUP (' ')                                         ;Espacio para la pila

Pila ENDS                                                   ;Termina la pila


Datos SEGMENT                                               ;Define sgmento de datos
    
    Mensaje DB 10,13,"Cambio a mayusculas",10,13,"$"         ;Define texto de entrada
    
Datos ENDS                                                  ;Termina segmento

    
Codigo SEGMENT                                              ;Define segmento de codigo 
        
    ASSUME SS:Pila, DS:Datos, CS:Codigo                     ;Asignar datos;
    
    Inicio:                                                 ;Inicia el programa
    
    MOV     AX,Datos                                        ;Direcciona el segmento de datos
    MOV     DS,AX                                           ;Peticion
    
    ;=====================================================================================================================
    
    
    DISPLAY MACRO MSG                                       ;Declara el macro
 
        MOV AH,09H
        MOV DX,Offset MSG
        INT 21H    
        
    ENDM                                                    ;Cierra el macro
   
    DISPLAY Mensaje                                         ;Muestra el mensaje
    LEA BX,Mensaje                                          ;Lee el mensaje   
    MOV CX,21
   
    Mayusc:                                                 ;Ciclo de comparaci?n
   
    MOV AH,[BX]                                             ;Declara espacio
    CMP AH,61H                                              ;Compara: a
    JB Brincala                                             ;Llama a un ciclo
    CMP AH,7AH                                              ;Compara: z
    JA Brincala                                             ;Llama a un ciclo
    AND AH,11011111B                                        ;Cambia a mayusculas
    MOV [BX],AH                                             ;Direcciona
    
    
    Brincala:                                               ;Ciclo de impresion
    
    INC BX                                                  ;Incremento
    LOOP Mayusc                                             ;Realiza un ciclo
    DISPLAY Mensaje                                         ;Muestra mensaje
    MOV AX,4C00H                                            ;Direcciona
    INT 21H                                                 ;Termina programa
    
    
    
    
    
    
    
    ;=====================================================================================================================
    
    MOV     AH,4CH                                          ;Peticion de terminar
    INT     21H                                             ;LLamada al sistema

Codigo ENDS                                                 ;Termina el codigo

END Inicio                                                  ;Termina el programa
