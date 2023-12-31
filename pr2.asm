

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


inicio: db 'Iniciar Juego', 10, 10, 'Seleccione la dificultad:', 10, '1. Baja',10,'2. Media',10, '3. Alta',10, '4. Ir la Menú Anterior', 10, 0
longIni: equ $-inicio

menuInicio: db '¡Bienvenido al Juego de Ahorcado!', 10, 10, 'Seleccione una opcion:', 10, '1. Iniciar juego', 0xA, '2. Salir', 10, 0
longMenu: equ $-menuInicio

entradaEquivocada: db 'Entrada equivocada, inténtelo de nuevo.', 10, 0
longEntEq: equ $-entradaEquivocada


despedida: db '¡Gracias por jugar!', 10
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

pidoLetra: db 10, 'Letra solicitada: ', 0
longpidoLetra: equ $-pidoLetra


gameover: db 10, 'Lo siento, no quedan más intentos. Game Over.',10, 0
longgameover: equ $-gameover

gane: db 10, '¡Felicidades! Ha ganado el juego.', 10,10, 0
longgane: equ $-gane



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

pb4: db 'A R Q U I T E C T U R A', 10, 0         ;12
pb4l: db '_ _ _ _ _ _ _ _ _ _ _ _', 10, 0
longpb4: equ $-pb4l
nb4: db '12',10,0

pb5: db 'O S T E O P O R O S I S', 10, 0
pb5l: db '_ _ _ _ _ _ _ _ _ _ _ _', 10, 0
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
    xor al, al          ; limpia los registros de el numero de palabra
    xor cl, cl          ; limpia el registro de longitud de string
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


dif_baja:
    imprimeEnPantalla difA, longdifA    ; imprime la dificultad
                       ; se selecciona un numero random
    palabraRandom randInt   ; genera el numero random
    cmp byte [randInt], '1'
    jl palabra_pa1A          ; estos van a hacer los que mueven las palabras a los diferentes registros
    je palabra_pa2A
    cmp byte [randInt], '2'
    je palabra_pa3A
    cmp byte [randInt], '3'
    je palabra_pa4A
    jg palabra_pa5A


palabra_pa1A:
    mov r8, 4               ; lo que hace es pone la cantidad de intentos en la long de la palabras
    jmp palabra_pa1

palabra_pa2A:
    mov r8, 5
    jmp palabra_pa2

palabra_pa3A:
    mov r8, 5
    jmp palabra_pa3

palabra_pa4A:
    mov r8, 5
    jmp palabra_pa4

palabra_pa5A:
    mov r8, 7
    jmp palabra_pa5


     

dif_media:
    imprimeEnPantalla difB, longdifB    ; imprime la dificultad
    palabraRandom randInt
    cmp byte [randInt], '1'
    jl palabra_pb1B          ; estos van a hacer los que mueven las palabras a los diferentes registros
    je palabra_pb2B
    cmp byte [randInt], '2'
    je palabra_pb3B
    cmp byte [randInt], '3'
    je palabra_pb4B
    jg palabra_pb5B


palabra_pb1B:
    mov r8, 10
    jmp palabra_pb1

palabra_pb2B:
    mov r8, 10
    jmp palabra_pb2

palabra_pb3B:
    mov r8, 9
    jmp palabra_pb3

palabra_pb4B:
    mov r8, 11
    jmp palabra_pb4

palabra_pb5B:
    mov r8, 11
    jmp palabra_pb5



dif_alta:
    imprimeEnPantalla difC, longdifC    ; imprime la dificultad
    palabraRandom randInt
    cmp byte [randInt], '1'
    jl palabra_pc1c                      ; estos van a hacer los que mueven las palabras a los diferentes registros
    je palabra_pc2c
    cmp byte [randInt], '2'
    je palabra_pc3c
    cmp byte [randInt], '3'
    je palabra_pc4c
    jg palabra_pc5c

    ;jmp SALIR


palabra_pc1c:
    mov r8,12 
    jmp palabra_pc1

palabra_pc2c:
    mov r8, 18
    jmp palabra_pc2

palabra_pc3c:
    mov r8, 15
    jmp palabra_pc3

palabra_pc4c:
    mov r8, 13
    jmp palabra_pc4

palabra_pc5c:
    mov r8, 22
    jmp palabra_pc5





