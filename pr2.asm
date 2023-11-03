

        %macro imprimeEnPantalla 2
                mov     eax, sys_write     	; opción 4 de las interrupciones del kernel.
                mov     ebx, stdout        	; standar output.
                mov     ecx, %1            	; mensaje.
                mov     edx, %2            	; longitud.
                int     0x80
        %endmacro

        %macro salir 0
            mov eax,1
		    mov ebx,0
            int 80h
        %endmacro

        %macro leeTeclado 0
                mov     eax,     sys_read      ; opción 3 de las interrupciones del kernel.
                mov     ebx,     stdin         ; standar input.
                mov     ecx,     entrada       ; dirección de memoria reservada para almacenar la entrada del teclado.
                mov     edx,     8             ; número de bytes a leer.
                int     0x80
        %endmacro


; nasm -f elf64 pr2.asm -o pr2.o && ld pr2.o -o pr2

%macro palabraRandom 1
    rdtsc
    shl     rdx, 32           ; Shift the high 32 bits to the left
    or      rax, rdx          ; Combine low and high parts into rax
    xor     rdx, rdx          ; Clear rdx for division
    mov     rcx, 5            ; 5 for generating numbers from 1 to 5
    div     rcx               ; Divide rax by rcx
    add     dl, '0'           ; Convert the result to ASCII (1 to 5)
    mov     [%1], dl          ; Store the random number in "aleatorio"
%endmacro

%macro limpiaRegistros 0
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
%endmacro

section .bss            ; donde se les asigna el tama;o de las variables
    entrada: resb 10     ; digito de entrada
    randInt: resb 1         ; variable del numero random




    
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


inicio: db 'Iniciar Juego', 10, 10, 'Seleccione la dificultad:', 10, '1. Baja, 2. Media, 3. Alta, 4. Ir la Menú Anterior', 10, 0
longIni: equ $-inicio

menuInicio: db '¡Bienvenido al Juego de Ahorcado!', 10, 10, 'Seleccione una opcion:', 10, '1. Iniciar juego', 0xA, '2. Salir', 10, 0
longMenu: equ $-menuInicio

entradaEquivocada: db 'Entrada equivocada, inténtelo de nuevo.', 10, 0
longEntEq: equ $-entradaEquivocada


despedida: db 'Gracias por jugar!', 10
longDespedida equ $-despedida


; MENSAJE DE DIFICULTADES
difA: db 10,'Juego de Ahorcado - Dificultad: BAJA',10, 0
longdifA: equ $-difA

difB: db 10,'Juego de Ahorcado - Dificultad: MEDIA',10, 0
longdifB: equ $-difB

difC: db 10,'Juego de Ahorcado - Dificultad: ALTA',10, 0
longdifC: equ $-difC

Palabra: db 10,'Palabra: ', 0
longPalabra: equ $-Palabra

guessword: db 10,'Palabra a adivinar: ', 0
longguessword: equ $-guessword

pidoLetra: db 10, 'Ingrese la letra a adivinar: ', 0
longpidoLetra: equ $-pidoLetra






; PALABRAS:

; BAJA DIFICULTAD
pa1: db 'R A T A S',10, 0
pa1l: db '_ _ _ _ _',10, 0
na1: db '5',10,0
longpa1: equ $-pa1l

pa2: db 'Z A P A T O ', 10, 0
pa2l: db '_ _ _ _ _ _ ',10, 0
longpa2: equ $-pa2l
na2: db '6',10,0


pa3: db 'C H I C L E ',10, 0
pa3l: db '_ _ _ _ _ _ ', 10, 0
longpa3: equ $-pa3l
na3: db '6',10,0


pa4: db 'P I C A D O ', 10, 0
pa4l: db '_ _ _ _ _ _ ', 10, 0
longpa4: equ $-pa4l
na4: db '6',10,0


pa5: db 'D I S C R E T A ', 10, 0
pa5l: db '_ _ _ _ _ _ _ _ ', 10, 0
longpa5: equ $-pa5l
na5: db '8',10,0




; MEDIA DIFICULTAD
pb1: db 'I M A G I N A C I O N', 10, 0          ;11
pb1l: db '_ _ _ _ _ _ _ _ _ _ _', 10, 0
longpb1: equ $-pb1l
nb1: db '11',10,0

pb2: db 'A U D I C U L A R E S', 10, 0
pb2l: db '_ _ _ _ _ _ _ _ _ _ _', 10, 0
longpb2: equ $-pb2l
nb2: db '11',10,0

