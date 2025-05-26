programa {
    // Declaração de um vetor global com capacidade para 100 números inteiros
    inteiro vetor[100]

    // Função de busca linear: procura um valor percorrendo o vetor sequencialmente
    funcao inteiro buscarLinear(inteiro vetor[], inteiro tamanho, inteiro alvo) {
        para (inteiro i = 0; i < tamanho; i++) {
            se (vetor[i] == alvo) {
                retorne i
            }
        }
        retorne -1
    }

    // Função de busca binária: procura um valor em um vetor ORDENADO dividindo o espaço de busca pela metade
    funcao inteiro buscarBinaria(inteiro vetor[], inteiro tamanho, inteiro alvo) {
        inteiro inicio = 0
        inteiro fim = tamanho - 1
        
        enquanto (inicio <= fim) {
            inteiro meio = inicio + (fim - inicio) / 2
            
            se (vetor[meio] == alvo) {
                retorne meio
            }
            senao se (vetor[meio] < alvo) {
                inicio = meio + 1
            }
            senao {
                fim = meio - 1
            }
        }
        retorne -1
    }

    // Função que verifica se o vetor está ordenado em ordem crescente
    funcao logico vetorOrdenado(inteiro vetor[], inteiro tamanho) {
        para (inteiro i = 1; i < tamanho; i++) {
            se (vetor[i] < vetor[i-1]) {
                retorne falso
            }
        }
        retorne verdadeiro
    }

    // Função que ordena o vetor usando o algoritmo Bubble Sort
    funcao ordenarVetor(inteiro vetor[], inteiro tamanho) {
        para (inteiro i = 0; i < tamanho-1; i++) {
            para (inteiro j = 0; j < tamanho-i-1; j++) {
                se (vetor[j] > vetor[j+1]) {
                    inteiro temp = vetor[j]
                    vetor[j] = vetor[j+1]
                    vetor[j+1] = temp
                }
            }
        }
    }

    // Função que controla o fluxo do programa
    funcao inicio() {
        inteiro tamanho = 0
        inteiro valorBusca = 0
        inteiro opcao = 0
        inteiro resultado = 0
        logico  ordenado = falso

        // Interface inicial do programa
        escreva("=== SISTEMA DE BUSCA EM VETOR ===\n\n") 
        
        // Loop para garantir que o tamanho esteja entre 1 e 100
        faca {
            escreva("Digite o tamanho do vetor (1-100): ") 
            leia(tamanho) 
        } enquanto (tamanho < 1 ou tamanho > 100)
     
        // Coleta dos elementos do vetor
        escreva("\nDigite os elementos do vetor:\n") 
        para (inteiro i = 0; i < tamanho; i++) {
            escreva("Elemento ", i+1, ": ") 
            leia(vetor[i]) 
        }
        ordenarVetor(vetor, tamanho) // Ordenação do vetor (pré-requisito para busca binária)
        ordenado = vetorOrdenado(vetor, tamanho)  // Verificação (sempre verdadeira após ordenar)

        escreva("\n=== MENU DE OPÇÕES ===\n") 
        escreva("1. Busca Linear\n") 
        escreva("2. Busca Binária\n") 

        // Loop para garantir que a opção seja 1 ou 2
        faca {
            escreva("Escolha uma opção (1-2): ") 
            leia(opcao) 
        } enquanto (opcao < 1 ou opcao > 2) 

        escreva("\nDigite o valor a ser buscado: ") 
        leia(valorBusca)

        // Execução da busca selecionada
        escolha (opcao) {
            caso 1:  // Busca Linear
                resultado = buscarLinear(vetor, tamanho, valorBusca) 
                escreva("\nResultado da Busca Linear:\n") 
                pare 
            caso 2:  // Busca Binária
                resultado = buscarBinaria(vetor, tamanho, valorBusca) 
                escreva("\nResultado da Busca Binária:\n") 
                pare 
        } 

        // Exibição do resultado
        se (resultado != -1) {
            escreva("Valor encontrado na posição: ", resultado+1)
        }
        senao {
            escreva("Valor não encontrado no vetor.") 
        }

        // Exibição do vetor atual (sempre ordenado neste programa)
        escreva("\n\nVetor atual: [") 
        para (inteiro i = 0; i < tamanho; i++) {
            escreva(vetor[i]) 
            se (i < tamanho-1) {
                escreva(", ")
            }
        }
        escreva("]") 

        // Confirmação do estado de ordenação (sempre verdadeiro)
        se (vetorOrdenado(vetor, tamanho)) {
            escreva("\nO vetor está ordenado.") 
        }
        senao {
            escreva("\nO vetor não está ordenado.") 
        }
    }
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 4164; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */