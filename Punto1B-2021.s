    #Datos
    .data
     cad: .asciiz "-" # Valor de X a calcular sus divisores

.text
.globl _start

# Punto de entrada del programa
_start:
  # Ingresar el valor de X
  li s0, 6       # X = 6

  # Mostrar el número X por pantalla
    
   li a0,1 # Selección del servicio: mostrar un entero por pantalla
   mv a1,s0 # Cargamos el valor que queremos mostrar
   ecall # Pedimos el servicio, el entero se muestra en la pantalla

  # Mostrar los divisores de X por pantalla y contar la cantidad de divisores
  li t3, 0       # Inicializar contador de divisores en 0
  li t4, 1       # Inicializar divisor en 1

loop:
  mv a0, s0      # Cargar el divisor actual en a0
  mv a1, t4       # Cargar el valor de X en a1
  jal ra, esdivisor  # Llamar a la subrutina esdivisor para determinar si a0 es divisor de a1
  
  beqz a0, no_es_divisor  # Si a0 es cero, el divisor actual no es divisor de X
  
   li a0,1 # Selección del servicio: mostrar un entero por pantalla
   mv a1,t4 # Cargamos el valor que queremos mostrar
   ecall # Pedimos el servicio, el entero se muestra en la pantalla
  
  addi t3, t3, 1 # Incrementar el contador de divisores en 1
  
     
    li a0,4 # Selección del servicio: mostrar una cadena por pantalla
    la a1,cad # Apuntamos al inicio de la cadena a imprimir
    ecall # Pedimos el servicio, la cadena se muestra en la pantalla
  

no_es_divisor:
  addi t4, t4, 1 # Incrementar el divisor actual en 1
  blt t4, s0, loop # Si el divisor actual es menor que X, volver a iterar


  # Mostrar el total de divisores por pantalla
  
   li a0,1 # Selección del servicio: mostrar un entero por pantalla
   mv a1,t3 # Cargamos el valor que queremos mostrar
   ecall # Pedimos el servicio, el entero se muestra en la pantalla
   
   

    #Salir del programa
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
