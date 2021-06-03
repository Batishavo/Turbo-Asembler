;=========================================================================================
;ITSUR | Ing. en Sistemas Computacionales
;LENGUAJES DE INTERFAZ | S66A
;Profesor: Jorge Guzman Ramos
;Alumno: Jorge Luis Medina Gaytan - S14120040
;Programa: Localizar y cambiar letra
;=========================================================================================

Pila SEGMENT STACK                                          ;Define la pila
    
    DW 64 DUP (' ')                                         ;Espacio para la pila

Pila ENDS                                                   ;Termina la pila


Datos SEGMENT                                               ;Define sgmento de datos
    
    Mensaje DB 10,13,"Exo ex todo amigox",10,13,"$"         ;Define texto de entrada
    
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
   
    Remplaza:                                               ;Ciclo de comparacion
   
    MOV AH,[BX]                                             ;Declara espacio
    CMP AH,78H                                              ;Compara: x
    JB Brincala                                             ;Llama a un ciclo
    XOR AH,00001011B                                        ;Cambia [x] por [s] mediante la operacion XOR entre binarios
    MOV [BX],AH                                             ;Direcciona
    
    
    Brincala:                                               ;Ciclo de impresion
    
    INC BX                                                  ;Incremento
    LOOP Remplaza                                           ;Realiza un ciclo
    DISPLAY Mensaje                                         ;Muestra mensaje corregido
    MOV AX,4C00H                                            ;Direcciona
    INT 21H                                                 ;Termina programa
    
  
    
    ;=====================================================================================================================
    
    MOV     AH,4CH                                          ;Peticion de terminar
    INT     21H                                             ;LLamada al sistema

Codigo ENDS                                                 ;Termina el codigo

END Inicio                                                  ;Termina el programa














