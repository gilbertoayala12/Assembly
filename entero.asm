%include 'funciones.asm'
section .data
	numero 		DD 1337 	;numero entero
	string 		DB "101"

section .text
	GLOBAL _start

_start:
	;imprimimos el mensaje
	mov EAX, [numero] 		;numero a imprimir
	call iprintLF			;imprimir numero entero

	mov EAX, string 		; cadena de numeros a convertir
	call atoi				; llamada a atoiiiii
	call iprintLF			; llamada a iprint jeje
	
	jmp quit 				;salida