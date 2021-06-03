#include <stdio.h>
#include <conio.h>
#include <stdlib.h>

int main()
{
 int dato1, dato2, producto;
 printf("teclea 2 numeros:");
 scanf("%d", "%d", &dato1, &dato2);
 
 asm push ax
 asm push cx
 asm mov mov cx, dato1
 asm mov ax, oh
 mult:
      asm add ax, dato2
      asm loop mult
      asm mov producto, ax
      asm pop cx
      asm pop ax;
      printf("El producto es: %d", producto);
    
  system("PAUSE");	
  return 0;
}
