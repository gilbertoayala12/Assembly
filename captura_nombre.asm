; programa que pide nombre y edad jeje 
; gilberto ayala
; 18 de abril de 2017
%include 'funciones2.asm'

segment .bss
	buffer_nombre resb 20
	nombre_len EQU $-buffer_nombre
	nombre resb 20
	buffer_edad resb 20
	edad_len EQU $-buffer_edad
	edad resb 4
	
	
segment .data
	msg_nombre DB "dime tu nombre: ",0x0
	msg_edad DB "dame tu edad: ", 0x0
	nombre_mensaje db "tu nombre es: ", 0x0
	edad_mensaje db "tu edad es: ",0x0

section .text
	GLOBAL _start

_start:
	mov eax, msg_nombre
	call sprint
	mov ecx, buffer_nombre
	mov edx, nombre_len
	call LeerTexto
	mov eax, buffer_nombre
	mov esi, nombre
	call stringcopy

	mov eax, msg_edad ; imprime mensaje edad
	call sprint
	mov ecx, buffer_edad; buffer a ecx
	mov edx, edad_len ; guarda la longitud del buffer en edx
	call LeerTexto	;llama leer texto
	mov eax, buffer_edad;mueve el buffer de l;a edad a eax
	call atoi	; llama atoi para hacerlo integer
	mov [edad], eax	; mueves lo del buffer que estaba en eax a edad para tenerlo guardado  

	mov eax, nombre_mensaje
	call sprint
	mov eax, nombre
	call sprintLF
	mov eax, edad_mensaje
	call sprint
	mov eax, [edad]
	call iprintLF
	jmp quit

	

