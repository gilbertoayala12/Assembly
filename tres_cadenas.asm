;programa que imprime 3 cadenas 
;Gilberto Ayala, 6 de marzo
section .data
	msj1 DB 'Hola mundo ', 0xA,0x0
	msj2 DB 'desde mi computadora!', 0xA ,0x0
	msj3 DB 'bien chidori!', 0xA, 0x0
section .text
	GLOBAL _start

_start:
	mov EAX, msj1 	; cargando mensaje 1 
	call strlen 	; calcular longitud 
	mov EDX, EAX 	; guardo longitud en EDX
	mov ECX, msj1 	; cargo mensaje 1 
	mov EAX,  4 	; syswrite
	mov EBX,  1		; stdout
	int 0x80 		; llamada a kernel 

	mov EAX, msj2 	; cargando mensaje 1 
	call strlen 	; calcular longitud 
	mov EDX, EAX 	; guardo longitud en EDX
	mov ECX, msj2 	; cargo mensaje 1 
	mov EAX,  4 	; syswrite
	mov EBX,  1		; stdout
	int 0x80 		; llamada a kernel 	


	mov EAX, msj3 	; cargando mensaje 1 
	call strlen 	; calcular longitud 
	mov EDX, EAX 	; guardo longitud en EDX
	mov ECX, msj3 	; cargo mensaje 1 
	mov EAX,  4 	; syswrite
	mov EBX,  1		; stdout
	int 0x80 		; llamada a kernel 

	; salida
	mov EAX, 1
	int 0x80 

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

