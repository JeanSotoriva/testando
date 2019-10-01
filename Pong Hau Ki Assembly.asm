.data
	msgPosit:	.asciiz "\nPosi��es do Tabuleiro\n\0"
	msgPjog:	.asciiz "\nPosi��es iniciais dos jogadores\n\0"	
	msgInicieA:	.asciiz "\nJogador A, escolha uma pe�a para jogar digitando uma posi��o do tabuleiro entre 1 e 5 \n\0"
	msgInicieB:	.asciiz "\nJogador B, escolha uma pe�a para jogar digitando uma posi��o do tabuleiro entre 1 e 5 \n\0"
	print_pong:	.asciiz "\n ______________________________________________________________________________ "
	print_pong1:	.asciiz "\n|        *******   SEJA BEM VINDO AO JOGO PONG HAU KI   *******                |"
	print_pong2:	.asciiz "\n|______________________________________________________________________________|\n"
	print_regras:	.asciiz "\n ***        Regras:        ***\n[1]: O jogo � feito para dois jogadores.\n[2]: Voc� escolhe uma�pe�a A ou B.\n[3]: Se voc� jogar uma pe�a que n�o � sua dar� jogada inv�lida e voc� pode repetir a jogada.\n[4]: S� pode andar de uma casa para otra se tiver liga��es, dadas por tra�os e barras.\n[5]: Voc� perde se jogar uma pe�a sua que esteja trancada por outras pe�as.\n"
	tabuleiro:	.asciiz  "[1]\\---/[2]\n |  [3]  | \n[4]/   \\[5]\n"  # indices 1, 9, 17, 25 e 33 sao modificados
	msgVencedorA:	.asciiz "\nJogador A venceu\n\0"
	msgVencedorB:	.asciiz "\nJogador B venceu\n\0" 
      	bPlayer1:       .byte  'A'
    	bPlayer2:       .byte  'B'
    	bVazio:         .byte  ' '    	
    	setJog:       	.asciiz  "\nEscolha suas pe�as [1] para A ou [2] para B:\n\0"
    	jogada_invalida: .asciiz "\n Jogada inv�lida, escolha uma pe�a sua, ent�o tente novamente! \n "
    	vPos:		.word 1, 2, 3, 4, 5
   	
.text
	main:
		jal print_banner
		jal printPosit
		jal printtabuleiro	# Chamada ao print da linha 1
		jal settings		# Chamada as configura��es iniciais do tabuleiro
		jal printPjog		# Chamada ao print das posi�oes dos jogadores
		jal printtabuleiro	# Chamada ao print da linha 1
		jal printPecas
		jal pegaValor
		jal GetJog
		jal SetJog
#-------------------------------------------------------------------------------------------------------------------------------------    
	 continua:
		jal printtabuleiro	# Chamada ao print da linha 1
		jal SetJog
#-------------------------------------------------------------------------------------------------------------------------------------        
	Exit:
		li $v0, 10		# Comando para fechar o programa
		syscall			# Chamada ao sistema
#-------------------------------------------------------------------------------------------------------------------------------------    
	pos1:			
		la $t6, tabuleiro
		addi $t6, $t6, 9	
		beq $t4, $t6, troca1_2
		addi $t6, $t6, 8 	# incrementando o $t6 para comparar com a proxima posi��o		 
		beq $t4, $t6, troca1_3
		addi $t6, $t6, 8 	# incrementando o $t6 para comparar com a proxima posi��o		 		
		beq $t4, $t6, troca1_4
		j perdeu 		
	troca1_2:		 
		sb $t1, 9($s0)		# movendo o byte de t1 da posi��o 2 para a posi�ao 1 
		j trocaVazio1		#chama a fun��o que troca a posi��o anterior do jogador e a posi��o vazio
	troca1_3:		
		sb $t1, 17($s0)		# movendo o byte de t1 da posi��o 3 para a posi�ao 1 
		j trocaVazio1
	troca1_4:		
		sb $t1, 25($s0)		# movendo o byte de t1 da posi��o 4 para a posi�ao 1 
		j trocaVazio1
