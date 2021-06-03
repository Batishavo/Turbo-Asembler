;=========================================================================================
;ITSUR | Ing. en Sistemas Computacionales
;LENGUAJES DE INTERFAZ 
;Profesor: Jorge Guzman Ramos
;Alumno: Romero Mart?nez Carlos Ra?l - S17120220
;Programa: Mostrar mensaje
;=========================================================================================

Pila SEGMENT STACK                                          ;Define la pila
    DW 64 DUP (' ')                                         ;Espacio para la pila
Pila ENDS                                                   ;Termina la pila

Datos SEGMENT                                               ;Define sgmento de datos
    Saludo DB 10,3,"Que onda morros?",10,3,"$"              ;Define constante
    Datos ENDS                                              ;Termina segmento

    Codigo SEGMENT                                          ;Define segmento de codigo 
        ASSUME SS:Pila, DS:Datos, CS:Codigo                 ;EN lasar los registros con los nombres dados               
    
    Inicio:                                                 ;Inicica cesion inicio
    MOV     AX,Datos                                        ;Direcciona el segmento de datos
        MOV     DS,AX                                       ;El area de datos
    MOV     AH,09H                                          ;Peticion de despliegue
    MOV     DX,Offset Saludo                                ;Direccionar el mensaje
    INT     21H                                             ;Llamada al sistema
    MOV     AH,4CH                                          ;Peticion de terminhar
    INT     21H                                             ;LLamada al sistema
Codigo ENDS                                                 ;Termina el codigo
END Inicio                                                  ;Termina el programa



