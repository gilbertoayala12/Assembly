section .data                   ;Samaniego Rubiano Cristian Raul
    a db "4" ; primer operador
    b db "3" ; segundo operado
    msg db "la suma es: ", 0x0 ; mensaje de la suma
    len equ $ - msg ; longitu de la suma
    vac db " ",0xA,0x0
    lv equ $ - vac ; longitud del renglon vacio

segment .bss
	sum resb 1 ; reserva 1 bit alaew
section .text
	GLOBAL _start


_start:
	mov eax,[a] ; carga primer operador [cargar desde esa direccion]
	sub eax, '0' ; resta el caracter '0'

	mov ebx, [b] ;carga el segundo operadore 
	sub ebx, '0' ;resta el caracter 0

	add eax, ebx ; suma los numeros
	add eax, '0' ; agrega el caracter 0
	mov [sum], eax ; transfiere le acomulador

	mov ecx, msg ; despliega la suma es
	mov edx, len
	mov ebx ,1  ;file descriptior stdout
	mov eax, 4 ; system call number sys_write

	int 0x80 ; call kernel

	mov ecx, sum ; despliega el resultado
	mov edx, 1
	mov ebx ,1
	mov eax ,4 ; system call number stdout
	int 0x80 ; call kernel

	mov ecx, vac ; renglon vacio
	mov edx, lv ;longitud renglon vacio
	mov ebx, 1;stdout
	mov eax, 4 ;sys_write
	int 0x80 ; llamar kernel

	mov eax,1 ; ssysexit
	int 0x80; call kernel