#-------------------------------------------------------------------------------------------------------------------------------------    
	pos2:
		la $t6, tabuleiro	# pegando a posi��o inicial do vetor posicao	
		addi $t6, $t6, 1	 			
		beq $t4, $t6, troca2_1	# verifica se o valor vazio est� na primeira posi��o do tabuleiro
		addi $t6, $t6, 16 	# incrementando o $t6 para comparar com a proxima posi��o		 
		beq $t4, $t6, troca2_3
		addi $t6, $t6, 16 	# incrementando o $t6 para comparar com a proxima posi��o		 		
		beq $t4, $t6, troca2_5
		j perdeu 		
	troca2_1:
		sb $t1, 1($s0)		# movendo o byte de t1 da posi��o 3 para a posi�ao 1 
		j trocaVazio2 
	troca2_3:			
		sb $t1, 17($s0)		# movendo o byte de t1 da posi��o 3 para a posi�ao 1
		j trocaVazio2 
	troca2_5:				
		sb $t1, 33($s0)		# movendo o byte de t1 da posi��o 3 para a posi�ao 1
		j trocaVazio2
#-------------------------------------------------------------------------------------------------------------------------------------    		
	pos3:
		la $t6, tabuleiro	# pegando a posi��o inicial do vetor posicao	
		addi $t6, $t6, 1	 			
		beq $t4, $t6, troca3_1	# verifica se o valor vazio est� na primeira posi��o do tabuleiro
		addi $t6, $t6, 8 	# incrementando o $t6 para comparar com a proxima posi��o		 
		beq $t4, $t6, troca3_2
		addi $t6, $t6, 16
		beq $t4, $t6, troca3_4
		addi $t6, $t6, 8 	# incrementando o $t6 para comparar com a proxima posi��o		 		
		beq $t4, $t6, troca3_5
		j perdeu  		
	troca3_1:
		sb $t1, 1($s0)		# movendo o byte A de t1 da posi��o 3 para a posi�ao 1 
		j trocaVazio3
	troca3_2:		
		sb $t1, 9($s0)		# movendo o byte A de t1 da posi��o 3 para a posi�ao 2 
		j trocaVazio3
	troca3_4:		
		sb $t1, 25($s0)		# movendo o byte A de t1 da posi��o 3 para a posi�ao 4 
		j trocaVazio3 
	troca3_5:		
		sb $t1, 33($s0)		# movendo o byte A de t1 da posi��o 3 para a posi�ao 5 
		j trocaVazio3
#-------------------------------------------------------------------------------------------------------------------------------------    
	pos4:
		la $t6, tabuleiro	# pegando a posi��o inicial do vetor posicao	
		addi $t6, $t6, 1	 			
		beq $t4, $t6, troca4_1	# verifica se o valor vazio est� na primeira posi��o do tabuleiro
		addi $t6, $t6, 16 	# incrementando o $t6 para comparar com a proxima posi��o		 
		beq $t4, $t6, troca4_3
		j perdeu  		
	troca4_1:
		sb $t1, 1($s0)		# movendo o byte A de t1 da posi��o 4 para a posi�ao 1 
		j trocaVazio4 
	troca4_3:		
		sb $t1, 17($s0)		# movendo o byte A de t1 da posi��o 4 para a posi�ao 4 
		j trocaVazio4 
#-------------------------------------------------------------------------------------------------------------------------------------    
	pos5:
		la $t6, tabuleiro	# pegando a posi��o inicial do vetor posicao	
		addi $t6, $t6, 9	 			
		beq $t4, $t6, troca5_2	# verifica se o valor vazio est� na posi��o 2 do tabuleiro
		addi $t6, $t6, 8 	# incrementando o $t6 para comparar com a proxima posi��o		 
		beq $t4, $t6, troca5_3		
		j perdeu  		
	troca5_2:
		sb $t1, 9($s0)		# movendo o byte A de t1 da posi��o 9 para a posi�ao 5 
		j trocaVazio5 
	troca5_3:		
		sb $t1, 17($s0)		# movendo o byte A de t1 da posi��o 3 para a posi�ao 5 
		j trocaVazio5 
