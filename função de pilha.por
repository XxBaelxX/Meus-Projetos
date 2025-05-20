programa
{		
	

	inteiro topo=0
	inteiro pilha[20]

	funcao empilhar(inteiro valor){
		
		se(topo<=20){
		escreva("empilhando: ",valor)
		pilha[topo] = valor
		topo = topo + 1
		}
		senao{
			escreva("Erro! Pilha cheia")
		}
	}

	funcao mostrarPilha(){
		para(pilha[topo]=0;pilha[topo]<=20;pilha[topo]+=2)
		se(pilha[topo]<=20){
			escreva("\nEmpilhando:",pilha[topo])
			
		}
		senao{
			escreva("Erro! Pilha vazia")
		}
	}


	funcao inicio()
	{	mostrarPilha()
		topo=0
		para(inteiro i=0;i<20;i++){
			
		
		se(topo<=20){
			topo = topo + 1
			}
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 551; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */