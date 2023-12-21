.text
.globl _start

# Punto de entrada del programa
_start:
  # Ingresar los valores de A y B
  li a0, 10     # A = 10
  li a1, 5      # B = 2
  
  # VERIFICAMOS SI B ES DIVISOR DE A

  # Llamar a la subrutina esdivisor
  jal ra, esdivisor

  # Mostrar el resultado por pantalla
  mv t0,a0
  
  li a0,1 # Selección del servicio: mostrar un entero por pantalla
  mv a1,t0 # Cargamos el valor que queremos mostrar
  ecall # Pedimos el servicio, el entero se muestra en la pantalla

  # Salir del programa
   li a0,10 # Selección del servicio terminar el programa sin error
   ecall # Termina el programa y retorna al sistema operativo


# Subrutina esdivisor: Determina si B es divisor de A
# Entradas: A en a0, B en a1
# Salidas: 1 en a0 si B es divisor de A, 0 en a0 en caso contrario
esdivisor:
  mv t0, a0      # Copiar A a t0
  mv t1, a1      # Copiar B a t1
  rem t2, t0, t1  # Calcular el residuo de la división A/B en t2
  beqz t2, es_divisor  # Si el residuo es cero, B es divisor de A
  li a0, 0       # Si no, B no es divisor de A, poner 0 en a0
  ret            # Retornar

es_divisor:
  li a0, 1       # B es divisor de A, poner 1 en a0
  ret            # Retornar
