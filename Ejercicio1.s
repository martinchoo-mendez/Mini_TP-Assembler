.data

op1:        .word 25
op2:        .word 7
operador:   .byte '+'

resultado:  .word 0
estado:     .word 0

.text

.global main

suma:
    LDR r1, = op1
    LDR r2, [r1]        @cargo en r1 la dirección de memoria del operando 1
                        @guardo en r2, el valor al que apunta r1 (el operando 1)
                        
    MOV r3, r2          @cargo en r3, el valor de r2 (el operando 1)
    
    LDR r4, = op2
    LDR r5, [r4]        @cargo en r4, la dirección de memoria del operando 2
                        @guardo en r5, el valor al que apunta r4 (el operando 2)
                        
    ADD r3, r3, r5      @sumo en r3 (donde ya estaba el operando 1) el operando 2
    
    LDR r6, = resultado @cargo en r6 la dirección de memoria de la etiqueta resultado
    STR r3, [r6]        @guardo loq que hay en r3 (el resultado de la suma) en la etiqueta correspondiente
    
    BAL fin_del_programa @una vez que sumó, se termina el programa

resta:
    LDR r1, = op1        @cargo en r1 la dirección de memoria del operando 1
    LDR r2, [r1]         @guardo en r2, el valor al que apunta r1 (el operando 1)
    
    MOV r3, r2           @cargo en r3, el valor de r2 (el operando 1)
    
    LDR r4, = op2        @cargo en r4, la dirección de memoria del operando 2
    LDR r5, [r4]         @guardo en r5, el valor al que apunta r4 (el operando 2)
    
    SUB r3, r3, r5       @resto en r3 (donde ya estaba el operando 1) el operando 2
    
    LDR r6, = resultado  @cargo en r6 la dirección de memoria de la etiqueta resultado
    STR r3, [r6]         @guardo lo que hay en r3 (el resultado de la resta) en la etiqueta correspondiente
    
    BAL fin_del_programa @una vez que restó, se termina el programa

multiplicacion:
    LDR r1, = op1        @cargo en r1 la dirección de memoria del operando 1
    LDR r2, [r1]         @guardo en r2, el valor al que apunta r1 (el operando 1)
    
    LDR r3, = op2        @cargo en r3, la dirección de memoria del operando 2
    LDR r4, [r3]         @guardo en r4, el valor al que apunta r3 (el operando 2)
    
    MUL r5, r2, r4       @guardo en r5, el resultado de multiplicar lo que está en r2 (operando 1) por lo que está en r4 (operando 2)
    
    LDR r6, = resultado  @cargo en r6 la dirección de memoria de la etiqueta resultado
    STR r5, [r6]         @guardo lo que hay en r5 (el resultado de la multiplicación) en la etiqueta correspondiente
    
    BAL fin_del_programa @una vez que multiplicó, se termina el programa

division:
    LDR r1, = op2        @cargamos directamente la dirección de memoria del operando 2 (para ver si es cero)
    LDR r2, [r1]         @guardo en r2, el valor al que apunta r1 (el operando 2)
    
    CMP r2, #0           @compara si lo que está en r2 es igual a cero
    BEQ no_divide        @como es cero, pasa a la subrutina no_divide
    
    LDR r3, = op1        @como no es cero, se puede dividir, así que, cargo en r3 la dirección de memoria del operando 1
    LDR r4, [r3]         @guardo en r4, el valor al que apunta r3 (el operando 1)
    
    SDIV r5, r4, r2      @guardo en r5, el resultado de dividir lo que está en r4 (operador 1) por lo que está en r2 (operador 2)
    
    LDR r6, = resultado  @cargo en r6 la dirección de memoria de la etiqueta resultado
    STR r5, [r6]         @guardo lo que hay en r5 (el resultado de la división) en la etiqueta correspondiente
    
    BAL fin_del_programa @una vez que dividió, se termina el programa

no_divide:
    MOV r0, #2           @como no se puede dividir por cero, estado = 2
    LDR r1, = estado     @cargamos en r1, la dirección de memoria de la etiqueta estado
    STR r0, [r1]         @guardo lo que está en r0 (el valor 2) a lo que apunta r1 (la etiqueta estado)
    BAL fin_del_programa @como no se puede dividir, directamente se termina el programa

fin_del_programa:
    MOV r7, #1
    SWI 0

main:
    LDR r1, = operador   @cargamos en r1 la dirección de memoria del operador
    LDR r2, [r1]         @guardo en r2, el valor al que apunta r1 (el operador)
    
    CMP r2, #43          @comparamos el operador con el 43 (ya que, el operador + en ascii es 43 en decimal y es lo que está guardado en memoria)
    BEQ suma             @si es así, llama a la subrutina suma
    
    CMP r2, #45          @si lo anterior no fue cierto, comparamos el operador con el 45 (ya que que el operador - en ascii es 45 en decimal)
    BEQ resta            @si es así, llama a la subrutina resta
    
    CMP r2, #42          @si lo anterior no fue cierto, comparamos el operador con el 42 (ya que el operador * en ascii es 42 en decimal)
    BEQ multiplicacion   @si es así, llama a la subrutina multiplicacion
    
    CMP r2, #47          @si lo anterior no fue cierto, comparamos el operador con el 47 (ya que el operador / en ascii es 47 en decimal)
    BEQ division         @si es así, llama a la subrutina division
    
    MOV r0, #1           @si ninguna de las anteriores es cierta, quiere decir que el operador es inválido, estado = 1
    LDR r3, = estado     @cargamos en r3, la dirección de memoria de la etiqueta estado
    STR r0, [r3]         @guardo lo que está en r0 (el valor 1) a lo que apunta r2 (la etiqueta estado)
    
    BAL fin_del_programa @termina el programa