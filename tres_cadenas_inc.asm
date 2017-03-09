;programa que imprime 3 cadenas con funciones 
;Gilberto Ayala, 7 de marzo
%include 'funciones.asm'
section .data
	msj1 DB 'Hola mundo ',0x0
	msj2 DB 'desde mi computadora!',0x0
	msj3 DB 'programando! con include y salto de linea',0x0
section .text
	GLOBAL _start

_start:

	;imprimimos primer mensaje
	mov EAX, msj1 ; direccion mensaje 1 
	call sprintLF 
	; segundo mensaje 
	mov EAX, msj2
	call sprintLF
	; tercer mensaje 
	mov EAX, msj3
	call sprintLF

	jmp quit ; salida 



	; mov EAX, msj1 	; cargando mensaje 1 
	; call strlen 	; calcular longitud ji
	; mov EDX, EAX 	; guardo longitud en EDX
	; mov ECX, msj1 	; cargo mensaje 1 
	; mov EAX,  4 	; syswrite
	; mov EBX,  1		; stdout
	; int 0x80 		; llamada a kernel 

	; mov EAX, msj2 	; cargando mensaje 1 
	; call strlen 	; calcular longitud 
	; mov EDX, EAX 	; guardo longitud en EDX
	; mov ECX, msj2 	; cargo mensaje 1 
	; mov EAX,  4 	; syswrite
	; mov EBX,  1		; stdout
	; int 0x80 		; llamada a kernel 	


	; mov EAX, msj3 	; cargando mensaje 1 
	; call strlen 	; calcular longitud 
	; mov EDX, EAX 	; guardo longitud en EDX
	; mov ECX, msj3 	; cargo mensaje 1 
	; mov EAX,  4 	; syswrite
	; mov EBX,  1		; stdout
	; int 0x80 		; llamada a kernel 

	; salida
	

; strlen:
; 	push EBX ; salvamos el valor de ebx
; 	mov EBX, EAX ; copiamos la direccion de donde esta

; sigcar:
; 	cmp byte[EAX],0 ; comparamos el byte en el que esta
; 	 jz finalizar ; jump if zero

; 	 inc EAX ; incfremento en 1
; 	 jmp sigcar ; salto incodicional al 
; finalizar: 
; 	sub EAX , EBX ; restamos al vvalor incial
; 	pop EBX ; Establecer ebx
; 	ret ; regresar al punto en el que salto/

; ;----------------------
; ; Funcion Stirng Print
; ; Recibe direccion de cadena en EAX
; ;----------------------

; sprint:
; 	push EDX 		; salvamos valor de edx
; 	push ECX 		; salvamos el valor de ecx
; 	push EBX 		; salvamos el valor de ebx
; 	push EAX 		; salvamos el valor de eax
; 	call strlen

; 	mov EDX, EAX 	; movemos la longitud de eax 
; 	pop EAX 		; traemos el stack de la direccion
; 	mov ECX, EAX 	; la direccion del mnesaje
; 	mov EAX, 1 		; descriptor de archivos stdout
; 	mov EAX, 4 		; sys_write
; 	int 80h 		; ejecuta

; 	pop EBX 		; re-establecemos EBX
; 	pop ECX 		; re-establecemos ECX
; 	pop EDX 		; re-establecemos EDX
; 	ret
; ; salidaaaaaaaa
; quit:
; 	mov EAX, 1 ; sys_exit

; 	int 0x80 ; llamada a kernels 