#-------------------------------------------------------------------------------------------------------------------------------------    				
	trocaVazio1:
		la $t4, 1($s0)		# poneiro $t4 recebe posi��o atual do vazio
		sb $t3, 1($s0)		# 
		j continua
#-------------------------------------------------------------------------------------------------------------------------------------    		
	trocaVazio2:
		la $t4, 9($s0)
		sb $t3, 9($s0)
		j continua
#-------------------------------------------------------------------------------------------------------------------------------------    		
	trocaVazio3:
		la $t4, 17($s0)
		sb $t3, 17($s0)
		j continua
#-------------------------------------------------------------------------------------------------------------------------------------    
	trocaVazio4:
		la $t4, 25($s0)
		sb $t3, 25($s0)
		j continua
#-------------------------------------------------------------------------------------------------------------------------------------    		
	trocaVazio5:
		la $t4, 33($s0)
		sb $t3, 33($s0)
		j continua
#-------------------------------------------------------------------------------------------------------------------------------------
	perdeu:
		beq $a2, 1, congB
		beq $a2, 2, congA
#-------------------------------------------------------------------------------------------------------------------------------------
	congB:
		la   $a0, msgVencedorA	# carrega "Posi��s do Tabuleiro" exibir              
        	li   $v0, 4       	# comando para exibir             
        	syscall			# chamada ao sistema
        	j Exit
#-------------------------------------------------------------------------------------------------------------------------------------
	congA:
		la   $a0, msgVencedorB 	# carrega "Posi��s do Tabuleiro" exibir              
        	li   $v0, 4       	# comando para exibir             
        	syscall			# chamada ao sistema
        	j Exit
#-------------------------------------------------------------------------------------------------------------------------------------    
         GetJog:
         	li $v0, 5		# load comando para entrada de leitura de tecldo
	        syscall       		# chamada ao sistema
        	move $a2, $v0 		# grava leitura contida em $v0 em $a2 e determina qual � a pe�a do jogador
        	jr $ra			# retorno para quem chamou
#-------------------------------------------------------------------------------------------------------------------------------------    
	SetJog:
		beq $a2, 1, jogA
		beq $a2, 2, jogB
		jr $ra
	jogA:	
		jal printInicieA
		jal setMov
		jal valida_vetor
		jal validacaoA
		li $a2,2
		lb $t1, bPlayer1  	# caracter = 'A'
		j jogada
	jogB:
		jal printInicieB
		jal setMov
		jal valida_vetor
		jal validacaoB
		li $a2,1
		lb $t1, bPlayer2  	# caracter = 'B'
		j jogada
#-------------------------------------------------------------------------------------------------------------------------------------
	jogada:	
		beq $a3, 1, pos1
		beq $a3, 2, pos2	
		beq $a3, 3, pos3
		beq $a3, 4, pos4	
		beq $a3, 5, pos5	
		j continua
#-------------------------------------------------------------------------------------------------------------------------------------    
	settings:
		la $s0, tabuleiro  	# s0 = ponteiro para []tabuleiro[35]
		lb $t1, bPlayer1  	# caracter = 'A'
		lb $t2, bPlayer2  	# caracter = 'B'
		lb $t3, bVazio    	# caracter = ' ' 
		sb $t1, 1($s0)          # Store byte jog A na linha 1, indice 1, posi��o 1
		sb $t1, 9($s0)		# Store byte jog A na linha 1 indice 9, posi��o 2
		sb $t3, 17($s0)		# Store byte vazio na linha 2 indice 5, posi��o 3
		la $t4, 17($s0)		# $t4 recebe o endere�o onde est� "Vazio"
		sb $t2, 25($s0)		# Store byte jog B na linha 3 indice 1, posi��o 4
		sb $t2, 33($s0)		# Store byte jog B na liha 3 indice 9, posi��o 5
		jr $ra
#-------------------------------------------------------------------------------------------------------------------------------------
	printtabuleiro:
		la   $a0, tabuleiro  	# carrega linha 1 para exibir              
        	li   $v0, 4       	# comando para exibir             
        	syscall			# chamada ao sistema
        	jr $ra		  	# retorno para quem chamou	
