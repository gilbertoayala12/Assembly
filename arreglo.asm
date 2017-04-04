; arreglo.asm
; gilberto ayala
; 3 de abril 

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
	mov edx, 0 	; ponemos en 0 edx
	mov esi, array 	; la direccion de array a esi

ciclo:
	pop ebx		; saacamos direccion de ebx
	mov eax, 0	; limpiamos eax
	mov al, byte[ebx]	;mopves un byte de ebx a al
	mov byte[esi+edx], al	;movemos el byyte de al a la suma
	inc edx			; incrementamos edx
	dec ecx			; decrementamos el numero de argumentos
	cmp ecx, 0 		; preguntamos si ya es zero
	jne ciclo 		; cilcar en caso de ya sabes que c

impresion:
	mov eax, array 	; apuitnamos a donde esta
	call sprintLF	; print

salida:
	jmp quit 		; salida