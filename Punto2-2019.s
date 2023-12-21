.data
cadena1: .asciiz "La raiz cuadrada aproximada de: "  # Mensaje inicial
cadena2: .asciiz " es: "                            # Mensaje intermedio
cadena3: .asciiz " (el entero mas cercano inferior)" # Mensaje final

.text
.globl _start

_start:
    li a0,36
    # Leer el número entero del registro a0
    mv t0, a0

    # Cargar los mensajes de texto en a1, a2, y a3
    la a1, cadena1
    la a2, cadena2
    la a3, cadena3

    # Imprimir el mensaje inicial
    li a0, 4  # Selección del servicio: imprimir cadena de texto
    la a1, cadena1 # Apuntamos al inicio de la cadena a imprimir
    ecall     # Pedir el servicio, imprimir el mensaje inicial

    # Imprimir el número ingresado
    li a0, 1  # Selección del servicio: imprimir un entero por pantalla
    mv a1, t0 # Cargar el número ingresado en a1
    ecall     # Pedir el servicio, imprimir el número ingresado

    # Calcular la raíz cuadrada aproximada
    mv t1, zero # Inicializar el contador en cero
loop:
    mul t2, t1, t1 # Calcular el cuadrado del contador
     ble t2, t0, next # Si el cuadrado es menor o igual al número ingresado, continuar
    j done          # Si el cuadrado es igual o mayor, salir del bucle
next:
    addi t1, t1, 1  # Incrementar el contador en 1
    j loop          # Volver al inicio del bucle

done:
    li t4,2
    blt t0, t4, skip # Si el número ingresado es menor a 2, saltar al final
    addi t1, t1, -1 # Restar 1 al contador para obtener el entero más cercano inferior
skip:
    # Imprimir la raíz cuadrada aproximada
    li a0, 4  # Selección del servicio: imprimir cadena de texto
    la a1, cadena2 # Apuntamos al inicio de la cadena a imprimir
    ecall     # Pedir el servicio, imprimir el mensaje intermedio
    
    li a0, 1  # Selección del servicio: imprimir un entero por pantalla
    mv a1, t1 # Cargar la raíz cuadrada aproximada en a1
    ecall     # Pedir el servicio, imprimir la raíz cuadrada aproximada

    # Imprimir el mensaje final
    li a0, 4  # Selección del servicio: imprimir cadena de texto
    la a1, cadena3 # Apuntamos al inicio de la cadena a imprimir
    ecall     # Pedir el servicio, imprimir el mensaje final

    # Finalizar el programa
    li a0, 10 # Selección del servicio: terminar el programa sin error
    ecall     # Terminar
