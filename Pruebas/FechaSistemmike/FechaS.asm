Pila SEGMENT Stack                                              ;Define la Pila

    DW 64 Dup(' ')                                              ;Espacio para la Pila

Pila ENDS                                                       ;Termina la Pila?


Datos SEGMENT                                                   ;Define segmento de datos        
             
    year      DW ?
    mens      DB '$' 
           
                
Datos ENDS                                                      ;Termina segmento de datos




codigo SEGMENT                                                  ;Define segmento de codigo

    Assume SS:Pila,DS:Datos,CS:CODIGO                           ;Enlazar la Etiqueta con el registro

    Inicio:                                                     ;Declara inicio de ejecucion

        MOV AX,Datos
        MOV DS,AX
    
    
       
        MOV AH,2AH                                              ;rutina para solicitar fecha
        INT 21H

        MOV year,CX

        MOV AH,09H
        LEA DX,mens
        INT 21H

        
        



;.........Mostrar anio.....................
        SUB AX,AX
        SUB BX,BX
        SUB DX,DX

        MOV AX,year
        MOV BX,0AH
        DIV BX
        OR DX,3030H
        
        PUSH DX
        SUB DX,DX
        DIV BX
        OR DX,3030H
        
        PUSH DX
        SUB DX,DX
        DIV BX
        OR DX,3030H
        
        PUSH DX
        OR AX,3030H
        
        PUSH AX
        POP DX
        MOV AH,02H
        INT 21H
        
        POP DX
        MOV AH,02H
        INT 21H
        
        POP DX
        MOV AH,02H
        INT 21H
        
        POP DX
        MOV AH,02H
        INT 21H
    
        
        
    MOV AH,4CH                                                  ;Peticion de terminar
    INT 21H                                                     ;Llamada al sistema

Codigo ENDS                                                     ;Termina el codigo
END Inicio    