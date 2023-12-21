# Autor: Medina Raed, Luis Eugenio
# Fecha de creacion: 18/04/2022

# Evaluación del Laboratorio Número 1
# Arquitectura de Computadoras

# PUNTO 2
# Apartados A y B


.data
cadena: .asciiz "   Luis"   # Definición de la cadena "Luis" en la sección de datos
espacio: .asciiz "\n" # Dejamos un renglon

.text

.globl main

main:
  # Inicializamos la cadena de prueba
  la a0, cadena
  
  # Mostramos las cadenas original
  li a0,4 # Selección del servicio: mostrar una cadena por pantalla
  la a1,cadena # Apuntamos al inicio de la cadena a imprimir
  ecall # Pedimos el servicio, la cadena se muestra en la pantalla
  
  jal ltrim       # Llamamos a la función ltrim
  
  # Dejamos un renglon
  li a0,4 # Selección del servicio: mostrar una cadena por pantalla
  la a1,espacio # Apuntamos al inicio de la cadena a imprimir
  ecall # Pedimos el servicio, la cadena se muestra en la pantalla

  # Mostramos la cadena modificada por pantalla

  li a0,4 # Selección del servicio: mostrar una cadena por pantalla
  la a1,cadena # Apuntamos al inicio de la cadena a imprimir
  ecall # Pedimos el servicio, la cadena se muestra en la pantalla

  # Terminamos el programa
  li a0,10 # Selección del servicio terminar el programa sin error
  mv a1,t0
  ecall # Termina el programa y retorna al sistema operativo

# Subrutina ltrim - remueve espacios en blanco al inicio de una cadena de caracteres
# Entrada: a0 - dirección de inicio de la cadena de caracteres
# Salida: a0 - dirección de inicio de la cadena de caracteres modificada

ltrim:
  mv t1, a0          # Copia la dirección de la cadena en t1
  lb t2, 0(t1)       # Carga el primer caracter de la cadena en t2

  # Bucle para eliminar los espacios en blanco al inicio de la cadena
eliminar:
  li t3, 32          # Carga el valor ASCII para el espacio en blanco en t3
  beqz t2, fin       # Salta a fin si el primer caracter es nulo
  beq t2, t3, siguiente  # Salta a siguiente si el primer caracter es un espacio en blanco

  # Si no se encuentra un espacio en blanco, la cadena ha sido modificada
  ret                # Retorna de la subrutina

siguiente:
  addi t1, t1, 1     # Incrementa la dirección de la cadena en 1
  lb t2, 0(t1)       # Carga el siguiente caracter de la cadena en t2
  j eliminar         # Salta a eliminar para seguir buscando espacios en blanco

fin:
  mv a0, t1          # Guarda la dirección de inicio de la cadena modificada en a0
  ret                # Retorna de la subrutina


