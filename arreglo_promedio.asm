%include 'funciones2.asm'
section .data
	
	msg DB "El promedio es: ", 0x0

segment .bss
	num_arg RESB 4
	array resb 100

section .text
	GLOBAL _start

_start:
	
	pop ecx 	; obtenemos el numero de argumentos

	cmp ecx, 2	; comparamos si es menor a 2
	jl salida	; salimos si es menor a 2

	pop eax 	; obtenemos el nombre del programa
	dec ecx		; restamos 1 al numero de argumentos
	mov [num_arg], ecx		; guardamos numero de args
	
	
	mov esi, array 	; la direccion de array a esi

ciclo:
	; copiar programa despues del pop eax call atoi, add esi, 4 
	pop eax	;guardamos en el stk
	call atoi ; lo convertimos a numero
	mov [esi], eax
	
	add esi, 4
	dec ecx 
	cmp ecx,0
	jne ciclo 

mov ecx, [num_arg]	
mov esi, array

impresion:
	mov eax, [esi] 	; apuitnamos a donde esta
	add ebx, eax	; print
	add esi, 4		; nos movemos 4 

	dec ecx
	cmp ecx, 0
	jne impresion
	; add esi 4 
	; add esi 4 
mov eax, msg
call sprint
mov eax, ebx	; traemos la suma
mov ecx, [num_arg]	;numero de args a ecx
idiv ecx	; dividimos
call iprintLF

salida:
	jmp quit