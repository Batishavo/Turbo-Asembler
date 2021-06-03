;=========================================================================================
;ITSUR | Ing. en Sistemas Computacionales
;LENGUAJES DE INTERFAZ | S66A
;Profesor: Jorge Guzman Ramos
;Alumno: Jorge Luis Medina Gaytan - S14120040
;Programa: Archivos 2
;=========================================================================================

Pila Segment                                                ;Se declar el segmento de pila
    
    DW 64 DUP('0')                                          ;Se le asigna un tamanio
    
Pila ENDS                                                   ;Termina la declaracion del segmento de pila
    
Datos Segment                                               ;comienza el segmento de datos
    
    NAMEPAR LABEL BYTE                                      ;se declara una etiqueta
    MAXLEN DB 30                                            ;se agrega una variable con el tamanio de 30
    NAMELEN BD ?                                            ;se agreaga una variable con un valor no inicializado 
    NAMEREC DB 30 DUP ('') ODH, OAH                         ;nombre
    ERRCDE DB 00                                            ;se declara una variable con valor de 0
    HANDLE DW ?                                             ;se declara el manejador de archivo 
    PATHNAM DB 'R:\NAMEFILE.DAT', 0                         ;ruta del archivo
    PROMPT DB 'Escribe un nombre',10,13,"$"                 ;pide un nombre 
    ROW DB  01                                              ;renglon en uno
    OPNMSG DB '*** OPEN ERROR ***' ODH,OAH                  ;mensaje de error al abrir 
    WRTMSG DB '*** WRITE ERROR ***' ODH,0AH                 ;mensaje de error al escribir 
    Datos ENDS                                              ;se termina el segmento de datos
    
    Codigo Segment                                          ;comienza el segmento  de codigo
        
        ASSUME SS: Pila,DS:Datos,CS:Codigo
        
    INICIO PROC FAR                                         ;se inicia el emtodo inicio
    MOV AX,DATOS                                            ;mueve los datos el registro AX
    MOV DS,AX                                               ;del registro AX se transfiere al registro de memoria DS 
    MOV ES,AX                                               ;del registro AX tambien se transfiere al regsitro ES
    MOV AX,0600H                                            ; -----
    CALL Q10SCR                                             ;manda llamar
    CALL Q20CURS                                            ;manda llamar 
    CALL C10CREA                                            ;manda llamar
    CMP ERRCDE,00                                           ;compara si la variable se encuentra en 0
    JZ A20LOOP                                              ;si es igual a cero, salta metodo A20LOOP
    JMP A90                                                 ;de aqui salta al metodo A90
    
    A20LOOP:                                                ;inicio del metodo 
    CALL D10PROC                                            ;manda llamar el metodo D10PROC
    CMP NAMELEN, 00                                         ;compara si la variable esta en ceros
    JNE A20LOOP                                             ;si no son iguales, se va a este mismo metodo 
    CALL G10CLSE                                            ;manda llamar el metodo G10CLSE
    
    A90: MOV AX,4C00H                                       ; ---- 
    INT 21H                                                 ;realiza la peticion anterior 

    Codigo ENDS

                    ;CREAR ARCHIVO EN DISCO
                    ;---------------------
    
    C10CREA PROC NEAR
    MOV AH,3CH                                              ;se agrega al area 3
    MOV CX,00                                               ;mueve 0 a la variable CX
    LEA DX,PATHNAM                                          ;envia la direccion deonde se almacenara el archivo al registro DX
    INT 21H                                                 ;realiza la anterior peticion 
    JC C20                                                  ;si es cero salta al metodo C20
    MOV HANDLE,AX                                           ;lo que tiene el registro AX lo pasara a la variable que no se sabia su tamano 
    RET                                                     ;lo repetira
    
    C20:
    LEA DX,OPNMSG                                           ;de tal manera que fue igual a cero, envia un mensaje de arror al abrir
    CALL X10ERR                                             ;mandara llamar el metodo CALL X10ERR
    RET                                                     ;lo repetira
    C10CREA ENDP
        
                    ;ACEPTA ENTRADA 
                    ;--------------

    D10proc PROC NEAR                                       ;inicia el procedimiento
        MOV AH,40H                                          ;mueve la peticion al registro AH
        MOV BX,01                                           ;se pasa el 1 al registro BX
        MOV CX,06                                           ;se enviara un 06 al registro CX
        LEA DEX,PROMPT                                      ;se leera el mensaje del nombre en el registro DEX directamente
        INT 21H                                             ;se realizara la peticion anterior
        MOV AH,0AH                                          ;se movera el registro 0ah al registyr AH
        LEA DX, NAMEPAR                                     ;envia la etiqueta al registro DX
        INT 21H                                             ;se realiza la peticion anterior
        CMP NAMELEN,00                                      ;compara si lo que se introdujo es 0
        JZ D90                                              ;si es 0, va al metodo D90
        MOV AL,20H                                          ;se envia el registro 20H al registro AL
        SUB CH,CH                                           ;se resta lo que tiene la cadena en el registro a si mismo
        MOV CL,NAMELEN                                      ;mueve lo que tiene la cadena al registro CL
        ADD DI,NAMEREC                                      ;leera lo que se puso en la cadena en el registro DI
        ADD DI,CX                                           ;se suma lo que tiene el registro CX al registro DI
        NEG CX                                              ;cambia al negotivo el registro CX
        ADD CX,30                                           ;lo suma con el 30
        REP STOSB
        CALL F10WRIT                                        ;manda llamar al metodo
        CALL E10SCRL                                        ;manda llamar al metodo

        D90:
        RET
        D10PROC ENDP

        
                    ;-------------VERIFICA PARA RECORRIDO-------------

    E10SCRL PROC NEAR                                       ;Inicia este procedimiento
    CMP ROW,18                                              ;compara el 18 con el renglon que vale 1
    JAE E10                                                 ;compara si el metodo si es mayor o igual
    INC ROW                                                 ;incrementa el renglon
    JMP E90                                                 ;saltar? al metodo E90 si se cumple la condicion

    E10:
    MOVAX ,0601H                                            ; ---
    CALL Q10SCR                                             ;manda llamar Q10SCR

    E90:    
    CALL Q20CURS                                            ;manda llamar Q20CURS
    RET                                                     ;repetira
    E10SCRL ENDP

                    ;ESCRIBE REGISTRO EN DISCO:
                    ;----------------------------

    F10WRIT PROC NEAR                                       ;inicia el procedimiento
    MOV 4H,40H                                              ;mueve el registro al registro AH
    MOV BX, HANDLE                                          ;la cadena hay almacenada se movera al registro BX
    MOV CX,32                                               ;mueve el 32 a CX
    LEA DX, NAMEREC                                         ;la cadena que anteriormente se habia obtenido se transfiere al registro DX
    INT 21H                                                 ;se realiza la anterior peticion
    JNC F20                                                 ;si no es cero, saltara al metodo F20
    LEA DX,WRTMSG                                           ;enviara el mensaje de error al escribir el registro DX
    CALL X10ERR                                             ;manda llamar el metodo X10ERR
    MOV NAMELEN,00                                          ;limpia la variable

    F20:
    RET
    F10WRIT ENDP

                    ;CIERRA ARCHIVO EN DISCO
                    ;------------------------

    G10CLSE PROC NEAR
    MOV NAMEREC,1AH                                             ;LE ASIGNA ESTA INFORMACION A LA VARIABLE
    CALL F10WRIT                                                ;manda a llamar al metodo F10WRIT
    MOV AH,3EH                                                  ;mueve el registro 3EH al registro AH
    MOV BX,HANDLE                                               ;la cadena se mueve al registro BX
    INT 21H                                                     ;realiza la peticion anterior
    RET                                                         ;repetira

