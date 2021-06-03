Pila SEGMENT Stack                                              ;Define la Pila

    DW 64 Dup(' ')                                              ;Espacio para la Pila

Pila ENDS                                                       ;Termina la Pila?


Datos SEGMENT                                                   ;Define segmento de datos
    
    Dias      DB "Domingo $ ", "Lunes $ ", "Martes $ " 
              DB "Miercoles $ ", "Jueves $ ", "Viernes $ "
              DB "Sabado $ "                                    ;Tabla dias
           
    Meses     DB "Enero $ ", "Febrero $ ", "Marzo $ "
              DB "Abril $ ", "Mayo $ ", "Junio $ ", "Julio $ "
              DB "Agosto $ ", "Septiembre $ ", "Octubre $ "
              DB "Noviembre $ ", "Diciembre $ "                 ;Tabla meses

    Mensaje1  DB "Fecha del sistema: $"    
    Mensaje2  DB "00/00/0000$"                                  ;Formato de fecha
           
                
Datos ENDS                                                      ;Termina segmento de datos




codigo SEGMENT                                                  ;Define segmento de codigo

    Assume SS:Pila,DS:Datos,CS:CODIGO                           ;Enlazar la Etiqueta con el registro

    Inicio:                                                     ;Declara inicio de ejecucion

    
    MOV AX, Datos                                               ; initialize DS
    MOV DS, AX

    LEA BX, Mensaje2                                            ; BX=offset address of string TIME

    CALL GET_TIME                                               ; call the procedure GET_TIME

    LEA DX, Mensaje1                                            ; DX=offset address of string PROMPT
    MOV AH, 09H                                                 ; print the string PROMPT
    INT 21H                      

    LEA DX, Mensaje2                                            ; DX=offset address of string TIME
    MOV AH, 09H                                                 ; print the string TIME
    INT 21H                      

    MOV AH, 4CH                                                 ; return control to DOS
    INT 21H
    
    
    
    
    
    GET_TIME PROC
    ; this procedure will get the current system time 
    ; input : BX=offset address of the string TIME
    ; output : BX=current time

    PUSH AX                       ; PUSH AX onto the STACK
    PUSH DX                       ; PUSH CX onto the STACK 

    MOV AH, 2AH                   ; get the current system time
    INT 21H                       

    MOV AL, DL                    ; set AL=CH , CH=hours
    CALL CONVERT                  ; call the procedure CONVERT
    MOV [BX], AX                  ; set [BX]=hr  , [BX] is pointing to hr
                                  ; in the string TIME

    MOV AL, DH                    ; set AL=CL , CL=minutes
    CALL CONVERT                  ; call the procedure CONVERT
    MOV [BX+3], AX                ; set [BX+3]=min  , [BX] is pointing to min
                                  ; in the string TIME
                                           
    MOV AL, CX                    ; set AL=DH , DH=seconds
    CALL CONVERT                  ; call the procedure CONVERT
    MOV [BX+6], AX                ; set [BX+6]=min  , [BX] is pointing to sec
                                  ; in the string TIME
                                                      
    POP DX                        ; POP a value from STACK into CX
    POP AX                        ; POP a value from STACK into AX

    RET                           ; return control to the calling procedure
   GET_TIME ENDP                  ; end of procedure GET_TIME
    
    
    
   
   CONVERT PROC 
    ; this procedure will convert the given binary code into ASCII code
    ; input : AL=binary code
    ; output : AX=ASCII code

    PUSH SI                       ; PUSH DX onto the STACK 

    MOV AH, 0                     ; set AH=0
    MOV DL, 10                    ; set DL=10
    DIV DL                        ; set AX=AX/DL
    OR AX, 3030H                  ; convert the binary code in AX into ASCII

    POP SI                        ; POP a value from STACK into DX 

    RET                           ; return control to the calling procedure
   CONVERT ENDP                   ; end of procedure CONVERT
    
    
    
    
    

          
    
    
    
    
    
    
    
    

    MOV AH,4CH                                                  ;Peticion de terminar
    INT 21H                                                     ;Llamada al sistema

Codigo ENDS                                                     ;Termina el codigo
END Inicio                                                      ;Termina el Programa
