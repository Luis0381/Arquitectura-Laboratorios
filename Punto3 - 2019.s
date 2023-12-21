.data
cadena: .asciiz "Luis"   # Definición de la cadena "Luis" en la sección de datos
msg1: .asciiz "\nLa longitud de la cadena es "

.text
.globl _start

_start:
    # Asignar la dirección de la cadena "Luis" en a0
    la a0, cadena   # Cargar la dirección de la cadena en a0

    # Cargar dirección de la cadena en a3
    mv a3, a0

    # Inicializar contador de longitud en cero
    li t0, 0
    
loop:
    # Cargar el byte de la cadena en a2
    lbu a2, 0(a3)

    # Imprimir el caracter por consola
    li a0,11 # Selección del servicio: mostrar un caracter por pantalla
    mv a1,a2 # Cargamos el valor que queremos mostrar
    ecall # Pedimos el servicio, el entero se muestra en la pantalla

    # Verificar si se ha llegado al final de la cadena
    beqz a2, done
    
    # Incrementar contador de longitud
    addi t0, t0, 1

    # Avanzar a la siguiente posición de la cadena
    addi a3, a3, 1

    # Saltar al inicio del bucle
    j loop

done:

    li a0,4 # Selección del servicio: mostrar una cadena por pantalla
    la a1,msg1 # Apuntamos al inicio de la cadena a imprimir
    ecall # Pedimos el servicio, la cadena se muestra en la pantalla


    # Imprimir la longitud de la cadena
    li a0,1 # Selección del servicio: mostrar un entero por pantalla
    mv a1,t0 # Cargamos el valor que queremos mostrar
    ecall # Pedimos el servicio, el entero se muestra en la pantalla

    # Finalizar el programa
    li a0,10 # Selección del servicio terminar el programa sin error
    ecall # Termina el programa y retorna al sistema operativo

