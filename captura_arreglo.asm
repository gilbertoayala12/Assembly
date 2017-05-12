;menu con para capturar arreglo
;autor: gilberto


%include 'funciones2.asm'

segment .bss
   buffer_nombre resb 50
	len_nombre equ $-buffer_nombre

	buffer_opcion resb 3
	len_opcion equ $-buffer_opcion

	buffer_archivo resb 2048
	len_archivo equ $-buffer_archivo
	
	nombre resb 50
	opcion resb 4
	archivo resb 2048
	array resb 2000
	len_array EQU $-array

section .text
    global _start

segment .data
	msg_archivo DB "nombre del archivo: ",0x0
	dummy db "c",0x0
	msg_imprimirNombres db "nombres guardados", 0x0
	msg_leyendo db "Archivo: ",0x0 
	msg_alumo db "Introduzca nombre: ",0x0
	msg_empty db "##### Arreglo vacio #####", 0x0
	msg_saliendo db "Gracias vuelva pronto", 0x0
	mensaje_valido db "Valor no valido",0x0
	menu db "~MENU~",0xa, "1.-Captura alumno",0xa, "2.-Imprimir arreglo",0xa ,"3.-Guarda archivo",0xa,"0.-Salir",0xa,"Ingrese seleccion: ",0xa,0x0

_start:
	mov esi, array
	push ecx

	menu_inicio:
		push esi

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
	
	
	mov eax, msg_alumo
	call sprint 
	
	mov ecx, buffer_nombre
	mov edx, len_nombre
	call LeerTexto
	mov eax, buffer_nombre

	pop esi 		; obteiene el pointer del array_nombr
	call stringcopy
	add esi, 50

	pop ecx
	add ecx, 1 
	push ecx
	mov edi, buffer_nombre
	mov ecx, 50
	xor eax, eax
	rep stosb
	jmp menu_inicio



opcion2:
	
	mov eax, msg_imprimirNombres
    call sprintLF
    pop ebx                         ; stack pointer in ebx
    mov esi, array                  ; intialize esi
    pop ecx                         ; get number of names saved
    push ecx                        ; save number of names again
    cmp ecx, 0
    jz noValues
    ; print loop
    prloop:
        mov eax, esi			
        call sprint
        add esi,50
        dec ecx
        cmp ecx, 0
        jne prloop

    mov esi, ebx                    ; restore esi original pointer(will be pushed in display_menu)
    jmp menu_inicio


opcion3:
	mov eax, msg_archivo
	call sprint
	mov ecx, buffer_archivo
	mov edx, len_archivo
	call LeerTexto
	; usamos esi para el copystring
	mov esi, archivo
	mov eax, buffer_archivo
	call copystring

	; create;
	mov eax, sys_create ;sys_create
	mov ebx, archivo
	mov ecx, 511 ; permisos
	int 0x80

	cmp eax,0
	jle error

	; open filename for write ;
	mov eax, sys_open
	mov ebx, archivo
	mov ecx, O_RDWR
	int 0x80
	cmp eax, 0
	jle error ; si es cero o menor, error al abrir


	; write ;
	mov ebx, eax ; file handle a eax
	mov eax, sys_write
	mov ecx, array
	mov edx, len_array
	int 0x80
	mov eax, sys_sync		; sys_sync
	int 0x80
 ;====== Close file ======
    mov eax, sys_close
    int 0x80
    pop esi
    jmp menu_inicio

salida:
	jmp quit

no_valido:
	mov eax, mensaje_valido
	call sprintLF
	pop esi
	jmp menu_inicio

noValues:
	mov eax, msg_empty
	call sprintLF
	jmp menu_inicio

error:
	mov ebx,eax			;
	mov eax,sys_exit	;
	int 0x80 			;