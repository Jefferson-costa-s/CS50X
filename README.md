# CS50x - Introdução à Ciência da Computação

Este repositório armazena o código desenvolvido para os Problem Sets do CS50x de Harvard. A maior parte das implementações baseia-se na linguagem C, exigindo uma compreensão de baixo nível da relação entre o software e o hardware.

Aqui, a abstração é removida. Cada estrutura de dados e cada manipulação de string exige gerenciamento explícito.

## Under the Hood & Arquitetura
* **Gerenciamento de Memória:** Implementações de estruturas estáticas (Stack) e dinâmicas (Heap). O uso de `malloc` e `free` exige um controle rigoroso de ponteiros. Memory leaks não são apenas erros de lógica, são falhas de engenharia que esgotam os recursos do sistema operacional. Ferramentas como `valgrind` foram utilizadas para auditar vazamentos e garantir a integridade da memória.
* **Ciclos de CPU e Complexidade (Big O):** A escolha entre Arrays, Linked Lists, Hash Tables e Tries não é estética, mas um trade-off direto entre consumo de memória (RAM) e tempo de busca/inserção (ciclos de processador). A otimização correta dita a escalabilidade da solução.
* **Segurança e Gerenciamento de Risco:** O trabalho com ponteiros e arrays em C expõe vetores de ataque clássicos, como *Buffer Overflow* e *Segmentation Faults*. A manipulação direta de bytes (como em processamento de imagens) reforça a necessidade de sanitização estrita de limites e validação de I/O.
* **Interação com o SO:** A passagem de argumentos via CLI e a devolução de códigos de saída (`exit codes`) corretos para o sistema operacional, respeitando os padrões POSIX.

## Solução Acadêmica vs. Padrão de Mercado
Escrever Hash Tables e algoritmos de ordenação do zero é crucial para o entendimento dos fundamentos da ciência da computação. No entanto, o padrão de mercado atual para desenvolvimento backend moderno delega essas implementações para as bibliotecas padrão de linguagens de mais alto nível (como Python ou Go) ou para o motor de banco de dados (SQL), visando segurança e tempo de entrega. A utilidade deste repositório é demonstrar o conhecimento profundo de *como* essas tecnologias operam na base.