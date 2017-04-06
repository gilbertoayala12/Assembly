; arreglo enteros y sacar el promedio
; gilberto ayala
; 6 de abril de 2017
%include 'funciones2.asm'
segment .bss
	array resb 100

section .text
	global _start
_start:
	pop ecx 	; obtenemos el numero de argumentos
	cmp ecx, 2	; comparamos si es menor a 2
	jl salida	; salimos si es menor a 2

	pop eax 	; obtenemos el nombre del programa
	dec ecx		; restamos 1 al numero de argumentos
	mov edx, ecx
	; mov edx, 0 	; ponemos en 0 edx
	mov esi, array 	; la direccion de array a esi

ciclo:
	; copiar programa despues del pop eax call atoi, add esi, 4 
	pop eax
	call atoi 
	mov [esi], eax
	add esi, 4
	dec ecx 
	cmp ecx,0
	jne ciclo 
	mov ecx, edx
	mov esi, array

impresion:
	mov eax, [esi] 	; apuitnamos a donde esta
	call iprintLF	; print
	add esi, 4

	dec ecx
	cmp ecx, 0
	jne impresion
	; add esi 4 
salida:
	jmp quit 		; salida