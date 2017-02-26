; holamundo.asm
; imprime "hola mundo"
; autor: Gilberto Ayala
; fecha: 23 de febrero de 2017
section .data
	msj DB 'Hola mundo!', 0xA,0x0 ;mensaje a imprimir je
	lon EQU $ - msj ; longitud del mensaje

section .text
	GLOBAL _start ; punto de inicio
_start:
	mov EDX, lon ; logitud del mensaje tal vex
	mov ECX, msj ; el mensaje 
	mov EBX, 1 ;descriptor
	mov EAX, 4  ;llamada
	int 0x80 ;llamada 
	mov EAX, 1 ;llamada
	int 0x80 ; llamada
