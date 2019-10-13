.data					# Declaração das variáveis
msg1:		.asciiz "Digite o numero para a base: "		
msg2:		.asciiz "\nDigite o numero para o expoente: "
base:		.word	1
expoente:	.word	1			#'.word' para inteiros
resultado: 	.asciiz "\nO resultado é : "	#'.asciiz' para strings no formato ASCII.

.text					# representa a parte do programa onde estará o código a ser executado
main:
	li $v0,	4			# 'li' significa "Load Immediate" e o código '4' se refere a imprimir uma string no console.
	la $a0,	msg1			# O'la'significa "Load Adress" e está passando p/ o REG o argumento '$a0' o END de memória onde está armazenado o 'msg1'
	syscall				# O syscall interpreta que é para imprimir uma mensagem no console e recebe como argumento a 'msg1'.

	li $v0, 5			# O 'li' passa a instrução p/ o 'syscall' pelo registrador $v0, o código '5' se refere à leitura de um inteiro, o 'syscall' executa a leitura.
	syscall	
	
	move $s0,$v0			# move o valor da base de $v0 para $s0
	
	sw $s0, base			# carrega o valor da base em $s0

	li $v0,	4			# 'li' significa "Load Immediate" e o código '4' se refere a imprimir uma string no console.
	la $a0,	msg2			# O'la'significa "Load Adress" e está passando p/ o registrador o argumento '$a0' o endereço de memória onde está armazenado o 'msg2'
	syscall				# O syscall interpreta que é para imprimir uma mensagem no console e recebe como argumento a 'msg2'.

	li $v0, 5			# O 'li' passa a instrução p/ o 'syscall' pelo registrador $v0, o código '5' se refere à leitura de um inteiro, o 'syscall' executa a leitura.
	syscall	
	
	move $s1, $v0			# move o valor do expoente de $v0 para $s1
	
	sw $s1, expoente		# carrega o valor do expoente em $s1
	
	move $a0, $s0			# move o valor da base para o registrador de arguemento $a0, ao qual é passado como parâmetro pela função POWER
	
	move $a1, $s1			# move o valor do expoente para o registrador de argumento $a1, ao qual é passado como parâmetro pela função POWER
	
	jal POWER			# salta para a função POWER
	
	move $t0, $v0			# move o valor do resultado para o registrador temporario $t0
	
	li $v0, 4			# 'li' significa "Load Immediate" e o código '4' se refere a imprimir uma string no console.
	la $a0, resultado		# O'la'significa "Load Address" e está passando p/ o registrador o argumento '$a0' o endereço de memória onde está armazenado o 'resultado'
	syscall
	
	li $v0, 1			# 'li' significa "Load Immediate" e o código '1' se refere a imprimir um inteiro no console.
	move $a0, $t0			# move o valor do resultado para $a0
	syscall
	
	j EXIT				# vai para o label EXIT
	
POWER:					# label 
	addi $sp, $sp, -8		# ajusta a pilha para armazenar 2 itens
	sw $ra, 4($sp)			# salva o endereço de retorno
	sw $a1, 0($sp)			# salva o argumento o expoente
	
	move $t0, $a1			# move o valor do exponte para $t0
	
	bne $a1, $zero, ELSE		# testa se o expoente for diferente de 0, vá para o label ELSE (expoente != 0)
	addi $v0, $zero, 1    		# resultado($v0) retorna 1 (caso base) - (resultado = 1)
    	addi $sp, $sp, 8      		# retira os 2 itens da pilha
	jr $ra				# retorna o resultado (return resultado)
	
	ELSE:
	    addi $a1, $a1, -1		# argumento será expoente - 1 para a chamada recursiva de POWER
	    jal POWER			# chama a função POWER
	    lw $ra, 4($sp)		# restaura o endereço de retorno
	    lw $a1, 0($sp)		# retorna do jal, restaura o argumento
	    addi $sp, $sp, 8		# ajusta o apontador de pilha para deletar 2 itens
	    mul  $v0, $a0, $v0    	# base * power(expoente - 1)
	    jr   $ra        		# retorna resultado = base * power(expoente - 1)
	
EXIT:					# sai do main
	
	
		
		
	
	
	
	
	



