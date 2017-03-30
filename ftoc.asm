; faranheit to celsius
; gilberto ayala 

%include 'funciones2.asm'
section .data
	
	msg DB "El resultado es: ", 0x0
	msg2 db " °C"


segment .bss
	num_arg RESB 4

section .text
	GLOBAL _start

_start:
	pop ECX				; Obtenemos el numero de argumentos
	cmp ECX, 2			; Checamos si hay al menos un valor
	jl zeroargs
	pop EAX				; Sacamos el nombre del programa del stack
	dec ECX				; Decrementamos el # de argumentos en 1
	mov [num_arg], ECX	; Movemos el valor de ECX a num_arg
	mov EBX, 1h			; Iniciamos EBX con 0

ciclo:
	mov eax, msg
	call sprint
	pop EAX				; Obtenemos el valor
	call atoi			; Lo convertimos a entero
	call ftoc			; convertimos en esa madre
	call iprint
	mov eax, msg2
	call sprintLF
	dec ECX				; Decrementamos el # de argumentos en 1
	cmp ECX,0			; Checa si todavia hay valores
	jnz ciclo 			; Sigue si todavia hay valores
	jmp quit

	

zeroargs:
	jmp quit