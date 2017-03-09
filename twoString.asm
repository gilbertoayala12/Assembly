; TwoString
; imprime dos strings
; autor: Gilberto Ayala
; fecha:25 de febrero de 2017
section .data
	msj1 DB 'Hola mundo ', 0xA
	lonMsj1 EQU $ -msj1 ;long msj1
	msj2 DB 'desde mi computadora!', 0xA
	lonMsj2 EQU $ -msj2 ;long ms

section .text
	GLOBAL _start

_start:
	mov EDX, lonMsj1 ; logitud del mensaje tal vex
	mov ECX, msj1 ; el mensaje 
	mov EBX, 1 ;descriptor
	mov EAX, 4  ;llamada
	int 0x80 ;llamada del primer string
	mov EAX, 1 ;llamada
	
	mov EDX, lonMsj2 ; logitud del mensaje tal vex
	mov ECX, msj2 ; el mensaje 
	mov EBX, 1 ;descriptor
	mov EAX, 4  ;llamada
	int 0x80 ;llamada del segundo string
	mov EAX, 1 ;llamada
	int 0x80 ; llamada del segundo string y primer