; PONE LAS PALABRAS DE DIFICULTAD BAJA EN EL REGISTRO CORRESPONDIENTE
palabra_pa1:                            ; estos son los que mueven las palabras a los diferentes registros
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla na1, 2                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra      ; imprime "Palabra: "
    imprimeEnPantalla pa1l, 10
    xor edi, edi                ; limpia registros
    xor esi, esi                                ; en al esta la cantidad de turnos restantes o disponibles
    mov rdx, longpa1
    mov esi, pa1
    mov edi, pa1l
    jmp comp_letraspa1

palabra_pa2:
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla na2, 2
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pa2l, 11
    xor edi, edi                ; limpia registros
    xor esi, esi
    mov rdx, longpa2
    mov esi, pa2
    mov edi, pa2l
    jmp comp_letraspa2

palabra_pa3:
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla na3, 2
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pa3l, 11
    xor edi, edi                ; limpia registros
    xor esi, esi
    mov rdx, longpa3
    mov esi, pa3
    mov edi, pa3l
    jmp comp_letraspa3

palabra_pa4:
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla na4, 2
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pa4l, 11
    xor edi, edi                ; limpia registros
    xor esi, esi
    mov rdx, longpa4
    mov esi, pa4
    mov edi, pa4l
    jmp comp_letraspa4

palabra_pa5:
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla na5, 2                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pa5l, 13
    xor edi, edi                ; limpia registros
    xor esi, esi
    mov rdx, longpa5
    mov esi, pa5
    mov edi, pa5l
    jmp comp_letraspa5





; PONE LAS PALABRAS DE DIFICULTAD MEDIA EN EL REGISTRO CORRESPONDIENTE
palabra_pb1:                ; estos son los que mueven las palabras a los diferentes registros
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nb1, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pb1l, 22
    xor edi, edi                ; limpia registros
    xor esi, esi
    mov rdx, longpb1
    mov esi, pb1
    mov edi, pb1l
    jmp comp_letraspb1

palabra_pb2:
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nb2, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pb2l, 22
    xor edi, edi                ; limpia registros
    xor esi, esi
    mov rdx, longpb2
    mov esi, pb2
    mov edi, pb2l
    jmp comp_letraspb2

palabra_pb3:
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nb3, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pb3l, 21
    xor edi, edi                ; limpia registros
    xor esi, esi
    mov rdx, longpb3
    mov esi, pb3
    mov edi, pb3l
    jmp comp_letraspb3

palabra_pb4:
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nb4, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pb4l, 23
    xor edi, edi                ; limpia registros
    xor esi, esi
    mov rdx, longpb4
    mov esi, pb4
    mov edi, pb4l
    jmp comp_letraspb4

palabra_pb5:
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nb5, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pb5l, 23
    xor edi, edi                ; limpia registros
    xor esi, esi
    mov rdx, longpb5
    mov esi, pb5
    mov edi, pb5l
    jmp comp_letraspb5




; PONE LAS PALABRAS DE DIFICULTAD ALTA EN EL REGISTRO CORRESPONDIENTE

palabra_pc1:                ; estos son los que mueven las palabras a los diferentes registros
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nc1, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pc1l, 26
    xor edi, edi                ; limpia registros
    xor esi, esi
    mov rdx, longpc1
    mov esi, pc1
    mov edi, pc1l
    jmp comp_letraspc1

palabra_pc2:
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nc2, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pc2l, 38
    xor edi, edi                ; limpia registros
    xor esi, esi
    mov rdx, longpc2
    mov esi, pc2
    mov edi, pc2l
    jmp comp_letraspc2

palabra_pc3:
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nc3, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pc3l, 33
    xor edi, edi                ; limpia registros
    xor esi, esi
    mov rdx, longpc3
    mov esi, pc3
    mov edi, pc3l
    jmp comp_letraspc3

palabra_pc4:
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nc4, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pc4l, 29
    xor edi, edi                ; limpia registros
    xor esi, esi
    mov rdx, longpc4
    mov esi, pc4
    mov edi, pc4l
    jmp comp_letraspc4

palabra_pc5:
    imprimeEnPantalla guessword, longguessword  ; imprime "Palabra a adivinar: "
    imprimeEnPantalla nc5, 3                    ; imprime la longitud de la palabra
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pc5l, 46
    xor edi, edi                ; limpia registros
    xor esi, esi
    mov rdx, longpc5
    mov esi, pc5
    mov edi, pc5l
    jmp comp_letraspc5













