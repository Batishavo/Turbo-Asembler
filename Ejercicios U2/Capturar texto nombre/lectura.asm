;=========================================================================================
;ITSUR | Ing. en Sistemas Computacionales
;LENGUAJES DE INTERFAZ | S66A
;Profesor: Jorge Guzman Ramos
;Alumno: Jorge Luis Medina Gaytan - S14120040
;Programa: Captura de texto
;=========================================================================================

Pila SEGMENT Stack                                              ;Define la Pila

    DW 64 Dup(' ')                                              ;Espacio para la Pila

Pila ENDS                                                       ;Termina la Pila?


Datos SEGMENT                                                   ;Define segmento de datos
    
    Etiqueta LABEL BYTE                                         ;Define etiqueta
    Maxlong DB 30                                               ;Define maximo de caracteres
    Realong DB ?                                                ;Define entrada
    Nombre DB 31 DUP(' ')                                       ;Pila para texto
    Peticion DB 10,13,"Nombre:","$"                             ;Primer mensaje
    Salto db 10,13,"Tu Nombre es:","$"                          ;Segundo mensaje

Datos ENDS                                                      ;Termina segmento de datos




codigo SEGMENT                                                  ;Define segmento de codigo

    Assume SS:Pila,DS:Datos,CS:CODIGO                           ;Enlazar la Etiqueta con el registro

    Inicio:                                                     ;Declara inicio de ejecucion

    MOV AX,Datos                                                ;Direccionamiento
    MOV DS,AX                                                   ;Direccionamiento
    MOV AH,09H                                                  ;Peticion de despliegue
    MOV DX,OFFSET Peticion                                      ;Direccionar mensaje
    INT 21H                                                     ;Llamada al sistema
    
    MOV AH,0AH                                                  ;Direccionar entrada de texto
    LEA DX,Etiqueta                                             ;Entrada de texto
    INT 21H                                                     ;Llamada al sistema
    MOV BH,00                                                   ;Direccionamiento
    MOV BL,Realong                                              ;Lectura
    MOV Nombre[BX+1],"$"                                        ;Guardar cadena ingresada

    MOV AH,09H                                                  ;Peticion de despliegue 
    LEA DX,Salto                                                ;Mostrar mensaje
    INT 21H                                                     ;Llamada al sistema

    MOV AH,09H                                                  ;Peticion de despliegue
    LEA DX,Nombre                                               ;Mostrar texto ingresado
    INT 21H                                                     ;Llamada al sistema

    MOV AH,4CH                                                  ;Peticion de terminar
    INT 21H                                                     ;Llamada al sistema

Codigo ENDS                                                     ;Termina el codigo
END Inicio                                                      ;Termina el Programa
    
    
    
    
    