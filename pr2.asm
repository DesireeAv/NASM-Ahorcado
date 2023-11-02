%include 'macros.asm'

section .bss            ; donde se les asigna el tama;o de las variables
    
section .data ; segmento de datos y variables

    ; --Constantes ligadas al Kernel--
        sys_exit        EQU 	1
        sys_read        EQU 	3
        sys_write       EQU 	4
        sys_open        EQU     5
        sys_close       EQU     6
        sys_execve      EQU     11
        stdin           EQU 	0
        stdout          EQU 	1


inicio: db 'Iniciar Juego', 10, 10, 'Seleccione la dificultad:', 10, '1. Baja', 0xA, '2. Media',10, '3. Alta' 10, '4. Ir la Menú Anterior', 10, 0
longIni: equ $-Inicio

menuInicio: db '¡Bienvenido al Juego de Ahorcado!', 10, 10, 'Seleccione una opcion:', 10, '1. Iniciar juego', 0xA, '2. Salir', 10, 0
longMenu: equ $-menuInicio





; BAJA DIFICULTAD
pal1: db 'R A T A S', 10, 0
pa1: db '_ _ _ _ _', 10, 0
longpa1: equ $-pa1

pal1: db 'ZAPATO', 10, 0
longp1: equ $-pal1
pal1: db 'CHICLE', 10, 0
longp1: equ $-pal1
pal1: db 'PICADO', 10, 0
longp1: equ $-pal1
pa5: db 'D I S C R E T A', 10, 0
pa5l: db '_ _ _ _ _ _ _ _', 10, 0
longpa5l: equ $-pa5

; MEDIA DIFICULTAD
pb1: db 'IMAGINACION', 10, 0
longp1: equ $-pal1
pb2: db 'AUDICULARES', 10, 0
longp1: equ $-pal1
pb3: db 'LUXEMBURGO', 10, 0
longp1: equ $-pal1
pb4: db 'ARQUITECTURA', 10, 0
longp1: equ $-pal1
pb5: db 'OSTEOPOROSIS', 10, 0
longp1: equ $-pal1

; ALTA DIFICULTAD
pc1: db 'INDEPENDENCIA', 10, 0
longp1: equ $-pal1
pc2: db 'OTORRINOLARINGOLOGO', 10, 0
longp1: equ $-pal1
pc3: db 'ENCEFALORAQUIDEO', 10, 0
longp1: equ $-pal1
pc4: db 'PARALELEPIPEDO', 10, 0 ; 14
longp1: equ $-pal1

pc4l: db '_ _ _ _ _ _ _ _ _ _ _ _ _ _', 10, 0 ; 14
longp1: equ $-pal1
pc51: db 'E L E C T R O E N C E F A L O G R A F I S T A', 10, 0
longp1: equ $-pal1
pc5l: db '_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _', 10, 0
longp1: equ $-pal1















section .text

global _start

_start:

Inicio:
    ;xor rax, rax
    ;xor rbx, rbx
    imprimeEnPantalla menuInicio, longMenu
    leeTeclado      ; carga la variable a entrada
    cmp byte [entrada], '1' ; compara con el valor ASCII de 1
    je iniciar_juego
    jg cerrar_juego

    imprimeEnPantalla entradaEquivocada, longEntEq ; llega aquí si la entrada no era 1 ni 2
    jmp Inicio

cerrar_juego:
    imprimeEnPantalla despedida, longDespedida
    jmp SALIR

SALIR:
    salir

iniciar_juego:
    imprimeEnPantalla inicio, longIni
    leeTeclado
    cmp byte [entrada], '2'
    jl dif_baja
    je dif_media
    cmp byte [entrada], '3'
    je dif_alta
    jg Inicio


dif_baja:
    


     

dif_media:





dif_alta:






