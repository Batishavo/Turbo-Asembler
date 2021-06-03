#include <stdio.h>
#include <conio.h>

/*
================================================================================
ITSUR | Ing. en Sistemas Computacionales
LENGUAJES DE INTERFAZ | S66A
Profesor: Jorge Guzman Ramos
Alumno: Jorge Luis Medina Gaytan - S14120040
Programa: Examen U4 - RESTA
===============================================================================
*/

void main()
{


    int dato1, dato2, resultado;  /* Definicion de variables */

    printf("\nIngresa un numero: ");
    scanf("%d", &dato1);		/* Mensaje e ingreso 1 */
    printf("Ingresa otro numero: ");
    scanf("%d", &dato2);		/* Mensaje e ingreso 2 */


      /* Calculo de la multiplicacion en ensamblador */
      asm push cx
      asm mov  cx,dato1
      asm sub  cx,dato2
      asm mov  resultado,cx
      asm pop  cx



    /* Impresion del resultado de la RESTA */
    printf("Resultado de la RESTA: %d", resultado);

}
