;=========================================================================================
;ITSUR | Ing. en Sistemas Computacionales
;LENGUAJES DE INTERFAZ | S66A
;Profesor: Jorge Guzman Ramos
;Alumno: Jorge Luis Medina Gaytan - S14120040
;Programa: Procedientos y macros
;=========================================================================================

Pila SEGMENT STACK                                          ;Define la pila
    
    DW 64 DUP (' ')                                         ;Espacio para la pila

Pila ENDS                                                   ;Termina la pila

Datos SEGMENT                                               ;Define segmento de datos
    
    saludo  DB "Texto 1",10,13,"$"                          ;Define texto del mensaje
    saludo1 DB "Texto 2",10,13,"$"                          ;Define texto del mensaje
    saludo2 DB "Texto 3",10,13,"$"                          ;Define texto del mensaje
    
Datos ENDS                                                  ;Termina segmento de datos
   
    
Codigo SEGMENT                                              ;Define segmento de codigo

    ASSUME SS:Pila, DS:Datos, CS:Codigo                     ;Enlazar las etiquetas con los registros


  
    ;MACRO PARA DIRECCIONAR SEGMENTO DE DATOS
    Direccionar MACRO                                       ;Declara macro Direccionar
    
    MOV AX,Datos                                            ;Direcciona el segmento de datos
    MOV DS,AX
    
    ENDM                                                    ;Fin de macro
  
  
    ;MACRO PARA MANDAR MENSAJE
    Mensaje MACRO MSG                                       ;Declara macro Mensaje
    
    MOV AH,09H                                              ;Peticion de despliegue
    MOV DX,Offset MSG                                       ;Direccionar mensaje
    INT 21H                                                 ;Llamada al sistema
  
    ENDM                                                    ;Termina macro Mensaje
  
  
    ;MACRO CON MACRO
    macromacro MACRO                                        ;Declara macro macromacro
  
    Mensaje1 MACRO MSG                                      ;Declara macro Mensaje1
    
    MOV AH,09H                                              ;Peticion de despliegue
    MOV DX,Offset MSG                                       ;Direccionar mensaje
    INT 21H                                                 ;Llamada al sistema
    
    ENDM                                                    ;Termina macro Mensaje1
    
    Mensaje1 saludo                                         ;Llamada al macro Mensaje1
    Mensaje  saludo1                                        ;Llamada al macro Mensaje

    ENDM                                                    ;Termina macro macromacro
  
  
    ;MACRO CON PROCEDIMIENTO
    Macroconproc MACRO                                      ;Declara macro Macroconproc
   
    Mensaje Saludo                                          ;Llamada al macro Mensaje
    
    CALL imprimir                                           ;Llamada al procedimiento imprimir
    
    imprimir PROC NEAR                                      ;Declara procedimineto imprimir
    
    MOV AH,09H                                              ;Peticion de despliegue
    MOV DX,Offset saludo1                                   ;Direccionar mensaje
    INT 21H                                                 ;Llamada al sistema

    imprimir ENDP                                           ;Fin procedimiento imprimir
    
    ENDM                                                    ;Termina macro Macroconproc    
  

    ;PROCEDIMIENTO CON PROCEDIMIENTO
    procproc PROC NEAR                                      ;Declara procedimiento procproc
    
    MOV AH,09H                                              ;Peticion de despliegue
    MOV DX,Offset saludo                                    ;Direccionar mensaje
    INT 21H                                                 ;Llamada al sistema
   
    ;PROCEDIMIENTO
    subproc PROC NEAR                                       ;Declara procedimiento subproc
    
    MOV AH,09H                                              ;Peticion de despliegue
    MOV DX,Offset saludo1                                   ;Direccionar mensaje
    INT 21H                                                 ;Llamada al sistema
    RET
    
    subproc ENDP                                            ;Fin procedimiento subproc
    
    CALL subproc                                            ;Llamada al procedimiento subproc
    
    procproc ENDP                                           ;Fin procedimiento procproc
  
 
    ;PROCEDIMIENTO CON MACRO
    procmacro PROC NEAR                                     ;Declara procedimiento procmacro
    
    MOV AH,09H                                              ;Peticion de despliegue
    MOV DX,Offset saludo                                    ;Direccionar mensaje
    INT 21H                                                 ;Llamada al sistema
    
    ;MACRO
    Mensaje3 MACRO MSG                                      ;Declara macro Mensaje3                       
    
    MOV AH,09H                                              ;Peticion de despliegue
    MOV DX,Offset MSG                                       ;Direccionar mensaje
    INT 21H                                                 ;Llamada al sistema
    
    ENDM                                                    ;Fin macro Mensaje3
    
    Mensaje3 saludo2                                        ;Llamada al macro Mensaje3
    RET
    
    procmacro ENDP                                          ;Fin procedimiento procmacro
  
    
  

    Inicio:

    Direccionar                                             ;Macro para direccionar segmento de datos
    macromacro                                              ;Macro con macro
    Macroconproc                                            ;Macro con procedimiento
    CALL procproc                                           ;Procedimiento con prodecimiento
    CALL procmacro                                          ;Procedimiento con macro
  
  
    MOV AH,4CH                                              ;Peticion de terminar
    INT 21H                                                 ;LLamada al sistema


Codigo ENDS                                                 ;Termina el codigo
END Inicio                                                  ;Termina el programa






























