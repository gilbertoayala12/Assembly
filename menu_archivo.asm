;menu con leer archivo
;autor: gilberto


%include 'funciones2.asm'

segment .bss
    buffer resb 2048
    len equ $-buffer
    buffer_respuesta resb 20
	respuesta_len EQU $-buffer_respuesta
	respuesta resb 4

section .text
    global _start
segment .data
	msg_archivo DB "Direccion del archivo: ",0x0

	msg_imprimiendo db "IMPRIMIENDO", 0x0
	msg_leyendo db "Archivo ",0x0 
	mensaje_valido db "Valor no valido",0x0
	menu db "~MENU~",0xa, "1.-Leer archivo",0xa, "2.-Imprimir archivo",0xa ,"0.-Salir",0x0
_start:
	mov eax, menu
	call sprintLF
	mov ecx, buffer_respuesta
	mov edx, respuesta_len
	call LeerTexto
	mov eax, buffer_respuesta
	call atoi
	mov [respuesta], eax
	cmp eax, 1 
	je leer
	cmp eax, 2
	je imprimir 
	cmp eax, 0
	je salida
	jmp no_valida


leer:

imprimir:


error:


no_valida:
	mov eax, mensaje_valido
	call sprintLF
	jmp _start

salida: