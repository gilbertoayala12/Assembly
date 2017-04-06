; arreglo enteros
; gilberto ayala
; 6 de abril de 2017
%include 'funciones2.asm'
segment .bss
	array resb 100

section .text
	global _start
_start:

ciclo:
; copiar programa despues del pop eax call atoi, add esi, 4 
impresion:
; add esi 4 