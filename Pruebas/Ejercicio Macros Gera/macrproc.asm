Pila SEGMENT Stack ;Define la Pila
DW 64 Dup(' ') ;Espacio para la Pila
Pila ENDS ;Termina la Pila?
    
 
    Datos SEGMENT ; Define segmento de datos
    saludo DB "HOLA",10,13,"$";Define una constante
    saludo1 DB "BUENOS DIAS",10,13,"$";Define una constante
    saludo2 DB "ADIOS",10,13,"$";Define una constante
    Datos ENDS;Termina segmento de datos
   
    
codigo SEGMENT;Define segmento de codigo
Assume Ds:Datos,CS:CODIGO;Enlazar la Etiqueta con el registro


  ;###################################
  ;MACRO PARA DIRECCIONAR SEGMENTO DE DATOS
  Direccionar MACRO
  Mov Ax,Datos;Direcciona el Segmento
  Mov Ds,Ax;De Datos
  ENDM
  ;###################################
  
  

  
    ;###################################
    ;MACRO PARA MANDAR MENSAJE
    Mensaje MACRO MSG
    Mov AH,09H;Peticion de desplegar
    Mov DX,Offset MSG;Direcciona el mensaje
    INT 21H;Llamada al sistema
  ENDM
  ;###################################
  
  
  
   ;###################################
   ;MACRO CON MACRO
    macromacro MACRO
  
    Mensaje1 MACRO MSG
    Mov AH,09H;Peticion de desplegar
    Mov DX,Offset MSG;Direcciona el mensaje
    INT 21H;Llamada al sistema
    ENDM
    
    
    Mensaje1 saludo ;llamada al macro
    Mensaje  saludo1 ;llamada al macro
 
  ENDM
  ;###################################
  
  
  
  ;###################################
  ;MACRO CON PROCEDIMIENTO
   Macroconproc MACRO
   
    Mensaje Saludo
    call imprimir ;llamando al procedimiento
    imprimir PROC NEAR
    Mov AH,09H;Peticion de desplegar
    Mov DX,Offset saludo1;Direcciona el mensaje
    INT 21H;Llamada al sistema
    ;RET
    imprimir ENDP
    
  ENDM
  ;###################################
  

  
    ;###################################
    ;PROCEDIMIENTO CON PROCEDIMIENTO
    procproc PROC NEAR   
    Mov AH,09H;Peticion de desplegar
    Mov DX,Offset saludo;Direcciona el mensaje
    INT 21H;Llamada al sistema
    ;RET
   
    
    ;subprocedimiento
    subproc PROC NEAR   
    Mov AH,09H;Peticion de desplegar
    Mov DX,Offset saludo1;Direcciona el mensaje
    INT 21H;Llamada al sistema
    RET
    subproc ENDP;terminar procproc
    
    call subproc
    procproc ENDP;terminar procproc
    
 
  ;###################################
  
  
  
   ;###################################
   ;PROCEDIMIENTO CON MACRO
   procmacro PROC NEAR   
    Mov AH,09H;Peticion de desplegar
    Mov DX,Offset saludo;Direcciona el mensaje
    INT 21H;Llamada al sistema
    
    
   
    
    ;MACRO
    Mensaje MACRO MSG
    Mov AH,09H;Peticion de desplegar
    Mov DX,Offset MSG;Direcciona el mensaje
    INT 21H;Llamada al sistema
    ENDM;termina la macro
    Mensaje saludo2 ; llamando macro
    
    RET
    procmacro ENDP;terminar procproc
    
 
  ;###################################
  
Inicio:

  Direccionar;macro para direccionar segmento de datos
      macromacro ; macro con macro
      Macroconproc ;macro con procedimiento
      call procproc  ;procedimiento con prodecimiento
      call procmacro ;procedimiento con macro
  
  
 

Mov AH,4CH;Peticion de terminar
INT 21H;llamada al sistema


Codigo ENDS;termina el codigo
END Inicio;Termina el Programa