; gilberto ayala 
; programa menu que pregunte que quiere capturar
; 4/20 de 2017 



%include 'funciones2.asm'

segment .bss
	buffer_nombre resb 20
	nombre_len EQU $-buffer_nombre
	nombre resb 20
	buffer_edad resb 20
	edad_len EQU $-buffer_edad
	edad resb 4
	buffer_respuesta resb 20
	respuesta_len EQU $-buffer_respuesta
	respuesta resb 4
	
segment .data
	msg_nombre DB "dime tu nombre: ",0x0
	msg_edad DB "dame tu edad: ", 0x0
	nombre_mensaje db "tu nombre es: ", 0x0
	edad_mensaje db "tu edad es: ",0x0 
	menu db "~MENU~",0xa, "1.-Captura nombre",0xa, "2.-Captura edad",0xa,  "3.-Imprimir",0xa ,"0.-Salir",0x0
	mensaje_salida db "Gracias vuelva pronto",0x0
	mensaje_valido db "Valor no valido",0x0

section .text
	GLOBAL _start

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
je opcion1
cmp eax, 2
je opcion2
cmp eax, 3
je opcion3
cmp eax, 0
je opcion0
jmp opcion_no_valida

opcion1:
mov eax, msg_nombre
call sprint
mov ecx, buffer_nombre
mov edx, nombre_len
call LeerTexto
mov eax, buffer_nombre
mov esi, nombre
call stringcopy
jmp _start


opcion2:
mov eax, msg_edad ; imprime mensaje edad
call sprint
mov ecx, buffer_edad; buffer a ecx
mov edx, edad_len ; guarda la longitud del buffer en edx
call LeerTexto	;llama leer texto
mov eax, buffer_edad;mueve el buffer de l;a edad a eax
call atoi	; llama atoi para hacerlo integer
mov [edad], eax	; mueves lo del buffer que estaba en eax a edad para tenerlo guardado  
jmp _start

opcion3:
mov eax, nombre_mensaje
call sprint
mov eax, nombre
call sprintLF
mov eax, edad_mensaje
call sprint
mov eax, [edad]
call iprintLF
jmp _start

opcion0:
mov eax, mensaje_salida
call sprintLF
jmp quit

opcion_no_valida:
mov eax, mensaje_valido
call sprintLF
jmp _start