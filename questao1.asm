.data					# Declaração das variáveis

msg1:		.asciiz "Digite o primeiro número inteiro positivo correspondente ao dividendo\n"	
msg2:		.asciiz "Digite o segundo número inteiro positivo correspondente ao divisor\n"		
dividendo:	.word 1
divisor:	.word 1
resto:		.word 1
quociente:	.word 1				#'.word' para inteiros
msgQuociente: 	.asciiz "O quociente é = "	#'.asciiz' para strings no formato ASCII.
msgResto: 	.asciiz "\nO resto é = "

.text					# representa a parte do programa onde estará o código a ser executado

main:	
	li $v0,	4			# 'li' significa "Load Immediate" e o código '4' se refere a imprimir uma string no console.
	la $a0,	msg1			# O'la'significa "Load Adress" e está passando p/ o registrador o argumento '$a0' o endereço de memória onde está armazenado o 'msg1'
	syscall				# O syscall interpreta que é para imprimir uma mensagem no console e recebe como argumento a 'msg1'.

	li $v0, 5			# O 'li' passa a instrução p/ o 'syscall' pelo registrador $v0, o código '5' se refere à leitura de um inteiro, o 'syscall' executa a leitura.
	syscall	
	
	move $s0, $v0			# move o valor do dividendo que esta em $v0 para o registrador $s0
	sw $s0, dividendo		# carrega o valor da variavel dividendo no registrador $s0
	
	li $v0, 4			# 'li' significa "Load Immediate" e o código '4' se refere a imprimir uma string no console.
	la $a0,msg2 			# O'la'significa "Load Address" e está passando p/ o registrador o argumento '$a0' o endereço de memória onde está armazenado o 'msg2'
	syscall				# O syscall interpreta que é para imprimir uma mensagem no console e recebe como argumento a 'msg2'.
	
	li $v0, 5			# O 'li' passa a instrução p/ o 'syscall', o código '5' se refere à leitura de um inteiro, o 'syscall' executa a leitura.
	syscall
	
	move $s1, $v0			# move o valor do divisor que esta em $v0 para o registrador $s0
	sw $s1, divisor			# carrega o valor da variavel divisor no registrador $s0
	
	lw $t0, dividendo 		# O load word carrega o conteudo do dividendo em $t0
	sw $t0, resto			# O store word carrega o conteudo que esta na variavel resto para o registrador $t0, ou seja, resto = dividendo
	
	move $t1, $s0			# move o que esta guardado em $s0 para o registrador temporario $t1 resto = dividendo
	
	addi  $t2, $zero, 0		# o quociente($t2) inicializa com 0, ou seja, quociente($t2) = 0
	
	LOOP:	slt $t3, $t1, $s1	# compara se o resto é menor que o divisor, caso seja verdade, entao guarda no registrador $t3 o valor = 1 - ($t3 = resto < divisor)
		bne $t3, $zero, EXIT	# Se o conteúdo do registrador $t3 for diferente de zero ($t3 != 0) vá para o label ELSE
	    	sub $t1, $t1, $s1	# subtrai-se o resto pelo divisor e guarda no registrador $t1 (resto($t1) = resto - divisor)
	    	addi $t2, $t2, 1	# incremento do quociente, quociente++
	    	j LOOP			# volta para o LOOP
	EXIT:				# sai do LOOP	
	
	
	#imprime a mensagem msgQuociente
	li $v0, 4			# O 'li' significa "Load Immediate" e o código '4' se refere a imprimir uma string no console.
	la $a0,msgQuociente 		# O 'la'significa "Load Address" e está passando p/ o registrador o argumento '$a0' o endereço de memória onde está armazenado o 'msgQuocieente'
	syscall				# O syscall interpreta que é para imprimir uma mensagem no console e recebe como argumento a 'msgQuociente'.

	#imprime o resultado do quociente
	li $v0, 1			# O código '1' se refere à impressão de um inteiro no console.	
	move $a0, $t2			# O comando 'move' move o valor do quociente ($t2) para o registrador de argumento $a0
	syscall
	
	#imprime a mensagem msgQuociente
	li $v0, 4			# O 'li' significa "Load Immediate" e o código '4' se refere a imprimir uma string no console.
	la $a0,msgResto			# O'la'significa "Load Address" e está passando p/ o registrador o argumento '$a0' o endereço de memória onde está armazenado o 'msgResto'
	syscall				# O syscall interpreta que é para imprimir uma mensagem no console e recebe como argumento a 'msgResto'.

	#imprime o resultado do resto
	li $v0, 1			# O código '1' se refere à impressão de um inteiro no console.	
	move $a0, $t1			# O comando 'move' move o valor do resto ($t1) para o registrador de argumento $a0
	syscall
	
	
	
	