#-------------------------------------------------------------------------------------------------------------------------------------            
	printPosit:
		la   $a0, msgPosit  	# carrega "Posi��s do Tabuleiro" exibir              
        	li   $v0, 4       	# comando para exibir             
        	syscall			# chamada ao sistema
        	jr $ra			# retorno para quem chamou
#-------------------------------------------------------------------------------------------------------------------------------------        
	printPjog:
		la   $a0, msgPjog  	# carrega "Posi��es iniciais dos jogadores" para exibir              
        	li   $v0, 4       	# comando para exibir             
        	syscall			# chamada ao sistema
        	jr $ra			# retorno para quem chamou
#-------------------------------------------------------------------------------------------------------------------------------------    
	printPecas:
    		la $a0, setJog     	# load msg "Escolha suas pe�as [1] para A ou [2] para B:" para exibir
        	li $v0, 4           	# comanda para print
        	syscall			# chamada ao sistema
        	jr $ra
#-------------------------------------------------------------------------------------------------------------------------------------
	printInicieA:
		la $a0, msgInicieA	# load "Jogador A escolha a posi��o da pe�a a ser movida para o espa�o vazio" para exibir
		li $v0, 4		# comando para exibir
		syscall			# Chamada ao sistema
		jr $ra			# retorno para quem chamou
#-------------------------------------------------------------------------------------------------------------------------------------
	printInicieB:
		la $a0, msgInicieB	# load "Jogador B escolha a posi��o da pe�a a ser movida para o espa�o vazio" para exibir
		li $v0, 4		# comando para exibir
		syscall			# Chamada ao sistema
		jr $ra			# retorno para quem chamou
#-------------------------------------------------------------------------------------------------------------------------------------    
         setMov:
         	li $v0, 5		# load comando para entrada de leitura de tecldo
	        syscall       		# chamada ao sistema
        	move $a3, $v0 		# grava leitura contida em $v0 em $a3 
        	jr $ra			# retorno para quem chamou			
#-------------------------------------------------------------------------------------------------------------------------------------
	validacaoA:
		bne $a1, $s6, jogada_invalidaA	
		jr $ra
#-------------------------------------------------------------------------------------------------------------------------------------
	validacaoB:
		bne $a1, $s7, jogada_invalidaB
		jr $ra
#-------------------------------------------------------------------------------------------------------------------------------------						
	jogada_invalidaA:
		la $a0, jogada_invalida	
		li $v0, 4
		syscall				
		j jogA
#-------------------------------------------------------------------------------------------------------------------------------------	
	jogada_invalidaB:
		la $a0, jogada_invalida	
		li $v0, 4
		syscall			
		j jogB
#-------------------------------------------------------------------------------------------------------------------------------------	
	pegaValor:
		lb $s5, bVazio
	 	lb $s6, bPlayer1
	 	lb $s7, bPlayer2
	 	jr $ra
#-------------------------------------------------------------------------------------------------------------------------------------	
	valida_vetor:	
		beq $a3, 1, troca1
		beq $a3, 2, troca2
		beq $a3, 3, troca3
		beq $a3, 4, troca4
		beq $a3, 5, troca5
		jr $ra
	troca1:
	 	lb $a1, 1($s0)
		jr $ra
	troca2:
	 	lb $a1, 9($s0)
		jr $ra
	troca3:
	 	lb $a1, 17($s0)
		jr $ra
	troca4:
	 	lb $a1, 25($s0)
		jr $ra
	troca5:
	 	lb $a1, 33($s0)
		jr $ra			
#-------------------------------------------------------------------------------------------------------------------------------------	
	print_banner:
		la $a0, print_pong
		li $v0, 4
		syscall
		la $a0, print_pong1
		li $v0, 4
		syscall
		la $a0, print_pong2
		li $v0, 4
		syscall
		la $a0, print_regras
		li $v0, 4
		syscall
		jr $ra
#-------------------------------------------------------------------------------------------------------------------------------------		