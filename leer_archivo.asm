;leer archivo
;autor: gilberto


%include 'funciones2.asm'

segment .bss
    buffer resb 2048
    len equ $-buffer

section .text
    global _start

_start:
    pop ecx                                          ; numero de args 
    cmp ecx, 2                                       ; comprueba que hay almenos un argumento
    jl end

    pop eax                                          ; sacan el primer argumento
    dec ecx                                          ; restan un argumento

    
    pop ebx                                          ; nombre del archivo
    mov eax, sys_open                                ; leer operaciones

    mov ecx, O_RDONLY                                ; O_RDONLY = 0

    int 0x80                                         ; llamada del sistema
    cmp eax, 0                                       ; mayor del cero
    jle error

    ;====== Read file ======
    mov ebx, eax                                     ; mueve el archivo a ebx
    mov eax, sys_read                                ;vleer

    mov ecx, buffer                                  ; direccion de buffwer
    mov edx, len                                     ; longituyd buffer

    int 0x80                                         ; llamada al sistema 


    ;====== Close file ======
    mov eax, sys_close
    int 0x80

    mov eax, buffer
    call sprintLF

error:
    mov ebx, eax
    mov eax, sys_exit
    int 0x80

end:
    jmp quit