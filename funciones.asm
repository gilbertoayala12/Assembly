; funciones asm
sys_exit 	equ 		1
sys_read 	equ 		3
sys_write 	equ 		4
stdin 		equ 		0 
stdout 		equ 		1	
stderr 		equ 		3


strlen:
	push EBX ; salvamos el valor de ebx
	mov EBX, EAX ; copiamos la direccion de donde esta
sigcar:
	cmp byte[EAX],0 ; comparamos el byte en el que esta
	 jz finalizar ; jump if zero

	 inc EAX ; incfremento en 1
	 jmp sigcar ; salto incodicional al 
finalizar: 
	sub EAX , EBX ; restamos al vvalor incial
	pop EBX ; Establecer ebx
	ret ; regresar al punto en el que salto/

sprint:
	push EDX 		; salvamos valor de edx
	push ECX 		; salvamos el valor de ecx
	push EBX 		; salvamos el valor de ebx
	push EAX 		; salvamos el valor de eax
	call strlen

	mov EDX, EAX 	; movemos la longitud de eax 
	pop EAX 		; traemos el stack de la direccion
	mov ECX, EAX 	; la direccion del mnesaje
	mov EAX, stdout		; descriptor de archivos stdout
	mov EAX, sys_write 		; sys_write
	int 80h 		; ejecuta

	pop EBX 		; re-establecemos EBX
	pop ECX 		; re-establecemos ECX
	pop EDX 		; re-establecemos EDX
	ret

sprintLF:
	call sprint 	;llama e imprime el mensaje 
	push EAX 		;salvamos EAX, vamos a
	mov EAX, 0xA	; hex para enter
	push EAX		; salvamos el 0xA en el Eax
	mov EAX, ESP 	; lo que apunta ESP a EAX
	call sprint 	; imprimimos el LF
	pop EAX			; recuperamos el caracter 0xa
	pop EAX			; recuperamos el valor original
	ret 			; return


quit:
	mov EAX, sys_exit ; sys_exit

	int 0x80 ; llamada a kernels 
