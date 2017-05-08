; arreglo_cadena.asm
; gilberto ayala
; 4 de abril 

%include 'funciones2.asm'
segment .bss
	array resb 20

section .text
	global _start

_start:
	pop ecx 	; obtenemos el numero de argumentos
	cmp ecx, 2	; comparamos si es menor a 2
	jl salida	; salimos si es menor a 2

	pop eax 	; obtenemos el nombre del programa
	dec ecx		; restamos 1 al numero de argumentos
	mov edx, ecx
	
	mov esi, array 	; la direccion de array a esi	

ciclo:
	pop eax
	call stringcopy 
	add esi, 10
	dec ecx 
	cmp ecx,0
	jne ciclo 
	mov ecx, edx
	mov esi, array


impresion:
	mov eax, esi 	; apuitnamos a donde esta
	call sprintLF	; print
	add esi, 10

	dec ecx
	cmp ecx, 0
	jne impresion

salida:
	jmp quit 		; salida