programa
{
	inclua biblioteca Util --> u
    inteiro fila[10]
    inteiro inicia=0
    inteiro tamanho=9,fim=-1
    
    funcao enfileirar(inteiro valor){
        se (fim==tamanho){
            escreva("Erro: Fila cheia!\n")
        }
        senao{
            fim=fim+1
            fila[fim]=valor
            escreva("Enfileirado: ",valor,"\n")
        }
    }
    funcao desenfileirar(){
        se (inicia>fim){
            escreva("Erro: Fila vazia!\n")
        }
        senao{
            escreva("Desenfileirado: ",fila[inicia],"\n")
            inicia=inicia+1
        }
    }
    funcao mostrarFila(){
        escreva("\nConteúdo da fila:\n")
        se (inicia>fim){
            escreva("Fila vazia\n")
        }
        senao{
            para (inteiro i=inicia;i<=fim;i=i+1){
                escreva(fila[i],"\n")
            }
        }
    }
    funcao gerar_senhas(){
        para (inteiro j=0;j<10;j=j+1){
            inteiro valor = u.sorteia(1, 999)
            enfileirar(valor)
        }
    }
    funcao bubbleSort(){
        inteiro i,j,temp
        para (i=inicia;i<fim;i=i+1){
            para (j=inicia;j<fim-(i-inicia);j=j+1){
                se (fila[j]>fila[j+1]){
                    temp=fila[j]
                    fila[j]=fila[j+1]
                    fila[j+1]=temp
                }
            }
        }
        escreva("\nSenha reordenada com Bubble Sort:\n")
        mostrarFila()
    }
    funcao merge(inteiro inicioM,inteiro meio,inteiro fimM){
        inteiro i=inicioM,j=meio+1,k=0
        inteiro temp[10]

        enquanto (i<=meio e j<=fimM){
            se (fila[i]<=fila[j]){
                temp[k]=fila[i]
                i=i+1
            }
            senao{
            	temp[k]=fila[j]
			j=j+1
            }
            	k=k+1
        }
        enquanto (i<=meio){
        	temp[k]=fila[i]
        	i=i+1
        	k=k+1
        }
        enquanto (j <= fimM){
        	temp[k]=fila[j]
        	j=j+1
        	k=k+1
        }
        para (i=0;i<k;i=i+1){
        	fila[inicioM+i]=temp[i]
        }
    }
    funcao mergeSort(inteiro inicioM,inteiro fimM){
        se (inicioM<fimM){
            inteiro meio=(inicioM+fimM)/2
            mergeSort(inicioM,meio)
            mergeSort(meio+1,fimM)
            merge(inicioM,meio,fimM)
        }
    }
    funcao inicio(){
    	caracter variavel
    	escreva("Senhas geradas: \n")
    	gerar_senhas()
    	mostrarFila()
    	escreva("Senha reordenada com mergeSort: \n")
    	mergeSort(inicia,fim)
    	mostrarFila()
    	bubbleSort()
    	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 2548; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */