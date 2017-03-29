; multiply 
; por: Gilberto Ayala
%include 'funciones2.asm'

section .text
	GLOBAL _start

_start:
	pop ECX				;obtenemos numero de argumentos
	pop EAX
	dec ECX
	mov EBX, 1h 

ciclo:
	pop EAX				;obtemos argumento
	call atoi
	imul EBX,EAX
	dec ecx
	cmp ecx,0
	jnz ciclo

	mov EAX,EBX
	call iprintLF 		; print argumento

	jmp quit