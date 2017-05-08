;menu con para capturar arreglo
;autor: gilberto


%include 'funciones2.asm'

segment .bss
   buffer_nombre resb 20
	len_nombre equ $-buffer_nombre

	buffer_opcion resb 3
	len_opcion equ $-buffer_opcion

	buffer_archivo resb 2048
	len_archivo equ $-buffer_archivo
	array_nombre resb 60
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
	menu db "~MENU~",0xa, "1.-Captura alumno",0xa, "2.-Imprimir arreglo",0xa ,"3.-Guarda archivo",0xa,"0.-Salir",0xa,"Ingrese seleccion: ",0xa,0x0

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
	je opcion1

	cmp EAX, 2
	je opcion2


	cmp EAX, 3
	je opcion3 

	cmp EAX, 0
	je salida

	jmp no_valido



opcion1:


opcion2:

opcion3:

salida:
	jmp quit

no_valido:
	mov eax, mensaje_valido
	call sprintLF
	jmp _start