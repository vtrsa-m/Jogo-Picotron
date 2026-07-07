# Engine de Aventura Textual em Árvore

**Disciplina:** Estrutura de Dados 2
**Instituição:** Instituto Federal de Mato Grosso do Sul (IFMS)
**Curso:** Engenharia da Computação (4º Semestre)

**Equipe:**
* Vitor Silva Amâncio
* Pablo Felipe
* Bruno Brito

---

## Sobre o Projeto

Este projeto consiste em uma engine de Text Adventure desenvolvida no Picotron. O núcleo do sistema é fundamentado na manipulação de uma estrutura de Árvore N-ária, onde cada elemento do jogo é representado como um nó chamado de vessel.

O jogador interage com o mundo através de um interpretador de comandos que executa operações de manipulação de dados como inserção, remoção, busca e movimentação de nós.

---

## Instruções de Execução

Para facilitar a avaliação e o uso, um shell script foi incluído para preparar o ambiente automaticamente.

* Clone ou baixe este repositório para sua máquina local com sistema Linux.
* Abra o terminal na pasta raiz do projeto.
* Dê permissão de execução ao script através do comando `chmod +x setup.sh`.
* Execute o script com o comando `./setup.sh`.

O script irá configurar o ambiente, instalar dependências necessárias, executar o projeto e deixar tudo pronto para testes de forma automática.

---

## Estrutura e Desenvolvimento

A lógica principal encontra-se estruturada para manipulação direta da árvore de dados.

* **Estrutura de Nós:** Cada vessel contém propriedades de descrição, programa, gatilhos, bloqueios e filhos.
* **Raiz do Mundo:** O ambiente do jogo inicia-se a partir de um nó raiz isolado.
* **Identidade Dinâmica:** O jogador é tratado como um nó dentro da própria árvore, o que permite a mecânica de assumir diferentes identidades no jogo.
* **Testes Automatizados:** O próprio script de setup prepara o ambiente para validar as operações da árvore simulando a execução do projeto.

---
