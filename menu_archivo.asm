;menu con leer archivo
;autor: gilberto


%include 'funciones2.asm'

segment .bss
   buffer_nombre resb 20
	len_nombre equ $-buffer_nombre

	buffer_opcion resb 3
	len_opcion equ $-buffer_opcion

	buffer_archivo resb 2048
	len_archivo equ $-buffer_archivo

	nombre resb 20
	opcion resb 4
	archivo resb 2048

section .text
    global _start
segment .data
	msg_archivo DB "Direccion del archivo: ",0x0

	msg_imprimiendo db "IMPRIMIENDO", 0x0
	msg_leyendo db "Archivo: ",0x0 
	msg_saliendo db "Gracias vuelva pronto", 0x0
	mensaje_valido db "Valor no valido",0x0
	menu db "~MENU~",0xa, "1.-Leer archivo",0xa, "2.-Imprimir archivo",0xa ,"0.-Salir",0xa,"Ingrese seleccion: ",0xa,0x0
_start:
	mov EAX,menu 			; Imprimimos el menu
	call sprint

	mov ECX, buffer_opcion 	; Leemos la entrada del usuario
	mov EDX, len_opcion
	call LeerTexto

	mov EAX, buffer_opcion
	mov ESI, opcion
	call stringcopy

	mov EAX, opcion
	call atoi

	cmp EAX, 1
	je leer

	cmp EAX, 2
	je imprimir

	cmp EAX, 0
	je salida

	jmp no_valida


leer:
	mov EAX, msg_leyendo
	call sprint

	mov ECX, buffer_nombre
	mov EDX, len_nombre
	call LeerTexto

	mov EAX, buffer_nombre
	mov ESI, nombre

	call copystring

	jmp _start

imprimir:
	; Aabre arch
	mov EBX, nombre
	mov EAX, sys_open
	mov ECX, O_RDONLY
	int 0x80

	cmp EAX, 0
	jle error

	; leee

	mov EBX, EAX
	mov EAX, sys_read
	mov ECX, buffer_archivo
	mov EDX, len_archivo
	int 0x80

	; cierra
	mov EAX, sys_close
	int 0x80

	mov EAX, buffer_archivo
	call sprintLF

	jmp _start






no_valida:
	mov eax, mensaje_valido
	call sprintLF
	jmp _start

error:
	mov EBX,EAX
	mov EAX,sys_exit
	int 0x80

salida:
	mov eax, msg_saliendo
	call sprintLF
	jmp quit