G10CLSE END


;               RECORRE LA PANTALLA:
;               -------------------

    QS10CR PROC NEAR                                            ;INICIA EL PROCESO
        MOV BH,1EH                                              ;TRANSFIERE EL REGISTRO 1EH 1 REGISTRO BH
        MOV CX,0000                                             ;LIMPIA EL REGISTRO CX
        MOV DX,184FH                                            ;----
        INT 10H;                                                REALIZA LA PETICION Y EJECUTA
        RET;
    Q10SCR ENDP
 
                    ;COLOCA EL CURSOR:
                    ;----------------
    Q20CURS PROC NEAR
        MOV AH,02H                                              ;MNUEVE EL REGISTRO 02H AL REGISTRO AH
        MOV BH,00                                               ;PONE EN 0 EL REGISTRO BH
        MOV DH,ROW                                              ;ENVIA EL VALOR DEL RENGLON AL REGISTRO DH
        MOV DL,00                                               ;LIMPIA EL REGISTRO DL
        INT 10H                                                 ;REALIZA LA PETICION ANTERIOR
        RET                                                     ;REPITE
    Q20CURS ENDP
 
                    ;DESPLIEGA MENSAJE DE ERROR EN DISCO:
                    ;-----------------------------------
 
    X10ERR PROC NEAR: INICIA EL PROCESO
        MOV AH,40H                                              ;TRANSFIERE EL REGISTRO 40H AL REGISTRO AH
        MOV BX,01                                               ;ENVIA EL VALOR DE 1 AL REGISTRO BX
        MOV CX,21                                               ;TRANSFIERE EL 21 AL VALOR CX
        INT 21H                                                 ;REALIZA LA PETICION ANTERIOR
        MOV ERRCDE,01                                           ;MUEVE EL UNO, A LA VARIABLE ERRCDE
        RET                                                     ;REPITE
    X10ERR ENDP                                                 ;TERMINA ESTE METODO
     
END INICIO


    

    
    
    