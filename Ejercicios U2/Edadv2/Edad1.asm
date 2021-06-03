;=========================================================================================
;ITSUR | Ing. en Sistemas Computacionales
;LENGUAJES DE INTERFAZ | S66A
;Profesor: Jorge Guzman Ramos
;Alumno: Jorge Luis Medina Gaytan - S14120040
;Programa: Edad del usuario
;=========================================================================================

Pila SEGMENT STACK                                          ;Define la pila
        
    DW 64 DUP(?)                                            ;Espacio para la pila

Pila ENDS                                                   ;Termina la pila                                        


Datos SEGMENT                                               ;Define segmento de codigo 
  
    M1      DB " Tas chavo pala compu",0AH,0DH,"$"                                      ;Mensaje alusivo 1
    M2      DB " Todo un PRO de la maquina",0AH,0DH,"$"                                 ;Mensaje alusivo 2
    M3      DB " Un inge con trayectoria",0AH,0DH,"$"                                   ;Mensaje alusivo 3
    M4      DB " Ya piensele para la jubilada",0AH,0DH,"$"                              ;Mensaje alusivo 4
    M5      DB " ?Usted le daba clases a mi papa?",0AH,0DH,"$"                          ;Mensaje alusivo 5
    M6      DB " ?No le dije que le pensara en la jubilada?",0AH,0DH,"$"                ;Mensaje alusivo 6
    
       
    pFecha  DB 10,13,'Ingresa tu fecha de nacimiento con formato dd/mm/aaaa : ','$'     ;Mensaje de ingreso
    pEdad   DB 10,10,13,'Tu edad es: ','$'                                              ;Mensaje de salida

    diaU    DB 0                                            ;Espacio para ingreso del dia
    mesU    DB 0                                            ;Espacio para ingreso del mes  
    anioU   DW 0                                            ;Espacio para ingreso del anio

    diaS    DB 0                                            ;Espacio para dia-sistema
    mesS    DB 0                                            ;Espacio para mes-sistema     
    anioS   DW 0                                            ;Espacio para anio-sistema

    EDAD    DB 0                                            ;Espacio para almacenar edad calculada

    Datos ENDS                                                  ;Termina segmento