comp_letraspa1:
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor bl, bl
    imprimeEnPantalla pidoLetra, longpidoLetra
    leeTeclado
    mov bl, byte[entrada]                           ; se mueve a bl la letra a ingresar
    jmp compara_letrapa1


compara_letrapa1:
    cmp r8, 0
    je PERDIO
    cmp byte[esi], 0
    je palabra_revisadapa1      ; si ya se acabo el string(caracter 10), imprime lo que hay en esi y vuelve a pedir la entrada
    cmp byte[esi], bl
    jne no_en_este_guionpa1
    mov byte[edi], bl           ;cambia en los guiones la letra
    inc edi                     ; avanza 2 en los guiones
    inc esi                     ; avanza 2 en la palabra
    ;jmp palabra_revisadapa1
    jmp compara_letrapa1


palabra_revisadapa1:
    dec r8                     ; decrementar el numero de intentos restantes
    ;dec al
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    mov esi, pa1
    mov edi, pa1l
    jmp compara_palabras_looppa1


no_en_este_guionpa1:
    inc esi
    inc edi
    jmp compara_letrapa1





compara_palabras_looppa1:
    xor al, al
    xor bl, bl
    mov al, byte[esi]
    inc esi
    mov bl, byte[edi]
    inc edi
    cmp al, bl
    jne palabra_pa1     ; si no on iguales, brinca a pedir again la entrada
    cmp al, 0           ; si se llego al final, gano la persona
    je GANOpa1
    jmp compara_palabras_looppa1       ; si no, siga pidiendo la entrada y todo normalmente




GANOpa1:
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pa1, 10
    limpiaRegistros
    imprimeEnPantalla gane, longgane
    jmp SALIR







comp_letraspa2:
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor bl, bl
    imprimeEnPantalla pidoLetra, longpidoLetra
    leeTeclado
    mov bl, byte[entrada]                           ; se mueve a bl la letra a ingresar
    jmp compara_letrapa2

compara_letrapa2:
    cmp r8, 0
    je PERDIO
    cmp byte[esi], 0
    je palabra_revisadapa2      ; si ya se acabo el string(caracter 10), imprime lo que hay en esi y vuelve a pedir la entrada
    cmp byte[esi], bl
    jne no_en_este_guionpa2
    mov byte[edi], bl           ;cambia en los guiones la letra
    inc edi                     ; avanza 2 en los guiones
    inc esi                     ; avanza 2 en la palabra
    ;jmp palabra_revisadapa2
    jmp compara_letrapa2

palabra_revisadapa2:
    dec r8                     ; decrementar el numero de intentos restantes
    ;dec al
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    mov esi, pa2
    mov edi, pa2l
    jmp compara_palabras_looppa2

no_en_este_guionpa2:
    inc esi
    inc edi
    jmp compara_letrapa2

compara_palabras_looppa2:
    xor al, al
    xor bl, bl
    mov al, byte[esi]
    inc esi
    mov bl, byte[edi]
    inc edi
    cmp al, bl
    jne palabra_pa2     ; si no on iguales, brinca a pedir again la entrada
    cmp al, 0           ; si se llego al final, gano la persona
    je GANOpa2
    jmp compara_palabras_looppa2       ; si no, siga pidiendo la entrada y todo normalmente

GANOpa2:
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pa2, 11
    limpiaRegistros
    imprimeEnPantalla gane, longgane
    jmp SALIR
    
    
    
    
    
    
    
    
    
    
    
    
    
comp_letraspa3:
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor bl, bl
    imprimeEnPantalla pidoLetra, longpidoLetra
    leeTeclado
    mov bl, byte[entrada]                           ; se mueve a bl la letra a ingresar
    jmp compara_letrapa3

compara_letrapa3:
    cmp r8, 0
    je PERDIO
    cmp byte[esi], 0
    je palabra_revisadapa3      ; si ya se acabo el string(caracter 10), imprime lo que hay en esi y vuelve a pedir la entrada
    cmp byte[esi], bl
    jne no_en_este_guionpa3
    mov byte[edi], bl           ;cambia en los guiones la letra
    inc edi                     ; avanza 2 en los guiones
    inc esi                     ; avanza 2 en la palabra
    ;jmp palabra_revisadapa3
    jmp compara_letrapa3

