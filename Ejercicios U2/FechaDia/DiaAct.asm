;=========================================================================================
;ITSUR | Ing. en Sistemas Computacionales
;LENGUAJES DE INTERFAZ | S66A
;Profesor: Jorge Guzman Ramos
;Alumno: Jorge Luis Medina Gaytan - S14120040
;Programa: Fecha completa del sistema
;=========================================================================================

Pila SEGMENT Stack                                              ;Define la Pila

    DW 64 Dup(' ')                                              ;Espacio para la Pila

Pila ENDS                                                       ;Termina la Pila?



Datos SEGMENT                                                   ;Define segmento de datos
    
    year        DW  ?                                           ;Espacio para el anio
    space2      DB  '$'
    
    day         DB  ?                                           ;Espacio para el dia
    space1      DB  '$'
    
    month       DB  0                                           ;Espacio para el mes
    space3      DB  '$'
                
                
                
    Hoy         DB  "Hoy es ","$"                               ;Mensaje
    de          DB  " de ","$"                                  ;Mensaje
    
    Trece1      DB  13                                          ;Espacio en cadenas
    
    Dias        DB  "domingo $    ","lunes $      ","martes $     "
                DB  "miercoles $  ","jueves $     ","viernes $    "
                DB  "sabado $     "                                 ;Tabla dias
     
    Trece2      DB  13                                          ;Espacio en cadenas
    
    Meses       DB  "Enero$       ","Febrero$     ","Marzo$       "
                DB  "Abril$       ","Mayo$        ","Junio$       "
                DB  "Julio$       ","Agosto$      ","Septiembre$  "
                DB  "Octubre$     ","Noviembre$   ","Diciembre$   " ;Tabla meses  
    
Datos ENDS                                                      ;Termina segmento de datos



codigo SEGMENT                                                  ;Define segmento de codigo

    Assume SS:Pila,DS:Datos,CS:CODIGO                           ;Enlazar la Etiqueta con el registro

    Inicio:                                                     ;Declara inicio de ejecucion

    MOV AX,Datos                                                ;Direccionar datos
    MOV DS,AX                                                   ;Direccionar datos
    
    MOV AH,09H
    MOV DX,OFFSET Hoy                                           ;Mostrar segmento Hoy es
    INT 21H
    
    
    ;========================================[DIA NOMBRE]========================================
    
    MOV AH,2AH                                                  ;Solicitar fecha
    INT 21H                                                     ;Obtener fecha
    LEA SI,Dias                                                 ;Lectura tabla dias
    MUL Trece1                                                  ;Multiplicar espacio en cadenas
    ADD SI,AX                                                   ;Sumar registros
    MOV DX,SI                                                   ;Mover registros
    MOV AH,09H
    INT 21H                                                     ;Mostrar nombre del dia
    
    ;========================================[DIA NOMBRE]========================================
    
    
    ;========================================[DIA NUMERO]========================================
    
    MOV AH,2AH                                              
    INT 21H                                                     ;Solicitar fecha
   
    MOV day,DL                                                  ;Almacena numero del dia
    MOV AH,09H
    LEA DX,space1                                               ;Lectura del espacio de almacenado
    INT 21H
    
    SUB AX,AX
    SUB BX,BX
    SUB DX,DX

    MOV AL,day                                                  ;Mover dato del dia
    MOV BX,0AH
    DIV BL
    OR AX,3030H                                                 ;Conversion del dato binario

    MOV DX,AX
    MOV AH,02H
    INT 21H                                                     ;Mostrar primer digito del dia

    XCHG DH,DL
    MOV AH,02H
    INT 21H                                                     ;Mostrar segundo digito del dia
    
    ;========================================[DIA NUMERO]========================================
    
    
    ;========================================[MES NOMBRE]========================================
    
    MOV AH,09H
    MOV DX,OFFSET de                                            ;Mostrar segmento de
    INT 21H
    
    MOV AH,2AH                                                  ;Solicitar fecha
    INT 21H                                                     ;Obtener fecha
    MOV month,DH                                                ;Obtener numero del mes
    MOV AL,month                                                ;Almacenar mes
    DEC AL
    MUL Trece2                                                  ;Multiplicar espacio en cadena
    LEA DX,Meses                                                ;Lectura de la tabla de meses
    ADD DX,AX                                                   ;Suma de los registros
    MOV AH,09H
    INT 21H                                                     ;Mostrar nombre del mes
    
    MOV AH,09H
    MOV DX,OFFSET de                                            ;Mostrar segmento de
    INT 21H
    
    ;========================================[MES NOMBRE]========================================
    
    
    ;===========================================[ANIO]===========================================
    
    MOV AH,2AH                                              
    INT 21H                                                     ;Solicitar fecha
    
    MOV year,CX                                                 ;Almacenar el anio
    MOV AH,09H
    LEA DX,space2                                               ;Lectura del espacio de almacenado
    INT 21H
    
    SUB AX,AX
    SUB BX,BX
    SUB DX,DX

    MOV AX,year                                                 ;Mover dato del anio
    MOV BX,0AH
    DIV BX
    OR DX,3030H                                                 ;Conversion del dato en binario
        
    PUSH DX
    SUB DX,DX
    DIV BX
    OR DX,3030H                                                 ;Conversion del dato
        
    PUSH DX
    SUB DX,DX
    DIV BX
    OR DX,3030H                                                 ;Conversion del dato
        
    PUSH DX
    OR AX,3030H                                                 ;Conersion del dato
        
    PUSH AX
    POP DX
    MOV AH,02H
    INT 21H                                                     ;Mostrar primer digito del anio
        
    POP DX
    MOV AH,02H
    INT 21H                                                     ;Mostrar segundo digito del anio
        
    POP DX
    MOV AH,02H
    INT 21H                                                     ;Mostrar tercer digito del anio
        
    POP DX
    MOV AH,02H
    INT 21H                                                     ;Mostrar cuarto digito del anio
    
    ;===========================================[ANIO]===========================================
    
    
    
    MOV AH,4CH                                                  ;Peticion de terminar
    INT 21H                                                     ;Llamada al sistema

Codigo ENDS                                                     ;Termina el codigo
END Inicio                                                      ;Termina el Programa