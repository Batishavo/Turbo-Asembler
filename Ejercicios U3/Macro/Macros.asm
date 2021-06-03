;=========================================================================================
;ITSUR | Ing. en Sistemas Computacionales
;LENGUAJES DE INTERFAZ | S66A
;Profesor: Jorge Guzman Ramos
;Alumno: Jorge Luis Medina Gaytan - S14120040
;Programa: Examen U3
;=========================================================================================

Pila SEGMENT STACK                                          ;Define la pila
    
    DW 64 DUP (' ')                                         ;Espacio para la pila

Pila ENDS                                                   ;Termina la pila

Datos SEGMENT                                               ;Define sgmento de datos
    
    Saludo1 DB "Texto 1 Con macro","$"          ;Define constante

Datos ENDS                                                  ;Termina segmento


Metodo MACRO Par1                                           ;Declaraci?n del Macro
    
    MOV     AH,09H                                          ;Peticion de despliegue
    MOV     DX,Offset Par1                                  ;Direccionar el mensaje
    INT     21H                                             ;Llamada al sistema

ENDM                                                        ;Cierre del Macro 



    
Codigo SEGMENT                                              ;Define segmento de codigo 
        
    ASSUME SS:Pila, DS:Datos, CS:Codigo                     ;Asignar datos;
    
    Inicio:                                                 ;Inicia el programa
    
    MOV     AX,Datos                                        ;Direcciona el segmento de datos
    MOV     DS,AX                                           ;Peticion
    
    
    CALL DESPLEGAR                                          ;Llama al proceso desplegar
    
    
    DESPLEGAR PROC NEAR                                     ;Inicia proceso DESPLEGAR
    
    Metodo  Saludo1                                         ;Llama al macro
    MOV     AH,4CH                                          ;Peticion de terminhar
    INT     21H                                             ;LLamada al sistema
    
    DESPLEGAR ENDP                                          ;Termina proceso DESPLEGAR
    

Codigo ENDS                                                 ;Termina el codigo

END Inicio                                                  ;Termina el programa