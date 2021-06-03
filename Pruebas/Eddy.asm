Pila SEGMENT STACK  ;Definici?n de la pila
        DW 64 DUP(?)    ;64 palabras.   La DW significa Define Word
Pila ENDS        ;Fin de la pila

Datos SEGMENT       ;Define segmento de datos. Donde van las variables o constantes
    msg DB 0AH,0DH,  "Hola", 10, 13, "     batos",10, 13, "           locos",0AH,0DH,"$" ;Aqui se coloca el mensaje. El 10, 13 es un enter. El signo de pesos es un delimitador.

Datos ENDS      ;Fin del segmento de datos

Codigo SEGMENT      ;Creamos el segmento de codigo
    ASSUME CS:Codigo,DS:Datos,SS:Pila ;Direccionamiento de segmentos

Inicio:


    MOV AX,Datos    ;Direcciona los datos. AX es un registro general
    MOV DS,AX   ;Copia los datos al segmento correspondiente
    MOV DX,offset msg;Coloca el mensaje en DX
    MOV AH,09H; ;Coloca la funcion de visualizar los datos
    INT 21H         ;Solicita al SO despliege el msg
    MOV AH,4CH  ;Coloca  la funcion terminar
    INT 21H     ;Solicita al sistema terminar el prog.
Codigo  ENDS        ;Fin del segmento de codigo
    END Inicio  ;Cerramos la etiqueta inicio
