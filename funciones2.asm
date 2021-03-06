sys_exit equ 1
sys_read equ 3
sys_write equ 4
sys_open equ 5
sys_close equ 6
sys_sync equ 36
O_RDONLY equ 0
sys_create equ 8
O_RDWR equ 1 
stdin equ 0
stdout equ 1
stderr equ 3

slen:
	push ebx
	mov ebx, eax
nextchar:
	cmp byte [eax], 0
	jz finished
	inc eax
	jmp nextchar
finished:
	sub eax,ebx
	pop ebx
	ret
sprint:
	push edx
	push ecx
	push ebx
	push eax
	call slen
	mov edx, eax
	pop eax
	mov ecx, eax
	mov ebx , 1
	mov eax, 4
	int 80h
	pop ebx
	pop ecx
	pop edx
	ret
sprintLF:
	call sprint ;
	push eax ; guardamos el valor
	mov eax,0xA ; movemos el line deed o enter a eax
	push eax
	mov eax, esp ; direccion de stack pointer a eax
	call sprint ; imprimimos el LF
	pop eax ; recuperamos eax
	pop eax ; recuperamos eax
	ret ;regresamos
iprint:
	push eax ; salvamos eax en el stack (acumulador)
	push ecx ; salvamos ecx en el stack(contador)
	push edx ; salvamos edx en el stack(base)
	push esi ;salvamos esi en el stack(source index)
	mov ecx,0 ; vamos a contar cuantos bytes necesitamos imprimir
dividirloop:
	inc ecx ; incrementamos en 1 ecx
	mov edx, 0 ; limpiamos edx
	mov esi,10 ;guardamos 10 en esi, vamos a dividir entre 10
	idiv esi ; divide eax entre esi
	add edx,48 ; agrega el caracter 48 '0'
	push edx ; la representacion de ascii de nuestro numero
	cmp eax,0 ; se puede dividir mas el numero entero?
	jnz dividirloop ; jump if not zero(salta si no es cero)
imprimirloop:
	dec ecx ; vamos a contar hacia abajo cada byte en el stack
	mov eax, esp ; apuntador del stack a eax
	call sprint ;llamamos a la funcion sprint
	pop eax ; removemos el ultimo caracter del stack
	cmp ecx,0 ; ya imprimimos todos los bytes del stack?
	jnz imprimirloop ; todavia hay numeros que imprimir?
	pop esi ; re- establecemos el valor de esi
	pop edx ; re- establecemos el valor de edx
	pop ecx ; re- establecemos el valor de ecx
	pop eax ; re- establecemos el valor de eax
	ret ; regresamos
iprintLF:
	call iprint ; Imprimimos el numero
	push eax ; Salvamos el dato que tenemos en el acumulador
	mov eax,0xA ; Copiamos el line fed a eax
	push eax ; Salvamos el line feed en el stack
	mov eax, esp ; Copiamos el apuntador del stack a eax
	call sprint ; Imprimimos el line feed
	pop EAX ; Removemos el linefeed del stack
	pop EAX ; Reestablecemos el dato que traiamos en el eax
	ret
atoi:
	push ebx ; Preservamos ebx
	push ecx ; Preservamos ecx
	push edx ; Preservamos edx
	push esi ; Preservamos esi
	mov esi,eax ; Nuestro numero a convertir va a esi
	mov eax,0 ; Iniciamos a cero eax
	mov ecx,0 ; Inicializamos a cero ecx
ciclomult: ; Ciclo multiplicacion
	xor ebx,ebx ; Reseteamos a 0 ebx, tanto bh como bl
	mov bl,[esi+ecx]; Movemos un solo byte a la parte baja de ebx
	cmp bl, 48 ; Comparamos con ascci '0'
	jl finalizado ; Si es menor, saltamos a finalizado
	cmp bl,57 ; Comparamos con ascci '9'
	jg finalizado ; Si es mayor, saltamos a finalizado
	cmp bl,10 ; Comparamos con linefeed
	je finalizado ; Si es igual saltamos a finalizado
	cmp bl,0 ; Comparamos con caracter null (Fin de cadena)
	jz finalizado ; Si es cero saltamos a finalizado
	sub bl,48 ; Convertimos el caracter en entero
	add eax,ebx ; Agregamos el valor a eax
	mov ebx,10 ; Movemos el decimas 10 a ebx
	mul ebx ; Multiplicamos eax por ebc para obtener el I...
	inc ecx ; Incrementamos ecx (Contador)
	jmp ciclomult ; Seguimos nuestro ciclo de multiplicacion
finalizado:
	mov ebx,10 ; Movemos el valor decimal 10 a ebx
	div ebx ; Dividimos eax entre 10
	pop esi ; Re-establecemos esi
	pop edx ; Re-establecemos edx
	pop ecx ; Re-establecemos ecx
	pop ebx ; Re-establecemos ebx
	ret
; recibe grados farenheit en eax
ftoc:
	sub EAX, 32 ; restamos primero el 32 de la formula c=((F-32)*5)/9
	imul EAX, 5	; multiplicamos eax por 5 y lo dejamos ahi
	push EDX	; salvamos edx en el stack para poder ponerlo 0 por algo en especifico
	mov EDX, 0	;
	push EBX	; salvamos registro por que es una funcion para no alterar registros 
	mov ebx, 9	; 
	div EBX		; dividimos eax por lo que ponemos ahi
	pop EBX 	; popeamos el registro
	pop EDX		; same 
	ret
; recibe grados celsius en eax formula F= ((C + 32)*9)/5
ctof:
	imul eax, 9 
	push edx
	mov edx,0
	push ebx
	mov ebx, 5
	div ebx
	pop ebx
	pop edx
	add eax, 32
	ret



stringcopy:
	push ecx 	;salvamos ecx en stack
	push ebx 
	mov ebx, 0
	mov ecx, 0
	mov ebx, eax
.sigcar:
	mov BL, byte[Eax]
	mov byte[esi+ecx], bl	;movemos un caracter
	cmp byte[eax],0	;comparamos el byte que es a ver si es 0
	jz .finalizar 	; jump if zero a finalizado
	inc eax			; inc el acomulador
	inc ecx
	jmp .sigcar

.finalizar:
	pop ebx
	pop ecx
	ret
; leer funcion acepta buffer en ecx, acepta longitudde buffer en edx
; copystring
copystring:
	push ecx 	;salvamos ecx en stack
	push ebx 
	mov ebx, 0
	mov ecx, 0
	mov ebx, eax
.sigcar:
	mov BL, byte[Eax]
	cmp bl, 0xA
	je .salto
	mov byte[esi+ecx], bl	;movemos un caracter
	cmp byte[eax],0	;comparamos el byte que es a ver si es 0
	jz .finalizar 	; jump if zero a finalizado
	
.salto:
	inc eax
	inc ecx
	jmp .sigcar

.finalizar:
	pop ebx
	pop ecx
	ret



; copystring
LeerTexto:
	mov eax, sys_read
	mov ebx, stdin
	int 0x80
	ret
quit:
	mov EAX, sys_exit 	; sys_exit

	int 0x80 			; llamada a kernel