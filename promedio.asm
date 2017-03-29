; promedio 
; por: Gilberto Ayala
%include 'funciones2.asm'

section .text
	GLOBAL _start

_start:
	pop ECX				;obtenemos numero de argumentos
	pop EAX
	dec ECX
	mov edx, ecx		; mueve el numero de argumentos a  edx

ciclo:

	pop EAX				;obtemos argumento
	call atoi
	add EBX,EAX			; hace todo 
	dec ecx
	cmp ecx,0
	jnz ciclo
	mov EAX,EBX			; mueve el resultado de la suma a eax
	mov ecx, edx		; mueve el numero de argumentos a ecx 
	mov edx, 0			; dejamos edx en 0
	idiv ecx			; multiplica idiv divide eax entre lo que le pases 
	
	call iprintLF 		; print argumento

	jmp quit