Codigo SEGMENT
   
    ASSUME SS:Pila, DS:Datos, CS:Codigo                     ;Asignar datos;
 
  
    SAY MACRO MSG                                           ;Declarar macro;
    
    MOV Ah,09               
    MOV DX,offset MSG                                       ;Mostrar mensaje alusivo correspondiente
    INT 21H
  
    ENDM                                                    ;Cerrar macro


    Inicio:                                                 ;Inicia el programa
   
    MOV AX,DATOS                                            ;Direcciona el segmento de datos
    MOV DS,AX                                               ;Peticion                  
    MOV AX,0600H                                            ;Borra la pantalla
    MOV BH,0AH                                              ;Fondo negro y letras verdes
    MOV CX,00000H                                           ;Inicio de borrado
    MOV DX,184FH                                            ;Fin de borrado
    INT 10H                                                 ;Llamada al sistema
                   
    
    
    SAY  pFecha                                             ;Imprime mensaje de entrada
    
    MOV CX,03
    CALL LEER                                               ;Lectura del dia ingresado por el usuario
    MOV diaU,BL                                             ;Asignar valor ingresado a la variable

    MOV CX,03
    CALL LEER                                               ;Lectura del mes ingresado por el usuario
    MOV mesU,BL                                             ;Asignar valor ingresado a la variable
        
    MOV CX,04
    CALL LEER                                               ;Lectura del anio ingresado por el usuario
    MOV anioU,BX                                            ;Asignar valor ingresado a la variable

   
    
    MOV AH,2AH                                              ;Fecha del sistema
    INT 21H
    
    MOV diaS,DL                                             ;Guardar dia del sistema
    MOV mesS,DH                                             ;Guardar mes del sistema
    MOV anioS,CX                                            ;Guardar anio del sistema

    
   
    MOV AX,anioS                                            ;Mover valor del anio del sistema
    SUB AX,anioU                                            ;Restar anio ingresado por el usuario al anio del sistema
    MOV EDAD,AL                                             ;La resta da como resultado la edad del usuario

   
    
    MOV AL,mesS                                             ;Mover valor del mes del sistema
    CMP AL,mesU                                             ;Comparar mes ingresado con el del sistema
    JE MESIGUAL                                             ;Salta si son iguales
    JNBE IMPRESION                                          ;Salta a impresion
    SUB edad,01                                             ;Resta 1 a la edad si son diferentes
    JMP IMPRESION                                           ;Salta a impresion

    
    
    MESIGUAL:                                               ;Inicia ciclo MESIGUAL                             
    
    MOV AL,diaS                                             ;Mover valor del dia del sistema
    CMP Al,diaU                                             ;Comparar dia ingresado con el del sistema
    JMP IMPRESION                                           ;Salta a impresion
    SUB EDAD,01                                             ;Resta 1 a la edad si son diferentes
  

    
    IMPRESION:                                              ;Inicia ciclo IMPRESION  

    SAY  pEdad                                              ;Imprime mensaje de salida
    MOV AX,0    
    MOV AL,EDAD                                             ;Imprime valor de la edad
    JMP CGB                                                 ;Salta a comparacion para mensajes alusivos
                 

    
    COMPARA:                                                ;Inicia ciclo COMPARA   
   
    CMP EDAD,10                                             ;Compara edad con el rango
    JB CAR1                                                 ;Selecciona mensaje alusivo
    CMP EDAD,30                                             
    JB CAR2                                                 
    CMP EDAD,50                                            
    JB CAR3
    CMP EDAD,70                                            
    JB CAR4
    CMP EDAD,90                                            
    JB CAR5
    CMP EDAD,110                                            
    JB CAR6  
   
    CAR1:                                                   ;Inicia ciclo para mensaje alusivo 1
    
    SAY M1                                                  ;Imprime mensaje alusivo 1
    JMP CAR                                                 ;Salta a la salida del sistema

    CAR2:                                                   ;Inicia ciclo para mensaje alusivo 2
    
    SAY M2                                                  ;Imprime mensaje alusivo 2
    JMP CAR                                                 ;Salta a la salida del sistema
 
    CAR3:                                                   ;Inicia ciclo para mensaje alusivo 3
    
    SAY M3                                                  ;Imprime mensaje alusivo 3
    JMP CAR                                                 ;Salta a la salida del sistema
  
    CAR4:                                                   ;Inicia ciclo para mensaje alusivo 4
    
    SAY M4                                                  ;Imprime mensaje alusivo 4
    JMP CAR                                                 ;Salta a la salida del sistema
    
    CAR5:                                                   ;Inicia ciclo para mensaje alusivo 5
    
    SAY M5                                                  ;Imprime mensaje alusivo 5
    JMP CAR                                                 ;Salta a la salida del sistema
    
    CAR6:                                                   ;Inicia ciclo para mensaje alusivo 6
    
    SAY M6                                                  ;Imprime mensaje alusivo 6
    JMP CAR                                                 ;Salta a la salida del sistema
 
    
    CGB:                                                    ;Ciclo compara y despliega
    
    CALL DESPLEGAR                                          ;Llama al proceso desplegar
    JMP  COMPARA                                            ;Salta a ciclo COMPARA
  
 
    
    CAR:                                                    ;Ciclo de cierre
   
    MOV AX,4C00H                                            ;Peticion de terminar
    INT 21H                                                 ;LLamada al sistema


    
    DESPLEGAR PROC NEAR                                     ;Inicia proceso DESPLEGAR
    
    PUSH BX                                                 ;Guarda el contenido de BX en la pila
    PUSH CX                                                 ;Guarda el contenido de CX en la pila
    PUSH AX                                                 ;Guarda el contenido de AX en la pila
                    
    MOV CX,0
    MOV BX,10                                               ;Division entre 10

   
    GUARDAR:                                                ;Inicia ciclo GUARDAR
   
    MOV DX,0                                                ;DX-AX
    DIV BX                                                  ;Divide entre 10
                    
    PUSH DX                                                 ;Guarda dato en binario
    INC CX                                                  ;Incremento
    CMP AX,0                                                ;Asignar 0
    JNZ GUARDAR                                             ;Repetir si AX es diferente de 0

   
    EXTRAER:                                                ;Inicia ciclo GUARDAR
   
    POP DX                                                  ;Extraer ultimo digito de la pila
    ADD DL,30H                                              ;Conversion a ASCII
    MOV AH,06 
    INT 21H
    LOOP EXTRAER                                            ;Repetir  mientras CX es diferente de 0
    POP AX                                                  ;Reestablece registro AX
    POP CX                                                  ;Reestablece registro CX
    POP BX                                                  ;Reestablece registro BX
    RET                                                     ;Repetir proceso 

    DESPLEGAR ENDP                                          ;Termina proceso DESPLEGAR
                

    
    LEER  PROC NEAR                                         ;Iinicia proceso LEER
    
    MOV BX,0
   
    
    LEER01:                                                 ;Inicia ciclo LEER01
    
    MOV AH,01                                               ;Entrada de teclado
    INT 21H
    
    CMP AL,'0'                                              ;Validar ingreso de numeros
    JB  LEER02                                              ;Salto a ciclo LEER02
    CMP AL,'9'                                              ;Validar ingreso de numeros
    JA  LEER02                                              ;Salto a ciclo LEER02
    SUB AL,'0'                                              ;Validar ingreso de numeros
    
    PUSH AX                                                 ;Guardar en pila
    MOV AX,BX                                               ;Mover registros
    MOV SI,010
    MUL SI
    MOV BX,AX
    POP AX
    MOV AH,0
    ADD BX,AX                    
    LOOP LEER01                                             ;Repetir ciclo
   

    LEER02:                                                 ;Inicia ciclo LEER02
    
    MOV  AX,BX                                              ;Mover regitros
    RET                                                     ;Repetir proceso    

    LEER ENDP                                               ;Termina proceso LEER



Codigo ENDS                                                 ;Termina el codigo   

END Inicio                                                  ;Termina el programa


