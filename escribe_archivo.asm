; escribe_archivo.asm
; gilberto ayala



%include 'funciones2.asm'

segment .bss
	buffer_alumno resb 30
	len_alumno equ $ - buffer_alumno
	filename resb 30
	len_filename equ $-filename
	archivo resb 30
section .data;
	msg_nombre db "escribe tu nombre: ",0x0
	msg_archivo db "escribe el nombre del archivo: ",0x0
section .text
	GLOBAL _start

_start:
	mov eax, msg_nombre
	call sprint

	mov ecx, buffer_alumno
	mov edx, len_alumno
	call LeerTexto

	mov eax, msg_archivo
	call sprint

	mov ecx, filename
	mov edx, len_filename
	call LeerTexto

	; usamos esi para el copystring
	mov esi, archivo
	mov eax, filename
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
	mov ecx, buffer_alumno
	mov edx, len_alumno
	int 0x80
	mov eax, sys_sync		; sys_sync
	int 0x80
 ;====== Close file ======
    mov eax, sys_close
    int 0x80
    
salida:
	jmp quit
error:
	mov ebx,eax			;
	mov eax,sys_exit	;
	int 0x80 			;
