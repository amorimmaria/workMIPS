.data		# Declaração das variáveis

msgNum:		.asciiz "Digite um número\n"
par:		.asciiz "par"		
impar:		.asciiz "ímpar"		#'.asciiz' para strings no formato ASCII.
numero:		.word 1			#'.word' para inteiros
resto:		.word 1
quociente:	.word 1
dividendo:	.word 1
divisor:	.word 1

.text					# representa a parte do programa onde estará o código a ser executado
	
j main					# pula para o main

resto_divisao:				# label 
	move $t1, $a0			# move o valor do dividendo para o resto resto = dividendo
	addi  $t2, $zero, 0		# o quociente($t2) inicializa com 0, ou seja, quociente($t2) = 0
	LOOP:	slt $t3, $t1, $a1	# compara se o resto é menor que o divisor, caso seja verdade, entao guarda no registrador $t3 o valor = 1 - ($t3 = resto($t1) < divisor($a1))
		bne $t3, $zero, EXIT	# se o conteúdo do registrador $t3 for diferente de zero ($t3 != 0) vá para o label ELSE
	    	sub $t1, $t1, $a1	# subtrai-se o resto pelo divisor e guarda no registrador $t1 (resto($t1) = resto - divisor)
	    	addi $t2, $t2, 1	# incremento do quociente, quociente++
	    	j LOOP			# volta para o LOOP
	EXIT:				# sai do LOOP	
	move $v0, $t1			# move o valor da variavel resto($t1) para o registrador de retorno $v0
	jr $ra				#retorna para o resto


main:
	li $v0,	4			# 'li' significa "Load Immediate" e o código '4' se refere a imprimir uma string no console.
	la $a0,	msgNum			# O'la'significa "Load Adress" e está passando p/ o registrador o argumento '$a0' o endereço de memória onde está armazenado o 'msgNum'
	syscall				# O syscall interpreta que é para imprimir uma mensagem no console e recebe como argumento a 'msgNum'.
	
	li $v0, 5			# O 'li' passa a instrução p/ o 'syscall' pelo registrador $v0, o código '5' se refere à leitura de um inteiro, o 'syscall' executa a leitura.
	syscall
	
	move $s0, $v0			# move o valor do numero($v0) para o registrador $s0
	
	sw $s0, numero			# carrega o valor da variavel dividendo no registrador $s0
	
	move $a0, $s0			# move o valor do numero(dividendo) de $s0 para o registrador de argumento $a0, que é passado como parametro para a função(resto_divisao)
	li $a1, 2			# carega o numero 2, que se refere ao divisor no registrador de argumento $a1
	
	jal resto_divisao		# salta para a função resto_divisao
	
	move $t0, $v0			# O comando 'move' move o valor do resto ($v0) para o registrador de tmporario $t0
	
	beq $t0, $zero, msgPar		# verifica se o resto é igual a 0,(if resto == 0) se for vai para o label msgPar
	
	li $v0, 4			# 'li' significa "Load Immediate" e o código '4' se refere a imprimir uma string no console.
	la $a0,impar			# O'la'significa "Load Address" e está passando p/ o registrador o argumento '$a0' o endereço de memória onde está armazenado o 'impar'
	syscall
	j exit				# vai para o exit
	
	
msgPar:					# label
	#imprime a mensagem msgPar
	li $v0, 4			# 'li' significa "Load Immediate" e o código '4' se refere a imprimir uma string no console.
	la $a0,par			# O'la'significa "Load Address" e está passando p/ o registrador o argumento '$a0' o endereço de memória onde está armazenado o 'par'
	syscall	
exit:					# sai do main

