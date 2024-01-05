registo PESSOA
	 	literal nome, numero_bilhete, morada
		inteiro telefone, codigo_pessoa,idade
fimregisto

registo CONTA
		inteiro numero_de_conta, codigo_cliente, tipo_de_conta, estado
		real saldo
fimregisto
inteiro n_de_clientes, n_de_contas

PESSOA cliente [n_de_clientes + 100]
CONTA contas [n_de_contas + 100]
 	
literal link <- fPastaUtilizador() + "\\Documents\\GitHub\\SoftwareDeGestaoBancaria\\Clientes002.txt"


funcao logico cadastro_de_cliente (PESSOA p)
	  
	    p.codigo_pessoa<- n_de_clientes + 1
	    cliente[n_de_clientes]<- p
	 	n_de_clientes <- n_de_clientes + 1   	    
	 	retorne verdadeiro		
fimfuncao

funcao inteiro procurarCliente(inteiro codigo)
	inteiro indice
	para indice de 0 ate n_de_clientes - 1
		PESSOA cliente <- Cliente[indice]
		Se cliente.codigo_pessoa = codigo entao
		  retorne indice
		fimse	
	fimpara
	retorne -1
fimfuncao


funcao inteiro procurarConta(inteiro codigo)
	inteiro indice
	para indice de 0 ate n_de_contas - 1
		CONTA c <- Contas[indice]
		Se c.codigo_cliente = codigo entao
		  retorne indice
		fimse	
	fimpara
	retorne -1
fimfuncao

procedimento salvarDados ()
	fficheiro DadosClientes
	fAbrir(DadosClientes, link, verdadeiro)

	inteiro contador 
	para contador de 0 ate n_de_clientes - 1
		PESSOA p <- cliente[contador]  
		literal linha <- strIntParaStr(p.codigo_pessoa) + ";" + p.nome + ";" + p.morada + ";" + p.numero_bilhete + ";" + strIntParaStr(p.telefone) 

		inteiro i <- procurarConta(p.codigo_pessoa)
		se i <> -1 entao
			CONTA c <- contas[i]
			linha<- linha + ";" + strIntParaStr(c.numero_de_conta) + ";" + strRealParaStr(c.saldo) + ";" + strIntParaStr(c.codigo_cliente) + ";" + strIntParaStr(c.tipo_de_conta) + ";" + strIntParaStr(c.estado)               
		fimse
	   fEscrever(DadosClientes, linha + "\n")
	fimpara    
	ffechar(DadosClientes)  
fimprocedimento	

procedimento mostrar_clientes_cadastrados()
	inteiro contador
	para contador de 0 ate n_de_clientes - 1
		PESSOA P <- cliente [contador]
		
		Escreva "\n________________________________"
		Escreva "\nSeu codigo: ", p.codigo_pessoa,"\n"
		Escreva "\nNome: ", p.nome 
		Escreva "\nMorada: ", p.morada         
		Escreva "\nBI:: ", p.numero_bilhete
		Escreva "\nTelefone: ", p.telefone, "\n"
		
		inteiro i <- procurarConta(p.codigo_pessoa)
		se i <> -1 entao
			CONTA c <- contas[i]
			Escreva "\nDados da Conta\n"
			Escreva "Numero da conta: ", c.numero_de_conta,"\n"
			Escreva "Saldo: ",c.saldo,"\n"
			Escreva "Código do Cliente: ", c.codigo_cliente,"\n"
			Escreva "Tipo de Conta: ", c.tipo_de_conta,"\n"
			Escreva "Estado: ", c.estado,"\n"
		fimse	
	fimpara
fimprocedimento 


funcao logico aberturaDeConta(PESSOA p, inteiro tipo_de_conta)
	CONTA c
	c.numero_de_conta <- n_de_contas + 1
	c.codigo_cliente <- p.codigo_pessoa
	c.tipo_de_conta<- tipo_de_conta
	c.saldo<- 0
	c.estado<- 1
	contas[n_de_contas]<- c
	n_de_contas <- n_de_contas + 1
	retorne verdadeiro
fimfuncao

funcao logico depositarDinheiro (inteiro numero_de_conta, real valor)
	inteiro indice
	indice<- procurarConta(numero_de_conta)
	se indice = -1 entao
		Escreva "\nCÓDIGO INVÁLIDO\n"
		retorne falso
	senao
	CONTA c <- Contas [indice]
	c.saldo <- c.saldo + valor
	fimse
	retorne verdadeiro
fimfuncao

