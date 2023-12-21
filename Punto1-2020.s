.data
vector:
  .word 1, 3, 5, 2, 6, 8, 7, 11, 0 # Vector de enteros de ejemplo

cad1:
  .asciiz "La cantidad de pares es: "
  
cad2:
  .asciiz "\nLa cantidad de impares es: "

.text
.globl main

# Programa principal de prueba
main:
  # Inicializar vector de enteros
  la a0, vector # Cargar dirección del vector en a0

  # Llamar a la subrutina contar_pares_impares
  call contar_pares_impares
  
  mv s1,a1
  mv s2,a2

  # Mostrar resultados por pantalla
    li a0,4 # Selección del servicio: mostrar una cadena por pantalla
    la a1,cad1 # Apuntamos al inicio de la cadena a imprimir
    ecall # Pedimos el servicio, la cadena se muestra en la pantalla

    li a0,1 # Selección del servicio: mostrar un entero por pantalla
    mv a1,s1 # Cargamos el valor que queremos mostrar
    ecall # Pedimos el servicio, el entero se muestra en la pantalla
    
    li a0,4 # Selección del servicio: mostrar una cadena por pantalla
    la a1,cad2 # Apuntamos al inicio de la cadena a imprimir
    ecall # Pedimos el servicio, la cadena se muestra en la pantalla

    li a0,1 # Selección del servicio: mostrar un entero por pantalla
    mv a1,s2 # Cargamos el valor que queremos mostrar
    ecall # Pedimos el servicio, el entero se muestra en la pantalla


  # Fin del programa
    li a0,10 # Selección del servicio terminar el programa sin error
    ecall # Termina el programa y retorna al sistema operativo



# Subrutina que cuenta la cantidad de números pares e impares en un vector
# de enteros hasta encontrar el valor cero
# Argumentos:
# a0: Dirección del vector
# a1: Cantidad de números pares (retorno)
# a2: Cantidad de números impares (retorno)
contar_pares_impares:
  # Inicializar contadores
  li a1, 0 # Cantidad de números pares
  li a2, 0 # Cantidad de números impares

loop:
  # Cargar el valor del vector en a3
  lw a3, 0(a0)

  # Verificar si el valor es cero
  beqz a3, fin # Salir del loop si el valor es cero

  # Verificar si el valor es par o impar
  andi a4, a3, 1 # Obtener el bit menos significativo para determinar si es par o impar
  beqz a4, es_par # Saltar si es par
  addi a2, a2, 1 # Incrementar contador de impares
  j siguiente

es_par:
  addi a1, a1, 1 # Incrementar contador de pares

siguiente:
  addi a0, a0, 4 # Avanzar a la siguiente posición del vector
  j loop # Volver al inicio del loop

fin:
  ret # Retornar



