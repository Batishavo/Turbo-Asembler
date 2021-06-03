;=========================================================================================
;ITSUR | Ing. en Sistemas Computacionales
;LENGUAJES DE INTERFAZ | S66A
;Profesor: Jorge Guzman Ramos
;Alumno: Jorge Luis Medina Gaytan - S14120040
;Programa: Texto con macros y ciclos
;=========================================================================================

Pila SEGMENT STACK                                          ;Define la pila
    
    DW 64 DUP (' ')                                         ;Espacio para la pila

Pila ENDS                                                   ;Termina la pila

Datos SEGMENT                                               ;Define sgmento de datos
    
    Saludo1 DB 10,13,"Texto 1 Sin macro",10,13,"$"          ;Define constante
    Saludo2 DB 10,13,"Texto 2 Sin macro",10,13,"$"          ;Define constante
    Saludo3 DB 10,13,"Texto 3 Con macro",10,13,"$"          ;Define constante
    Saludo4 DB 10,13,"Texto 4 Con ciclo",10,13,"$"          ;Define constante

Datos ENDS                                                  ;Termina segmento


Metodo MACRO Par1                                           ;Declaracion del Macro
    
    MOV     AH,09H                                          ;Peticion de despliegue
    MOV     DX,Offset Par1                                  ;Direccionar el mensaje
    INT     21H                                             ;Llamada al sistema

ENDM                                                        ;Cierre del Macro 



    
Codigo SEGMENT                                              ;Define segmento de codigo 
        
    ASSUME SS:Pila, DS:Datos, CS:Codigo                     ;Asignar datos;
    
    Inicio:                                                 ;Inicia el programa
    
    MOV     AX,Datos                                        ;Direcciona el segmento de datos
    MOV     DS,AX                                           ;Peticion
    
    ;=====================================================================================================================
    
    
    MOV     AH,09H                                          ;Peticion de despliegue
    MOV     DX,Offset Saludo1                               ;Direccionar el mensaje
    INT     21H                                             ;Llamada al sistema
    
    MOV     AH,09H                                          ;Peticion de despliegue
    MOV     DX,Offset Saludo2                               ;Direccionar el mensaje
    INT     21H                                             ;Llamada al sistema
    
    Metodo  Saludo3                                         ;Llama al macro
    
    MOV     CX,5                                            ;Cuenta las repeticiones
    Ciclo:                                                  ;Inicia ciclo
        MOV     AH,09H                                      ;Peticion de despliegue
        MOV     DX,Offset Saludo4                           ;Direccionar el mensaje
        INT     21H                                         ;Llamada al sistema
    LOOP Ciclo                                              ;Termina ciclo
    
    
    
    
    
    
    ;=====================================================================================================================
    
    MOV     AH,4CH                                          ;Peticion de terminhar
    INT     21H                                             ;LLamada al sistema

Codigo ENDS                                                 ;Termina el codigo

END Inicio                                                  ;Termina el programa