palabra_revisadapa3:
    dec r8                     ; decrementar el numero de intentos restantes
    ;dec al
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    mov esi, pa3
    mov edi, pa3l
    jmp compara_palabras_looppa3

no_en_este_guionpa3:
    inc esi
    inc edi
    jmp compara_letrapa3

compara_palabras_looppa3:
    xor al, al
    xor bl, bl
    mov al, byte[esi]
    inc esi
    mov bl, byte[edi]
    inc edi
    cmp al, bl
    jne palabra_pa4     ; si no on iguales, brinca a pedir again la entrada
    cmp al, 0           ; si se llego al final, gano la persona
    je GANOpa3
    jmp compara_palabras_looppa3       ; si no, siga pidiendo la entrada y todo normalmente

GANOpa3:
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pa3, 11
    limpiaRegistros
    imprimeEnPantalla gane, longgane
    jmp SALIR








comp_letraspa4:
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor bl, bl
    imprimeEnPantalla pidoLetra, longpidoLetra
    leeTeclado
    mov bl, byte[entrada]                           ; se mueve a bl la letra a ingresar
    jmp compara_letrapa4

compara_letrapa4:
    cmp r8, 0
    je PERDIO
    cmp byte[esi], 0
    je palabra_revisadapa4      ; si ya se acabo el string(caracter 10), imprime lo que hay en esi y vuelve a pedir la entrada
    cmp byte[esi], bl
    jne no_en_este_guionpa4
    mov byte[edi], bl           ;cambia en los guiones la letra
    inc edi                     ; avanza 2 en los guiones
    inc esi                     ; avanza 2 en la palabra
    ;jmp palabra_revisadapa4
    jmp compara_letrapa4

palabra_revisadapa4:
    dec r8                     ; decrementar el numero de intentos restantes
    ;dec al
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    mov esi, pa4
    mov edi, pa4l
    jmp compara_palabras_looppa4

no_en_este_guionpa4:
    inc esi
    inc edi
    jmp compara_letrapa4

compara_palabras_looppa4:
    xor al, al
    xor bl, bl
    mov al, byte[esi]
    inc esi
    mov bl, byte[edi]
    inc edi
    cmp al, bl
    jne palabra_pa1     ; si no on iguales, brinca a pedir again la entrada
    cmp al, 0           ; si se llego al final, gano la persona
    je GANOpa1
    jmp compara_palabras_looppa4       ; si no, siga pidiendo la entrada y todo normalmente

GANOpa4:
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pa4, 11
    limpiaRegistros
    imprimeEnPantalla gane, longgane
    jmp SALIR










comp_letraspa5:
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor bl, bl
    imprimeEnPantalla pidoLetra, longpidoLetra
    leeTeclado
    mov bl, byte[entrada]                           ; se mueve a bl la letra a ingresar
    jmp compara_letrapa5

compara_letrapa5:
    cmp r8, 0
    je PERDIO
    cmp byte[esi], 0
    je palabra_revisadapa5      ; si ya se acabo el string(caracter 10), imprime lo que hay en esi y vuelve a pedir la entrada
    cmp byte[esi], bl
    jne no_en_este_guionpa5
    mov byte[edi], bl           ;cambia en los guiones la letra
    inc edi                     ; avanza 2 en los guiones
    inc esi                     ; avanza 2 en la palabra
    ;jmp palabra_revisadapa5
    jmp compara_letrapa5

palabra_revisadapa5:
    dec r8                     ; decrementar el numero de intentos restantes
    ;dec al
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    mov esi, pa5
    mov edi, pa5l
    jmp compara_palabras_looppa5

no_en_este_guionpa5:
    inc esi
    inc edi
    jmp compara_letrapa5

compara_palabras_looppa5:
    xor al, al
    xor bl, bl
    mov al, byte[esi]
    inc esi
    mov bl, byte[edi]
    inc edi
    cmp al, bl
    jne palabra_pa5     ; si no on iguales, brinca a pedir again la entrada
    cmp al, 0           ; si se llego al final, gano la persona
    je GANOpa5
    jmp compara_palabras_looppa5       ; si no, siga pidiendo la entrada y todo normalmente

GANOpa5:
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pa1, 13
    limpiaRegistros
    imprimeEnPantalla gane, longgane
    jmp SALIR

