funcao logico levantarDinheiro (inteiro numero_de_conta, real valor)
	inteiro indice
	indice<- procurarConta(numero_de_conta)

	CONTA c <- Contas [indice]
	
	se c.saldo < valor entao
		escreva "\nSaldo Insuficiente\n"
		retorne falso
	senao	
		c.saldo <- c.saldo - valor		
	fimse
	retorne verdadeiro
fimfuncao

funcao real consultarSaldo(inteiro numero_de_conta)
    inteiro indice <- procurarConta(numero_de_conta)
    Conta c <- Contas[indice]
    retorne c.saldo	    
fimfuncao

funcao logico transferirDinheiro (inteiro ContaAEnviar, inteiro ContaAReceber, real valor)
	inteiro cEnviar <- procurarConta(ContaAEnviar)
	inteiro cReceber <- procurarConta(ContaAReceber)
	se cEnviar = -1 e cReceber = -1 entao
		retorne falso
	fimse
	CONTA c1<- Contas[cEnviar]
	CONTA c2<- Contas[cReceber]

	se c1.saldo < valor entao
		retorne falso
	fimse

	c1.saldo <- c1.saldo - valor
	c2.saldo <- c2.saldo + valor
	retorne verdadeiro
fimfuncao

funcao logico actualizarDados (PESSOA P, inteiro codigo_cliente)
	inteiro indice <- procurarCliente(codigo_cliente)
	se indice = -1 entao
		retorne falso
	fimse
	p.codigo_pessoa <- codigo_cliente
	Cliente[indice]<- p
	retorne verdadeiro
fimfuncao


Literal continuacao
procedimento continuar()
	    Escreva"Deseja continuar? [S/N]"
	 	leia continuacao
fimprocedimento


funcao literal Pedir_literal (literal mensagem)
		literal resposta
        Escreva mensagem 
        leia resposta
        retorne resposta
fimfuncao

funcao inteiro Pedir_inteiro (literal mensagem)
        retorne strValorInt(Pedir_literal(mensagem))
fimfuncao


funcao real Pedir_real (literal mensagem)
        retorne strValorReal(Pedir_literal(mensagem))
fimfuncao

 
procedimento volte()
	 	literal voltar
	    Escreva "Clique em ENTER para voltar "
	 	leia voltar
fimprocedimento

 
fficheiro DadosClientes 
procedimento carregar_backup()
        fAbrir(DadosClientes, link, falso)
        enquanto FtemLinha(DadosClientes) faca
	        literal linha <- fLerLinha(DadosClientes)
	        literal linhaQuebrada[]<- strRepartir(linha, ";")
	
	        PESSOA p
	        p.codigo_pessoa <- strValorInt(linhaQuebrada[0])
	        p.nome<- linhaQuebrada[1]
	        p.morada<-linhaQuebrada[2]
	        p.numero_bilhete<- linhaQuebrada [3]
	        p.telefone <- strValorInt(linhaQuebrada[4])
	        	        
	        cliente[n_de_clientes] <- p
	        n_de_clientes<- n_de_clientes + 1

			se aTamanho(linhaQuebrada, 0) = 5 entao
			continue
		fim se
		CONTA c
	    c.numero_de_conta <- strValorInt(linhaQuebrada[5])
		c.saldo <-strValorReal(strTrocar((linhaQuebrada[6]), ",",""))
		c.codigo_cliente <- strValorInt(linhaQuebrada[7])
		c.tipo_de_conta <- strValorInt(linhaQuebrada[8])
		c.estado <- strValorInt(linhaQuebrada[9])

		contas[n_de_contas] <- c
		n_de_contas <- n_de_contas + 1
	        
        fimenquanto
        fFechar(DadosClientes)   
fimprocedimento


procedimento mensagem_sucesso ()
	escreva "=========================================\n"
	escreva " OPERAÇAO REALIZADA COM SUCESSO!\n"
	escreva "=========================================\n"
fim procedimento

procedimento mensagem_erro ()
	escreva "=========================================\n"
	escreva " OPERAÇAO NÃO REALIZADA!\n"
	escreva "=========================================\n"
fim procedimento
 
inicio
		constante inteiro TAMANHO <- 1000
		inteiro opcao
	    carregar_backup()	
	    logico resposta
