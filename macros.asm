;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Macros utiles para programacion en nasm  ;
;  Version 1.0 2022 por emmrami	            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Si se vna a realizar nuevas macros para un proyecto definirlas aca
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ; Objetivo de la macro: imprimir una cadena de texto en pantalla por medio de la salida estándar
        ; Recibe 2 parámetros: el mensaje a imprimir, y la longitud del mensaje
        %macro imprimeEnPantalla 2
                mov     eax, sys_write     	; opción 4 de las interrupciones del kernel.
                mov     ebx, stdout        	; standar output.
                mov     ecx, %1            	; mensaje.
                mov     edx, %2            	; longitud.
                int     0x80
        %endmacro

        ; Objetivo de la macro: cerrar el proceso en ejecución con el código de salida apropiado
        ; se llama para evitar tener que colocar estas 3 líneas en cada punto de la ejecución que se quiere cerrar
        %macro salir 0
            mov eax,1
		    mov ebx,0
            int 80h
        %endmacro

        ; Objetivo de la macro: leer un mensaje (usualmente un solo caracter) del usuario por medio de la entrada estándar (terminal)
        ; al usarla se asume que se ha declarado la variable 'entrada' ya que la utiliza internamente en lugar de tomarla como parámetro.
        %macro leeTeclado 0
                mov byte [entrada], 0  ; Null-terminate the buffer before reading
                mov     eax,     sys_read      ; opción 3 de las interrupciones del kernel.
                mov     ebx,     stdin         ; standar input.
                mov     ecx,     entrada       ; dirección de memoria reservada para almacenar la entrada del teclado.
                mov     edx,     8             ; número de bytes a leer.
                int     0x80
        %endmacro

        ; Objetivo de la macro: leer un mensaje de una longitud en caracteres específica desde la terminal.
        ; el parámetro que recibe es la cantidad de bytes que va a leer.
        %macro leePalabra 1
                mov byte[palabra], 0
                mov eax, sys_read
                mov ebx, stdin
                mov ecx, palabra
                mov edx, %1     ; cantidad de bytes que viene del parámetro
                int 0x80
        %endmacro


; nasm -f elf64 ahorcado.asm -o ahorcado.o && ld ahorcado.o -o ahorcado

; Objetivo de la macro: generar un número aleatorio desde 0 a 4 en ASCII para seleccionar la palabra de forma aleatoria.
; el parámetro que recibe es la variable o dirección en la que va a almacenar el número generado.
%macro palabraRandom 1
    rdtsc
    shl     rdx, 32           ; Hace un "shift" de los 32 bits altos a la derecha
    or      rax, rdx          ; Combina la parte baja con la alta en el rax
    xor     rdx, rdx          ; Limpia el rdx para la división
    mov     rcx, 5            ; 5 para generar números de 0 a 4 (lo que deja es el residuo)
    div     rcx               ; Divide rax entre rcx
    add     dl, '0'           ; Convierte el resultado a ASCII (de 0 a 4)
    mov     [%1], dl          ; Almacena el número aleatorio en la variable parámetro
%endmacro

; Objetivo de la macro: limpia los registros de propósito general que se usan frecuentemente en el código.
%macro limpiaRegistros 0
    xor eax, eax                                
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
%endmacro