pb3: db 'L U X E M B U R G O ', 10, 0            ;10
pb3l: db '_ _ _ _ _ _ _ _ _ _ _ _ ', 10, 0
longpb3: equ $-pb3l
nb3: db '10',10,0

pb4: db 'A R Q U I T E C T U R A ', 10, 0         ;12
pb4l: db '_ _ _ _ _ _ _ _ _ _ _ _ ', 10, 0
longpb4: equ $-pb4l
nb4: db '12',10,0

pb5: db 'O S T E O P O R O S I S ', 10, 0
pb5l: db '_ _ _ _ _ _ _ _ _ _ _ _ ', 10, 0
longpb5: equ $-pb5l
nb5: db '12',10,0



; ALTA DIFICULTAD
pc1: db 'I N D E P E N D E N C I A', 10, 0  ;13

pc1l: db '_ _ _ _ _ _ _ _ _ _ _ _ _', 10, 0
longpc1: equ $-pc1l
nc1: db '13',10,0

pc2: db 'O T O R R I N O L A R I N G O L O G O', 10, 0  ;19
pc2l: db '_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _', 10, 0
longpc2: equ $-pc2l
nc2: db '19',10,0

pc3: db 'E N C E F A L O R A Q U I D E O ', 10, 0   ;16
pc3l: db '_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ', 10, 0
longpc3: equ $-pc3l
nc3: db '16',10,0

pc4: db 'P A R A L E L E P I P E D O ', 10, 0 ; 14
pc4l: db '_ _ _ _ _ _ _ _ _ _ _ _ _ _ ', 10, 0 ; 14
longpc4: equ $-pc4l
nc4: db '14',10,0

pc5: db 'E L E C T R O E N C E F A L O G R A F I S T A', 10, 0 ;23
pc5l: db '_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _', 10, 0
longpc5: equ $-pc5l
nc5: db '23',10,0










section .text

global _start

_start:

Inicio:
    xor al, al
    xor esi, esi
    xor edi, edi
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
    ;imprimeEnPantalla '23', 2
    leeTeclado
    cmp byte [entrada], '2'
    jl dif_baja
    je dif_media
    cmp byte [entrada], '3'
    je dif_alta
    jg Inicio


dif_baja:                   ; se selecciona un numero random
    palabraRandom randInt   ; genera el numero random
    cmp byte [randInt], '1'
    jl palabra_pa1          ; estos van a hacer los que mueven las palabras a los diferentes registros
    je palabra_pa2
    cmp byte [randInt], '2'
    je palabra_pa3
    cmp byte [randInt], '3'
    je palabra_pa4
    jg palabra_pa5



    ;jmp SALIR


     

dif_media:
    palabraRandom randInt
    cmp byte [randInt], '1'
    jl palabra_pb1          ; estos van a hacer los que mueven las palabras a los diferentes registros
    je palabra_pb2
    cmp byte [randInt], '2'
    je palabra_pb3
    cmp byte [randInt], '3'
    je palabra_pb4
    jg palabra_pb5

    ;jmp SALIR




dif_alta:
    palabraRandom randInt
    cmp byte [randInt], '1'
    jl palabra_pc1                      ; estos van a hacer los que mueven las palabras a los diferentes registros
    je palabra_pc2
    cmp byte [randInt], '2'
    je palabra_pc3
    cmp byte [randInt], '3'
    je palabra_pc4
    jg palabra_pc5

    ;jmp SALIR





; PONE LAS PALABRAS DE DIFICULTAD BAJA EN EL REGISTRO CORRESPONDIENTE
palabra_pa1:                            ; estos son los que mueven las palabras a los diferentes registros
    imprimeEnPantalla difA, longdifA    ; imprime la dificultad
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla na1, 2                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pa1l, longpa1
    mov al, 5                                   ; en al esta la cantidad de turnos restantes o disponibles
    mov esi, pa1
    mov edi, pa1l
    jmp comp_letras

palabra_pa2:
    imprimeEnPantalla difA, longdifA
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla na2, 2
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pa2l, longpa2
    mov al,6
    mov esi, pa2
    mov edi, pa2l
    jmp comp_letras

palabra_pa3:
    imprimeEnPantalla difA, longdifA
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla na3, 2
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pa3l, longpa3
    mov al, 6
    mov esi, pa3
    mov edi, pa3l
    jmp comp_letras

