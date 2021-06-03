;=========================================================================================
;ITSUR | Ing. en Sistemas Computacionales
;LENGUAJES DE INTERFAZ | S66A
;Profesor: Jorge Guzman Ramos
;Alumno: Jorge Luis Medina Gaytan - S14120040
;Programa: Tamanio de cursor
;=========================================================================================

Pila SEGMENT STACK                                          ;Define la pila
    
    DW 64 DUP (' ')                                         ;Espacio para la pila

Pila ENDS                                                   ;Termina la pila

Datos SEGMENT                                               ;Define sgmento de datos
    
    Saludo DB 10,13,"Texto de prueba",10,13,"$"             ;Define constante
    
Datos ENDS                                                  ;Termina segmento

    
Codigo SEGMENT                                              ;Define segmento de codigo 
        
    ASSUME SS:Pila, DS:Datos, CS:Codigo                 
    
    Inicio:
    MOV     AX,Datos                                        ;Direcciona el segmento de datos
    MOV     DS,AX
    
   
    
    MOV     AH,01H
    MOV     CH,00
    MOV     CL,14
    INT     10H
    
    
    
    MOV     AH,09H                                          ;Peticion de despliegue
    MOV     DX,Offset Saludo                                ;Direccionar el mensaje
    INT     21H                                             ;Llamada al sistema
    
    MOV     AH,09H                                          ;Peticion de despliegue
    MOV     DX,Offset Saludo                                ;Direccionar el mensaje
    INT     21H                                             ;Llamada al sistema
    
    
    
    
    
    MOV     AH,4CH                                          ;Peticion de terminhar
    INT     21H                                             ;LLamada al sistema



Codigo ENDS                                                 ;Termina el codigo
END Inicio                                                  ;Termina el programa



