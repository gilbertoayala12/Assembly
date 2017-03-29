; programa: argumentos 
; creador: gilberto ayala 

%include 'funciones.asm'

section .text
	GLOBAL _start

_start:
	pop ECX				;obtenemos numero de argumentos

ciclo:
	pop EAX				;obtemos argumento
	call sprintLF 		; print argumento

	dec ECX				; restamos 1 al numero de argumentos
	cmp ECX, 0 			; comparamos si es el ultimo argumento
	jnz ciclo 			; seguimos si no es el ultimo argumento

	jmp quit