comp_letraspb1:
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor bl, bl
    imprimeEnPantalla pidoLetra, longpidoLetra
    leeTeclado
    mov bl, byte[entrada]                           ; se mueve a bl la letra a ingresar
    jmp compara_letrapb1

compara_letrapb1:
    cmp r8, 0
    je PERDIO
    cmp byte[esi], 0
    je palabra_revisadapb1      ; si ya se acabo el string(caracter 10), imprime lo que hay en esi y vuelve a pedir la entrada
    cmp byte[esi], bl
    jne no_en_este_guionpb1
    mov byte[edi], bl           ;cambia en los guiones la letra
    inc edi                     ; avanza 2 en los guiones
    inc esi                     ; avanza 2 en la palabra
    ;jmp palabra_revisadapb1
    jmp compara_letrapb1

palabra_revisadapb1:
    dec r8                     ; decrementar el numero de intentos restantes
    ;dec al
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    mov esi, pb1
    mov edi, pb1l
    jmp compara_palabras_looppb1

no_en_este_guionpb1:
    inc esi
    inc edi
    jmp compara_letrapb1

compara_palabras_looppb1:
    xor al, al
    xor bl, bl
    mov al, byte[esi]
    inc esi
    mov bl, byte[edi]
    inc edi
    cmp al, bl
    jne palabra_pb1     ; si no on iguales, brinca a pedir again la entrada
    cmp al, 0           ; si se llego al final, gano la persona
    je GANOpb1
    jmp compara_palabras_looppb1       ; si no, siga pidiendo la entrada y todo normalmente

GANOpb1:
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pb1, 22
    limpiaRegistros
    imprimeEnPantalla gane, longgane
    jmp SALIR








comp_letraspb2:
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor bl, bl
    imprimeEnPantalla pidoLetra, longpidoLetra
    leeTeclado
    mov bl, byte[entrada]                           ; se mueve a bl la letra a ingresar
    jmp compara_letrapb2

compara_letrapb2:
    cmp r8, 0
    je PERDIO
    cmp byte[esi], 0
    je palabra_revisadapb2      ; si ya se acabo el string(caracter 10), imprime lo que hay en esi y vuelve a pedir la entrada
    cmp byte[esi], bl
    jne no_en_este_guionpb2
    mov byte[edi], bl           ;cambia en los guiones la letra
    inc edi                     ; avanza 2 en los guiones
    inc esi                     ; avanza 2 en la palabra
    ;jmp palabra_revisadapb2
    jmp compara_letrapb2

palabra_revisadapb2:
    dec r8                     ; decrementar el numero de intentos restantes
    ;dec al
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    mov esi, pb2
    mov edi, pb2l
    jmp compara_palabras_looppb2

no_en_este_guionpb2:
    inc esi
    inc edi
    jmp compara_letrapb2

compara_palabras_looppb2:
    xor al, al
    xor bl, bl
    mov al, byte[esi]
    inc esi
    mov bl, byte[edi]
    inc edi
    cmp al, bl
    jne palabra_pb2     ; si no on iguales, brinca a pedir again la entrada
    cmp al, 0           ; si se llego al final, gano la persona
    je GANOpb2
    jmp compara_palabras_looppb2       ; si no, siga pidiendo la entrada y todo normalmente

GANOpb2:
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pb2, 22
    limpiaRegistros
    imprimeEnPantalla gane, longgane
    jmp SALIR
    
    
    
    
    
    
    
    
    
    
    
    
    
comp_letraspb3:
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor bl, bl
    imprimeEnPantalla pidoLetra, longpidoLetra
    leeTeclado
    mov bl, byte[entrada]                           ; se mueve a bl la letra a ingresar
    jmp compara_letrapb3

compara_letrapb3:
    cmp r8, 0
    je PERDIO
    cmp byte[esi], 0
    je palabra_revisadapb3      ; si ya se acabo el string(caracter 10), imprime lo que hay en esi y vuelve a pedir la entrada
    cmp byte[esi], bl
    jne no_en_este_guionpb3
    mov byte[edi], bl           ;cambia en los guiones la letra
    inc edi                     ; avanza 2 en los guiones
    inc esi                     ; avanza 2 en la palabra
    ;jmp palabra_revisadapb3
    jmp compara_letrapb3

