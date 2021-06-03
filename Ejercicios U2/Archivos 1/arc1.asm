;=========================================================================================
;ITSUR | Ing. en Sistemas Computacionales
;LENGUAJES DE INTERFAZ | S66A
;Profesor: Jorge Guzman Ramos
;Alumno: Jorge Luis Medina Gaytan - S14120040
;Programa: Archivos 1
;=========================================================================================

PILA SEGMENT                                                ;SE DECLARA EL SEGMENTYO DE PILA
    
    DW 64 DUP('0')                                          ;SE LE ASIGNA UN TAMNA?O
    
PILA ENDS                                                   ;TERMINA LA DECLARACION DEL SEGMENTO DE PILA
    
    DATOS SEGMENT                                           ;COMIENZA EL SEGMENTO DE DATOS
        NAMEPAR LABEL BYTE                                  ;SE DECLARA UNA ETIQUETA
        MAXLEN DB 30                                        ;LONGITUD MAXIMA
        NAMELEN DB ?                                        ;LONGITUD DE LO TECLEADO
        NAMEREC DB 30 DUP(' ') 0DH, 0AH                     ;DATOS TECLEADOS
        ERRCDE DB 00                                        ;SE DECLARA UNA VARIABLE CON VALOR DE 0
        HANDLE DW ?                                         ;SE DECLARA EL MANEJADOR DE ARCHIVO
        PATHNAM DB 'R:\NAMEFILE.DAT',0                      ;RUTA DEL ARCHIVO
        PROMPT DB 'ESCRIBE UN NOMBRE',10,13,"$"             ;PIDE UN NOMBRE
        ROW DB 01                                           ;RENGLON 1
        OPNMSG DB '*** OPEN ERROR ***', 0DH, 0AH            ;MENSAJE DE ERROR AL ABRIR
        WRTMSG DB '*** WRITE ERROR ***', 0DH, 0AH           ;MENSAJE DE ERROR AL ESCRIBIR
        DATOS ENDS                                          ;SE TERMINA EL SEGMENTO DE DATOS
        
        CODIGO SEGMENT                                      ;COMIENZA EL SEGMENTO DE CODIGO
            ASSUME SS: PILA,DS: DATOS,CS: CODIGO
            INICIO PROC FAR                                 ;SE INICIA EL METODO DE INICIO
            MOV AX,DATOS                                    ;DIRECCIONAR EL SEGMENTO
                MOV DS,AX                                   ;DE DATOS
                MOV ES,AX                                   ;TAMBIEN EN CADENAS
                MOV AX,0600H                                ;PETICION DE LIMPIAR PANTALLA
                CALL Q10SCR                                 ;LIMPIAR LA PANTALLA
                CALL Q20CURS                                ;COLOCA EL CURSOR
                CALL C10CREA                                ;CREA EL ARCHIVO
                CMP ERRCDE,00                               ;VERIFICAR QUE NO HUBO ERROR
                JZ A20LOOP                                  ;SI NO, CONTINUAR
                JMP A90                                     ;DE AQUI SALTA AL METODO A90
                
                A20LOOP                                     ;INICIO DEL METODO
                CALL D10PROC                                ;MANDA LLAAMAR AL METODO D10PROC
                CMP NAMELEN,00                              ;COMPARA SI LA VARIABLE ESTA EN 0
                JNE A20LOOP                                 ;SI NO SON IGUALES, SE LA BRINCA
                CALL G10CLSE                                ;VA A CERRAR EL ARCHIVO
                
                A90:MOV AX,4C00H                            ;TERMINA
                INT 21H                                     ;EL PROGRAMA
            CODIGO ENDS
            
                                ;CREAR ARCHIVO EN DISCO
                                ;----------------------
            
            C10CREA PROC NEAR
            MOV AH, 3CH                                     ;SE AGFREGA EL AREA 3
            MOV CX,00                                       ;MUEVE 0 A LA VARIABLE CX
            LEA DX,PATHNAM                                  ;ENVIA LA DIRECCION DONDE SE ALMACENARA EL
                                                            ;ARCHIVO AL REGISTRO DX
    
            INT 21H                                         ;REALIZA LA ANTERIOR PETICION
            JC C20                                          ;SI ES CERO SALTA AL METODO C20
            MOV HANDLE,AX                                   ;LO QUE TIENE EL REGISTRO AX LO PASARA A LA VARIABLE QUE NO SE SABIA SU TAMA?O
            RET                                             ;LO REPETIRA

    C20:
    LEA DX,OPNMSG                                           ;DIRECCIONA MENSAJE DE ERROR
    CALL X10ERR                                             ;VA A MANEJAR EL ERROR
    RET                                                     ;LO REPETIRA
    C10CREA ENDP
    
                    ;ACEPTA ENTRADA
                    ;--------------
    
    D10PROC PROC NEAR                                       ;INICIA EL PROCEDIMIENTO
    MOV AH,40H                                              ;MUEVE LA PETICION AL REGISTRO AH
    MOV BX,01                                               ;SE PASA 1 AL REGISTRO BX
    MOV CX,06                                               ;SE ENVIARA UN 06 AL REGISTRO CX
    LEA DX,PROMPT                                           ;SE OBTIENE LO TECLEADO
    INT 21H                                                 ;LLAMADA AL SISTEMA
    MOV AH,0AH                                              ;PETICION DE CAPTURA
    LEA DX,NAMEPAR                                          ;DIRECCIONAR EL AREA DE CAPTURA
    INT 21H                                                 ;PETICION AL SISTEMA
    CMP NAMELEN,00                                          ;SI NO SE TECLEO UN DATO
    JZ D90                                                  ;SALIR
    MOV AL,20H                                              ;COLOCAR UN BLANCO EN AL
    SUB CH,CH                                               ;BORRAR CH
    MOV CL,NAMELEN                                          ;CAPTURA LA LONGITUD DE LO TECLEADO
    LEA DI,NAMEREC                                          ;DIRECCIONAR LO TECLEADO
    ADD DI,CX                                               ;SE SUMA LO QUE TIENE EL REGISTRO CX AL REGISTRO DI
    NEG CX                                                  ;CAMBIA A NEGATIVO EL REGISTRO CX
    ADD CX,30                                               ;LO SUMA CON EL 30
    REP STOSB                                               ;REPETIRA DE NUEVO ESO
    CALL F10WRIT                                            ;MANDA LLAMAR ESTE METODO
    CALL E10SCRL                                            ;MANDA LLAMAR ESTE METODO
    
    D90:
    RET
    D10PROC ENDP
    
                    ;VERIFICA EL RECORRIDO
                    ;---------------------
    
    E10SCRL PROC NEAR                                       ;INICIA EL PROCEDIMIENTO
    CMP ROW,18                                              ;COMPARA EL 18 CON EL RENGLON QUE VALE 1
    JAE E10                                                 ;COMPARA SI EL METODO SI ES MAYOR O IGUAL
    INC ROW                                                 ;INCREMENTARA EL RENGLON
    JMP E90                                                 ;SALTARA EL METODO E90 SI SE CUMPLE LA CONDICION
    
    E10:
    MOV AX,0601H
    CALL Q10SCR                                             ;MANDA LLAMAR Q10SCR
    
    E90: 
    CALL Q20CURS                                            ;MANDA LLAMAR Q20CURS
    RET                                                     ;REPETIR
    E10SCRL ENDP
    
 
                    ;ESCRIBE REGISTRO EN DISCO
                    ;-------------------------
                                    
    F10WRIT PROC NEAR                                       ;INICIA EL PROCEDIMIENTO
    MOV AH, 40H                                             ;MUEVE EL REGISTRO AL REGISTRO AH
    MOV BX, HANDLE                                          ;LA CADENA HAY AH? ALMAENADA SE MOVERA AL REGISTRO BX
    MOV CX, 32                                              ;MUEVE EL 32 AL CX
    LEA DX, NAMEREC                                         ;LA CADENA QUE ANTERIORMENTE SE HABIA OBTENIDO, SE TRANSFIERE AL REGISTRO DX
    INT 21H                                                 ;SE REALIZA LA PETICION ANTERIOR
    JNC F20                                                 ;SI NO ES CERO, SALTARA AL METODO F20
    LEA DX, WRTMSG                                          ;ENVIARA EL MENSAJE DE ERROR AL ESCRIBIR AL REGISTRO DX
    CALL X10ERR                                             ;MANDA LLAMAR AL METODO X10ERR
    MOV NAMELEN, 00                                         ;LIMPIA LA VARIABLE
    F20:
    RET
    F10WRIT ENDP
                                    
                    ;CIERRA ARCHIVO EN DISCO
                    ;-----------------------

    G10CLSE PROC NEAR                                       ;INICIA EL PROCESO
    MOV NAMEREC, 1AH                                        ;LE ASIGNA ESTA INFORMACION A LA VARIABLE
    CALL F10WRIT                                            ;MANDA LLAMAR EL METODO F10WRIT
    MOV AH, 3EH                                             ;MUEVE EL REGISTRO 3EH AL REGISTRO AH
    MOV BX, HANDLE                                          ;LA CADENA SE MUEVE AL REGISTRO BX
    INT 21H                                                 ;SE REALIZA LA PETICION ANTERIOR
    RET                                                     ;REPETIRA
    G10CLSE ENDP    
                                    
                   ;RECORRE LA PANTALLA
                   ;-------------------
                                    
    Q10SCR PROC NEAR                                        ;INICIA EL PROCESO
    MOV BH, 1EH                                             ;TRANSFIERE EL REGISTRO 1EH AL REGISTRO BH
    MOV CX, 0000                                            ;LIMPIA EL REGISTRO CX
    MOV DX, 184FH                   
    INT 10H                                                 ;REALIZA LA PETICION Y EJECUTA
    RET                                                     ;REPETIRA
    Q10SCR ENDP
                                    
                    ;COLOCA EL CURSOR
                    ;----------------
                                    
    Q20CURS PROC NEAR
    MOV AH, 02H                                             ;MUEVE EL REGISTRO 02H AL REGISTRO AH
    MOV BH, 00                                              ;PONE EN 0 EL REGISTRO BH
    MOV DH, ROW                                             ;ENVIA EL VALOR DEL RENGLON AL REGISTRO DH
    MOV DL, 00                                              ;LIMPIA EL REGISTRO DL
    INT 10H                                                 ;REALIZA LA PETICION DE LA INSTRUCCION ANTERIOR Y EJECUTA
    RET                                                     ;REPETIR
    Q20CUR ENDP
                   ;DESPLIEGA MENSAJE DE ERROR EN DISCO
                   ;-----------------------------------

    X10ERR PROC NEAR                                        ;INICIA EL PROCESO
    MOV AH, 40H                                             ;TRANSFIERE EL REGISTRO 40H AL REGISTRO AH
    
    
    MOV BX,01                                               ;ENVIA EL VALOR DE 1 AL REGISTRO BX
    MOV CX,21                                               ;TRANSFIERE EL 21 AL VALOR CX
    INT 21H                                                 ;REALIZA LA PETICION ANTERIOR
    MOV ERRCDE,01                                           ;MUEVE EL UNO, A LA VARIABLE ERRCDE
    RET                                                     ;REPITE
    X10ERR ENDP                                             ;TERMINA ESTE METODO
    
END INICIO
            
            
