;=========================================================================================
;ITSUR | Ing. en Sistemas Computacionales
;LENGUAJES DE INTERFAZ 
;Profesor: Jorge Guzman Ramos
;Alumno: Romero Martinez Carlos Raul - S17120220
;Programa: Tabla ASCI, cambio de color y agrandar el cursor
;=========================================================================================

Pila SEGMENT STACK                                          ;Define la pila
    DW 64 DUP (' ')                                         ;Espacio para la pila
Pila ENDS                                                   ;Termina la pila

Datos SEGMENT                                               ;Define sgmento de datos
    Saludo DB "$"                                           ;Define constante
     Char DB 00,"$"                                         ;Esto leera solo un car?cter, los ceros limpian, es como inicializarla
    Datos ENDS                                              ;Termina segmento

    Codigo SEGMENT                                          ;Define segmento de codigo 
        ASSUME SS:Pila, DS:Datos, CS:Codigo                 ;EN lasar los registros con los nombres dados
    
    ;Poner colores
    Inicio:                                                     ;Inicica cesion inicio
    mov ah,06h                                              ;Para manipular el comportamiento de la pantalla en blanco
    mov bH,2DH                                               ;indica donde se va a posicionar el cursor
    mov cx,0000h                                            ;Pixel donde se va a empesar a pintar la pantalla
    mov dx,184fh                                            ;Donde se termina de pintar
    int 10h                                                 ;Para manipular el video, usando directamente la BIOS
    
    MOV AX,DATOS                                             ;Direcciona
    MOV DS,AX                                                ;El area de datos
    LEA DX,saludo                                              ;Se escribe el mensaje
    MOV AH,9H                                                  ;Despliega pantalla
    INT 21H                                                   ;Llamar al sistema
  
    Mov AH,01H                                                  ;Agrandar el cursor
    Mov CX,000EH                                                 ;De 00 a 14
    INT 10H                                                     ; Llamada a BIOS.
    

    Mov CX,256                                                  ; Repeticiones del ciclo
    LEA DX,Char                                                 ;Direcciona la variable en  DX
    Ciclo :                                                     ;Inicio del ciclo
        Mov    AH,09H                                            ;Se usa apra desplegar en pantalla lo que direcciona DX
        INT     21H                                                 ; Llamada al sistema.
        INC Char                                                    ;Incrementa
    LOOP Ciclo                                                  ;Regresa al siclo

    MOV AH,4CH                                                  ;Termina el programa
    INT 21H                                                     ;Llamada al S.O

    
Codigo ENDS                                                 ;Termina el codigo
END Inicio                                                  ;Termina el programa