palabra_revisadapb3:
    dec r8                     ; decrementar el numero de intentos restantes
    ;dec al
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    mov esi, pb3
    mov edi, pb3l
    jmp compara_palabras_looppb3

no_en_este_guionpb3:
    inc esi
    inc edi
    jmp compara_letrapb3

compara_palabras_looppb3:
    xor al, al
    xor bl, bl
    mov al, byte[esi]
    inc esi
    mov bl, byte[edi]
    inc edi
    cmp al, bl
    jne palabra_pb4     ; si no on iguales, brinca a pedir again la entrada
    cmp al, 0           ; si se llego al final, gano la persona
    je GANOpb3
    jmp compara_palabras_looppb3       ; si no, siga pidiendo la entrada y todo normalmente

GANOpb3:
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pb3, 20
    limpiaRegistros
    imprimeEnPantalla gane, longgane
    jmp SALIR








comp_letraspb4:
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor bl, bl
    imprimeEnPantalla pidoLetra, longpidoLetra
    leeTeclado
    mov bl, byte[entrada]                           ; se mueve a bl la letra a ingresar
    jmp compara_letrapb4

compara_letrapb4:
    cmp r8, 0
    je PERDIO
    cmp byte[esi], 0
    je palabra_revisadapb4      ; si ya se acabo el string(caracter 10), imprime lo que hay en esi y vuelve a pedir la entrada
    cmp byte[esi], bl
    jne no_en_este_guionpb4
    mov byte[edi], bl           ;cambia en los guiones la letra
    inc edi                     ; avanza 2 en los guiones
    inc esi                     ; avanza 2 en la palabra
    ;jmp palabra_revisadapb4
    jmp compara_letrapb4

palabra_revisadapb4:
    dec r8                     ; decrementar el numero de intentos restantes
    ;dec al
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    mov esi, pb4
    mov edi, pb4l
    jmp compara_palabras_looppb4

no_en_este_guionpb4:
    inc esi
    inc edi
    jmp compara_letrapb4

compara_palabras_looppb4:
    xor al, al
    xor bl, bl
    mov al, byte[esi]
    inc esi
    mov bl, byte[edi]
    inc edi
    cmp al, bl
    jne palabra_pa1     ; si no on iguales, brinca a pedir again la entrada
    cmp al, 0           ; si se llego al final, gano la persona
    je GANOpa1
    jmp compara_palabras_looppb4       ; si no, siga pidiendo la entrada y todo normalmente

GANOpb4:
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pb4, 24
    limpiaRegistros
    imprimeEnPantalla gane, longgane
    jmp SALIR










comp_letraspb5:
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor bl, bl
    imprimeEnPantalla pidoLetra, longpidoLetra
    leeTeclado
    mov bl, byte[entrada]                           ; se mueve a bl la letra a ingresar
    jmp compara_letrapb5

compara_letrapb5:
    cmp r8, 0
    je PERDIO
    cmp byte[esi], 0
    je palabra_revisadapb5      ; si ya se acabo el string(caracter 10), imprime lo que hay en esi y vuelve a pedir la entrada
    cmp byte[esi], bl
    jne no_en_este_guionpb5
    mov byte[edi], bl           ;cambia en los guiones la letra
    inc edi                     ; avanza 2 en los guiones
    inc esi                     ; avanza 2 en la palabra
    ;jmp palabra_revisadapb5
    jmp compara_letrapb5

palabra_revisadapb5:
    dec r8                     ; decrementar el numero de intentos restantes
    ;dec al
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    mov esi, pb5
    mov edi, pb5l
    jmp compara_palabras_looppb5

no_en_este_guionpb5:
    inc esi
    inc edi
    jmp compara_letrapb5

compara_palabras_looppb5:
    xor al, al
    xor bl, bl
    mov al, byte[esi]
    inc esi
    mov bl, byte[edi]
    inc edi
    cmp al, bl
    jne palabra_pb5     ; si no on iguales, brinca a pedir again la entrada
    cmp al, 0           ; si se llego al final, gano la persona
    je GANOpb5
    jmp compara_palabras_looppb5       ; si no, siga pidiendo la entrada y todo normalmente

GANOpb5:
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pb5, 24
    limpiaRegistros
    imprimeEnPantalla gane, longgane
    jmp SALIR













comp_letraspc1:
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor bl, bl
    imprimeEnPantalla pidoLetra, longpidoLetra
    leeTeclado
    mov bl, byte[entrada]                           ; se mueve a bl la letra a ingresar
    jmp compara_letrapc1