palabra_pa4:
    imprimeEnPantalla difA, longdifA
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla na4, 2
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pa4l, longpa4
    mov al, 6
    mov esi, pa4
    mov edi, pa4l
    jmp comp_letras

palabra_pa5:
    imprimeEnPantalla difA, longdifA
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla na5, 2                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pa5l, longpa5
    mov al, 8
    mov esi, pa5
    mov edi, pa5l
    jmp comp_letras





; PONE LAS PALABRAS DE DIFICULTAD MEDIA EN EL REGISTRO CORRESPONDIENTE
palabra_pb1:                ; estos son los que mueven las palabras a los diferentes registros
    imprimeEnPantalla difB, longdifB
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nb1, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pb1l, longpb1
    mov al, 11
    mov esi, pb1
    mov edi, pb1l
    jmp comp_letras

palabra_pb2:
    imprimeEnPantalla difB, longdifB
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nb2, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pb2l, longpb2
    mov al, 11
    mov esi, pb2
    mov edi, pb2l
    jmp comp_letras

palabra_pb3:
    imprimeEnPantalla difB, longdifB
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nb3, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pb3l, longpb3
    mov al,10
    mov esi, pb3
    mov edi, pb3l
    jmp comp_letras

palabra_pb4:
    imprimeEnPantalla difB, longdifB
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nb4, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pb4l, longpb4
    mov al,12
    mov esi, pb4
    mov edi, pb4l
    jmp comp_letras

palabra_pb5:
    imprimeEnPantalla difB, longdifB
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nb5, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pb5l, longpb5
    mov al, 12
    mov esi, pb5
    mov edi, pb5l
    jmp comp_letras




; PONE LAS PALABRAS DE DIFICULTAD ALTA EN EL REGISTRO CORRESPONDIENTE

palabra_pc1:                ; estos son los que mueven las palabras a los diferentes registros
    imprimeEnPantalla difC, longdifC
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nc1, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pc1l, longpc1
    mov al, 13
    mov esi, pc1
    mov edi, pc1l
    jmp comp_letras

palabra_pc2:
    imprimeEnPantalla difC, longdifC
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nc2, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pc2l, longpc2
    mov al, 19
    mov esi, pc2
    mov edi, pc2l
    jmp comp_letras

palabra_pc3:
    imprimeEnPantalla difC, longdifC
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nc3, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pc3l, longpc3
    mov al, 16
    mov esi, pc3
    mov edi, pc3l
    jmp comp_letras

palabra_pc4:
    imprimeEnPantalla difC, longdifC
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nc4, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pc4l, longpc4
    mov al, 14
    mov esi, pc4
    mov edi, pc4l
    jmp comp_letras

palabra_pc5:
    imprimeEnPantalla difC, longdifC
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nc5, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pc5l, longpc5
    mov al, 23
    mov esi, pc5
    mov edi, pc5l
    jmp comp_letras




comp_letras:
    imprimeEnPantalla pidoLetra, longpidoLetra
    leeTeclado
    jmp compara_letra

compara_letra:
    mov bl, byte[entrada]                           ; se mueve a bl la letra a ingresar
    cmp byte[entrada], 10
    je letra_no_en_la_palabla
    cmp bl, byte[esi]                               ; se compara la entrada con la letra actual
    jne letras_no_iguales
    je letras_iguales


letra_no_en_la_palabla:
    jmp SALIR

letras_iguales:
    mov byte[edi], bl
    mov byte[edi], 2
    limpiaRegistros
    ;mov pa3, edi
    imprimeEnPantalla edi, longpa3
    mov byte[esi], 2

    jmp SALIR


letras_no_iguales:
    ;sub al, 1                                       ; aqui va restandole uno a la cantidad 
                                                    ;de turnos que le quedan disponibles
    cmp al, 0
    je no_tiene_jugadas_disponibles

    mov byte[esi], 2
    cmp byte[esi], 
    ;imprimeEnPantalla pidoLetra, longpidoLetra
    ;leeTeclado

    ;jmp compara_letra



no_tiene_jugadas_disponibles:
    jmp SALIR
imprime_msjsA:
    jmp SALIR


imprime_msjsB:
    jmp SALIR

imprime_msjsC:
    jmp SALIR








; PIDE EN ENTRADA LA LETRA A ADIVINAR
pedir_letra:



    ;cmp byte [entrada], '1'





