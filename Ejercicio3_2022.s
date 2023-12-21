# Autor: Medina Raed, Luis Eugenio
# Fecha de creacion: 18/04/2022

# Evaluación del Laboratorio Número 1
# Arquitectura de Computadoras

# PUNTO 3
# Apartados A y B

.data 
vector_origen: .word 01,02,03,04,05
vector_destino: .word 00,00,00,00,00
cad3: .asciiz "-"
espacio: .asciiz "\n"
inicio: .asciiz "El vector origen es: "
final: .asciiz "El vector destino es: "

.text

.globl main
main:
  # Definir vectores de prueba
  la a0, vector_origen      # Cargar dirección de inicio del vector origen en a0
  la a1, vector_destino     # Cargar dirección de inicio del vector destino en a1
  li a2, 5                  # Cargar tamaño de los vectores en a2
  
  # Llamar a la subrutina cuadrados para calcular los cuadrados de los elementos
  jal cuadrados
  
      # Inicio
  li a0,4 # Selección del servicio: mostrar una cadena por pantalla
  la a1,inicio # Apuntamos al inicio de la cadena a imprimir
  ecall # Pedimos el servicio, la cadena se muestra en la pantalla
  
  # Llamar a la subrutina showvector para mostrar los vectores original y resultado
  la a0, vector_origen      # Cargar dirección de inicio del vector origen en a0
  li a1, 5                  # Cargar tamaño del vector origen en a1
  call showvector           # Llamar a la subrutina showvector para mostrar el vector origen
  
    # Dejamos un renglon
  li a0,4 # Selección del servicio: mostrar una cadena por pantalla
  la a1,espacio # Apuntamos al inicio de la cadena a imprimir
  ecall # Pedimos el servicio, la cadena se muestra en la pantalla
  
      # Fin
  li a0,4 # Selección del servicio: mostrar una cadena por pantalla
  la a1,final # Apuntamos al inicio de la cadena a imprimir
  ecall # Pedimos el servicio, la cadena se muestra en la pantalla
  
  la a0, vector_destino     # Cargar dirección de inicio del vector destino en a0
  li a1, 5                  # Cargar tamaño del vector destino en a1
  call showvector           # Llamar a la subrutina showvector para mostrar el vector destino
  
  # Salir del programa
    li a0,10 # Selección del servicio terminar el programa sin error
    ecall # Termina el programa y retorna al sistema operativo


## SUBRUTINA SHOWVECTOR
showvector:
    mv t0, a0 # Preservamos la dirección de inicio del vector
    mv t1, a1 # Preservamos el tamaño del vector
    li a0,1 # Mostramos...
    lw a1,0(t0) # ...el primer elemento...
    ecall # ...por pantalla
lazo: 
    addi t0, t0, 4 # Apunta elemento siguiente
    addi t1, t1, -1 # Decrementamos el tamaño
    beqz t1, fin # Si llegamos al final, terminamos
    # Si hay más elementos...
    li a0,4 # ...mostramos...
    la a1,cad3 # ...un caracter de separación
    ecall # ...por pantalla
    li a0,1 # Mostramos...
    lw a1,0(t0) # ...el elemento...
    ecall # ...por pantalla
    j lazo # Repetimos
fin: 
    ret


## SUBRUTINA CUADRADOS
cuadrados:
  addi t0, zero, 0         # Inicializar contador en 0
  mv t1, a0                # Copiar dirección de inicio del vector origen a t1
  mv t2, a1                # Copiar dirección de inicio del vector destino a t2
  mv t3, a2                # Copiar tamaño de los vectores a t3
  
loop:
  beq t0, t3, exit         # Salir del bucle si se ha procesado el tamaño completo del vector
  lw t4, 0(t1)             # Cargar el elemento del vector origen en t4
  mul t4, t4, t4           # Calcular el cuadrado del elemento
  sw t4, 0(t2)             # Guardar el resultado en el vector destino
  addi t0, t0, 1           # Incrementar contador
  addi t1, t1, 4           # Avanzar a la siguiente posición en el vector origen
  addi t2, t2, 4           # Avanzar a la siguiente posición en el vector destino
  j loop                   # Volver al inicio del bucle

exit:
  ret                      # Retornar de la subrutina