compara_letrapc1:
    cmp r8, 0
    je PERDIO
    cmp byte[esi], 0
    je palabra_revisadapc1      ; si ya se acabo el string(caracter 10), imprime lo que hay en esi y vuelve a pedir la entrada
    cmp byte[esi], bl
    jne no_en_este_guionpc1
    mov byte[edi], bl           ;cambia en los guiones la letra
    inc edi                     ; avanza 2 en los guiones
    inc esi                     ; avanza 2 en la palabra
    ;jmp palabra_revisadapc1
    jmp compara_letrapc1

palabra_revisadapc1:
    dec r8                     ; decrementar el numero de intentos restantes
    ;dec al
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    mov esi, pc1
    mov edi, pc1l
    jmp compara_palabras_looppc1

no_en_este_guionpc1:
    inc esi
    inc edi
    jmp compara_letrapc1

compara_palabras_looppc1:
    xor al, al
    xor bl, bl
    mov al, byte[esi]
    inc esi
    mov bl, byte[edi]
    inc edi
    cmp al, bl
    jne palabra_pc1     ; si no on iguales, brinca a pedir again la entrada
    cmp al, 0           ; si se llego al final, gano la persona
    je GANOpc1
    jmp compara_palabras_looppc1       ; si no, siga pidiendo la entrada y todo normalmente

GANOpc1:
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pc1, 26
    limpiaRegistros
    imprimeEnPantalla gane, longgane
    jmp SALIR








comp_letraspc2:
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor bl, bl
    imprimeEnPantalla pidoLetra, longpidoLetra
    leeTeclado
    mov bl, byte[entrada]                           ; se mueve a bl la letra a ingresar
    jmp compara_letrapc2

compara_letrapc2:
    cmp r8, 0
    je PERDIO
    cmp byte[esi], 0
    je palabra_revisadapc2      ; si ya se acabo el string(caracter 10), imprime lo que hay en esi y vuelve a pedir la entrada
    cmp byte[esi], bl
    jne no_en_este_guionpc2
    mov byte[edi], bl           ;cambia en los guiones la letra
    inc edi                     ; avanza 2 en los guiones
    inc esi                     ; avanza 2 en la palabra
    ;jmp palabra_revisadapc2
    jmp compara_letrapc2

palabra_revisadapc2:
    dec r8                     ; decrementar el numero de intentos restantes
    ;dec al
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    mov esi, pc2
    mov edi, pc2l
    jmp compara_palabras_looppc2

no_en_este_guionpc2:
    inc esi
    inc edi
    jmp compara_letrapc2

compara_palabras_looppc2:
    xor al, al
    xor bl, bl
    mov al, byte[esi]
    inc esi
    mov bl, byte[edi]
    inc edi
    cmp al, bl
    jne palabra_pc2     ; si no on iguales, brinca a pedir again la entrada
    cmp al, 0           ; si se llego al final, gano la persona
    je GANOpc2
    jmp compara_palabras_looppc2       ; si no, siga pidiendo la entrada y todo normalmente

GANOpc2:
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pc2, 38
    limpiaRegistros
    imprimeEnPantalla gane, longgane
    jmp SALIR
    
    
    
    
    
    
    
    
    
    
    
    
    
comp_letraspc3:
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor bl, bl
    imprimeEnPantalla pidoLetra, longpidoLetra
    leeTeclado
    mov bl, byte[entrada]                           ; se mueve a bl la letra a ingresar
    jmp compara_letrapc3

compara_letrapc3:
    cmp r8, 0
    je PERDIO
    cmp byte[esi], 0
    je palabra_revisadapc3      ; si ya se acabo el string(caracter 10), imprime lo que hay en esi y vuelve a pedir la entrada
    cmp byte[esi], bl
    jne no_en_este_guionpc3
    mov byte[edi], bl           ;cambia en los guiones la letra
    inc edi                     ; avanza 2 en los guiones
    inc esi                     ; avanza 2 en la palabra
    ;jmp palabra_revisadapc3
    jmp compara_letrapc3

palabra_revisadapc3:
    dec r8                     ; decrementar el numero de intentos restantes
    ;dec al
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    mov esi, pc3
    mov edi, pc3l
    jmp compara_palabras_looppc3

