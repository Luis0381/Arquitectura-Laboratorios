.data

cad1: .asciiz "Cantidad de monedas de $1: "
cad2: .asciiz "\nCantidad de monedas de $5: "
cad3: .asciiz "\nCantidad de monedas de $10: "

.text
.globl main

# Programa principal de prueba
main:
  # Leer el monto ingresado
  li a0,45 # Cargar el monto ingresado en a0 (ejemplo)
  
  # Llamar a la subrutina para calcular la cantidad mínima de monedas
  call vending_machine
  
  # Obtener los resultados de la cantidad mínima de monedas en los registros a1, a2 y a3
  mv s1, a1
  mv s2, a2
  mv s3, a3
  
  # Mostrar los resultados por pantalla
  li a0, 4 # Selección del servicio: mostrar una cadena por pantalla
  la a1, cad1
  ecall # Pedir el servicio, mostrar la cadena por pantalla
  
  li a0, 1 # Selección del servicio: mostrar un entero por pantalla
  mv a1, s1 # Cargar la cantidad de monedas de $1 en a1
  ecall # Pedir el servicio, mostrar el entero por pantalla
  
  li a0, 4 # Selección del servicio: mostrar una cadena por pantalla
  la a1, cad2
  ecall # Pedir el servicio, mostrar la cadena por pantalla
  
  li a0, 1 # Selección del servicio: mostrar un entero por pantalla
  mv a1, s2 # Cargar la cantidad de monedas de $5 en a1
  ecall # Pedir el servicio, mostrar el entero por pantalla
  
  li a0, 4 # Selección del servicio: mostrar una cadena por pantalla
  la a1, cad3
  ecall # Pedir el servicio, mostrar la cadena por pantalla
  
  li a0, 1 # Selección del servicio: mostrar un entero por pantalla
  mv a1, s3 # Cargar la cantidad de monedas de $10 en a1
  ecall # Pedir el servicio, mostrar el entero por pantalla
  
  # Fin del programa
  li a0, 10 # Selección del servicio: terminar el programa sin error
  ecall # Terminar el programa y retornar al sistema operativo

# Función de la máquina expendedora de gaseosas
# Entrada: monto en a0
# Salida: cantidad mínima de monedas en a1, a2, a3 para $1, $5 y $10 respectivamente
vending_machine:
  # Inicializar la cantidad de monedas en cero
  li a1, 0 # Cargar 0 en a1 (monedas de $1)
  li a2, 0 # Cargar 0 en a2 (monedas de $5)
  li a3, 0 # Cargar 0 en a3 (monedas de $10)

  # Calcular la cantidad de monedas de $10
  li t5,10
  div a3, a0, t5  
  rem a0, a0, t5 # Obtener el residuo de la división en a3 (monedas de $10)
    
  # Calcular la cantidad de monedas de $5
  li t5,5
  div a2, a0, t5  
  rem a0, a0, t5 # Obtener el residuo de la división en a3 (monedas de $10)

  # Calcular la cantidad de monedas de $1
  li t5,1
  div a1, a0, t5  
  rem a0, a0, t5 # Obtener el residuo de la división en a3 (monedas de $10)

  # Retornar a la función llamadora
  ret
