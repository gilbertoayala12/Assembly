; multiplica
; gilberto ayala 
%include 'funciones2.asm'
section .text
	GLOBAL _start
_start:

	pop ecx
	cmp ecx, 3
	jl end
	pop eax



	pop eax
	call atoi
	mov ebx, eax
	pop eax
	call atoi 
	imul eax, ebx
	call iprintLF
	
end:
	jmp quit