no_en_este_guionpc3:
    inc esi
    inc edi
    jmp compara_letrapc3

compara_palabras_looppc3:
    xor al, al
    xor bl, bl
    mov al, byte[esi]
    inc esi
    mov bl, byte[edi]
    inc edi
    cmp al, bl
    jne palabra_pc4     ; si no on iguales, brinca a pedir again la entrada
    cmp al, 0           ; si se llego al final, gano la persona
    je GANOpc3
    jmp compara_palabras_looppc3       ; si no, siga pidiendo la entrada y todo normalmente

GANOpc3:
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pc3, 32
    limpiaRegistros
    imprimeEnPantalla gane, longgane
    jmp SALIR








comp_letraspc4:
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor bl, bl
    imprimeEnPantalla pidoLetra, longpidoLetra
    leeTeclado
    mov bl, byte[entrada]                           ; se mueve a bl la letra a ingresar
    jmp compara_letrapc4

compara_letrapc4:
    cmp r8, 0
    je PERDIO
    cmp byte[esi], 0
    je palabra_revisadapc4      ; si ya se acabo el string(caracter 10), imprime lo que hay en esi y vuelve a pedir la entrada
    cmp byte[esi], bl
    jne no_en_este_guionpc4
    mov byte[edi], bl           ;cambia en los guiones la letra
    inc edi                     ; avanza 2 en los guiones
    inc esi                     ; avanza 2 en la palabra
    ;jmp palabra_revisadapc4
    jmp compara_letrapc4

palabra_revisadapc4:
    dec r8                     ; decrementar el numero de intentos restantes
    ;dec al
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    mov esi, pc4
    mov edi, pc4l
    jmp compara_palabras_looppc4

no_en_este_guionpc4:
    inc esi
    inc edi
    jmp compara_letrapc4

compara_palabras_looppc4:
    xor al, al
    xor bl, bl
    mov al, byte[esi]
    inc esi
    mov bl, byte[edi]
    inc edi
    cmp al, bl
    jne palabra_pc4     ; si no on iguales, brinca a pedir again la entrada
    cmp al, 0           ; si se llego al final, gano la persona
    je GANOpc5
    jmp compara_palabras_looppc4       ; si no, siga pidiendo la entrada y todo normalmente

GANOpc4:
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pc4, 28
    limpiaRegistros
    imprimeEnPantalla gane, longgane
    jmp SALIR










comp_letraspc5:
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor bl, bl
    imprimeEnPantalla pidoLetra, longpidoLetra
    leeTeclado
    mov bl, byte[entrada]                           ; se mueve a bl la letra a ingresar
    jmp compara_letrapc5

compara_letrapc5:
    cmp r8, 0
    je PERDIO
    cmp byte[esi], 0
    je palabra_revisadapc5      ; si ya se acabo el string(caracter 10), imprime lo que hay en esi y vuelve a pedir la entrada
    cmp byte[esi], bl
    jne no_en_este_guionpc5
    mov byte[edi], bl           ;cambia en los guiones la letra
    inc edi                     ; avanza 2 en los guiones
    inc esi                     ; avanza 2 en la palabra
    ;jmp palabra_revisadapc5
    jmp compara_letrapc5

palabra_revisadapc5:
    dec r8                     ; decrementar el numero de intentos restantes
    ;dec al
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    mov esi, pc5
    mov edi, pc5l
    jmp compara_palabras_looppc5

no_en_este_guionpc5:
    inc esi
    inc edi
    jmp compara_letrapc5

compara_palabras_looppc5:
    xor al, al
    xor bl, bl
    mov al, byte[esi]
    inc esi
    mov bl, byte[edi]
    inc edi
    cmp al, bl
    jne palabra_pc5     ; si no on iguales, brinca a pedir again la entrada
    cmp al, 0           ; si se llego al final, gano la persona
    je GANOpc5
    jmp compara_palabras_looppc5       ; si no, siga pidiendo la entrada y todo normalmente

GANOpc5:
    limpiaRegistros
    imprimeEnPantalla Palabra, longPalabra
    imprimeEnPantalla pc5, 46
    limpiaRegistros
    imprimeEnPantalla gane, longgane
    jmp SALIR















PERDIO:
    xor eax, eax                                ; limpia los registros de imprimeEnPantalla
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    imprimeEnPantalla gameover, longgameover
    jmp SALIR












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