Enquanto opcao <> 9 faca
         ddata d1
         ttempo t1
         escreva"=========================================\n"
	     mostre "BEM VINDO AO SOFTWARE DE GESTAO BANCÁRIA       ",dEmTexto(d1, 0),"\n"
	     mostre "=========================================      ",tEmTexto(t1), "\n"
	                 
		 Escreva " [1] CADASTRAR\n"
		 Escreva " [2] LISTAR CLIENTES\n"
		 Escreva " [3] ABERTURA DE CONTA\n"
		 Escreva " [4] DESPOSITAR DINHEIRO\n"
		 Escreva " [5] LEVANTAR DINHEIRO\n"
		 Escreva " [6] CONSULTAR SALDO\n"
		 Escreva " [7] TRANSFERIR DINHEIRO\n"
		 Escreva " [8] ACTUALIZAÇÃO DOS DADOS DO CLIENTES\n"
		 Escreva " [9] TERMINAR\n"
		 Escreva " OPÇÃO: "
		 //escreva "\n========================================="        
	     leia opcao
	     
	     
	     Escolha opcao
	     	
	     Caso 1:
	     	 limpatela
	     	 PESSOA P
		     p.nome<- Pedir_literal("Digite o nome completo: ")
		     p.morada<-Pedir_literal("Digite o endereço: ")  
		     p.numero_bilhete<- Pedir_literal("Digite o Nª do BI/NIF: ") 
		     p.telefone<- Pedir_inteiro("Digite o Nº de Telefone: ") 
		     resposta<- cadastro_de_cliente(p)
		       
	     Caso 2:
	     	
	     	limpatela
	     	mostrar_clientes_cadastrados()
	     	volte()
	     	resposta<- verdadeiro
			limpatela
			
	     Caso 3:
	     	
	     	limpatela
	     	Escreva "= ABERTURA DE CONTA = \n"
			inteiro numero_de_conta<- pedir_inteiro("\nDigite o código do cliente: ")
			inteiro indice <- procurarCliente(numero_de_conta)	
			se indice <> -1 entao
				inteiro tipo_conta <- pedir_inteiro("[0]Conta Particular\n[1]Conta empresa\n")
	
				resposta <- aberturaDeConta(cliente[indice], tipo_conta)
		
			senao
				resposta <- falso
			fim se
			volte()
			limpatela
			
	     Caso 4:
	     	limpatela
				inteiro numero_de_conta<- pedir_inteiro ("Digite o código do cliente: ")
				real valor <- pedir_real("Digite o valor do depósito: ")
				
					resposta <- depositarDinheiro (numero_de_conta, valor)
					tpause(4000)
			limpatela 
	     Caso 5:
	     	limpatela
	     		inteiro numero_de_conta<- pedir_inteiro ("Digite o código do cliente: ")
				real valor <- pedir_real("Digite o valor a levantar: ")
				
					resposta <- levantarDinheiro (numero_de_conta, valor)
			limpatela
	     Caso 6:
	     	limpatela
	     		inteiro numero_de_conta<- pedir_inteiro ("Digite o código do cliente: ")
	     		real saldo <- consultarSaldo(numero_de_conta)
	     		Escreva "Saldo disponível: ", saldo, "\n"
	     		resposta<- verdadeiro
	     		volte()
			limpatela
	     Caso 7:
	     	limpatela	
	     		inteiro ContaAEnviar <- Pedir_inteiro("Digite o codigo da conta a enviar: ")
	     		inteiro ContaAReceber<- Pedir_inteiro("Digite o codigo da conta a receber: ")
	     		real valor <- Pedir_real("Digite o valor a enviar")

	     		resposta <- transferirDinheiro(ContaAEnviar,ContaAReceber,valor)
	     	limpatela
	     Caso 8:
	     	limpatela
	     		inteiro codigo_cliente<- pedir_inteiro ("Digite o código do cliente: ")
				PESSOA p
				p.nome<- Pedir_literal("Digite o nome completo: ")
		     	p.morada<-Pedir_literal("Digite o endereço: ")  
		   	  	p.numero_bilhete<-Pedir_literal("Digite o Nª do BI/NIF: ") 
		     	p.telefone<- Pedir_inteiro("Digite o Nº de Telefone: ") 
		     
	     	resposta <-actualizarDados(p, codigo_cliente)		
			limpatela
	     Caso 9:
	     	Escreva "[Sessão Terminada]"
	     FimEscolha
	     se resposta = verdadeiro entao
	     	salvarDados()
	
	     	mensagem_sucesso() 
	     	tpause(3000)
	     	limpatela
	     senao
	     	mensagem_erro()
	     	tpause(3000)
	     	limpatela
	     fimse   	
Fimenquanto

Fimalgoritmo