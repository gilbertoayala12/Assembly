; sumatoria 
; por: Gilberto Ayala
%include 'funciones2.asm'

section .text
	GLOBAL _start

_start:
	pop ECX				;obtenemos numero de argumentos
	
	mov EBX, 0h 

ciclo:
	pop EAX				;obtemos argumento
	call atoi
	add EBX,EAX
	dec ecx
	cmp ecx,0
	jnz ciclo

	mov EAX,EBX
	call iprintLF 		; print argumento

	jmp quit