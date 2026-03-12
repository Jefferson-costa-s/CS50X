# Revisão Rápida: CS50x Week 8 (Web & Redes)

## Paradigma Web
* **O Navegador é o Terminal:** O backend apenas transfere texto puro pela rede. O cliente (navegador) consome a sua própria CPU e RAM para compilar esse texto numa interface gráfica.

---

## 1. Camada de Rede (IP)
* **Packet Switching:** Ficheiros grandes são fatiados em pequenos pacotes.
* **Roteamento Dinâmico:** Os pacotes não seguem um cabo fixo. Se um nó (roteador) falha, a rota muda em tempo real. Maximiza a vazão (*throughput*), mas faz com que os pacotes cheguem fora de ordem.
[Image of packet switching network routing data packets across different paths]

## 2. Camada de Transporte (TCP)
* **Garantia de Entrega:** O IP encontra o endereço lógico, o TCP garante que o dado chegue íntegro.
* **Three-way Handshake:** Exige confirmação (SYN, SYN-ACK, ACK) antes de enviar dados úteis. Se um pacote se perde, o TCP exige retransmissão e reorganiza tudo no destino. Custa latência para garantir consistência estrutural.
[Image of TCP 3-way handshake diagram]

## 3. Camada de Aplicação (HTTP)
* **Protocolo de Texto:** Funciona no ciclo Request/Response (ex: `GET / HTTP/1.1`).
* **Status Codes (Controle de Fluxo):**
  * `200 OK`: Sucesso.
  * `301 / 302`: Redirecionamento de recurso na memória/banco.
  * `404 Not Found`: Erro do cliente (rota solicitada não existe).
  * `500 Internal Server Error`: Erro crítico no backend (exceção não tratada, *crash* no servidor).
[Image of HTTP request and response headers cycle between client and server]

---

## 4. Estrutura de Dados (HTML e DOM)
* **Markup:** HTML é apenas marcação rígida e semântica, sem lógica de programação.
* **O DOM (Document Object Model):** O motor do navegador faz o *parse* do texto HTML e aloca os elementos numa estrutura de dados de **Árvore** (*Tree*) na memória RAM (Heap). Cada *tag* transforma-se num nó (objeto) na memória.
[Image of DOM tree data structure representing HTML elements as nodes]

## 5. Motor de Renderização (CSS)
* **Separation of Concerns:** Isola a lógica visual da estrutura de dados.
* **Tree Traversal:** O motor interno do navegador (geralmente em C++) faz buscas contínuas na árvore do DOM para encontrar os nós referenciados e aplicar a pintura de pixels na tela.

## 6. Processamento Client-Side (JavaScript)
* **Ponteiros de Memória:** O JS tem acesso direto aos endereços dos nós do DOM (ex: através de `document.querySelector`). Permite alterar o estado de um objeto na RAM em tempo de execução, sem fazer uma nova requisição de rede ao servidor HTTP.
* **Event-Driven:** Em vez de travar a CPU à espera de *input* do utilizador num loop, utiliza *Event Listeners*. São blocos de funções alocados na memória que só são executados de forma assíncrona quando o Sistema Operativo dispara um evento (como um clique ou toque no teclado).