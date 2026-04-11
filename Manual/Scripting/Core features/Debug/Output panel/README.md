# Output panel

Como prometido anteriormente, agora vamos falar sobre o painel de output do editor.

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/72977b5d-9e43-41d6-aa7e-27f62a4ce9f5" />
</p>

## Tipos de messagens

Quatro tipos de mensagens estão disponíveis neste painel:

- **Log:** Mensagens padrão printadas pelo projeto. Exibidas em branco ou preto (dependendo do tema do editor).
- **Error:** Mensagens printadas pelo projeto ou editor que indicam algum tipo de falha. Exibidas em vermelho.
- **Warning:** Mensagens printadas pelo projeto ou editor que relatam informações importantes, mas não indicam uma falha. Exibidas em amarelo.
- **Editor:** Mensagens printadas pelo editor, geralmente destinadas a registrar ações de desfazer/refazer. Exibidas em cinza.

## Filtros para as mensagens

No painel de output há vários tipos de filtros, o que pode facilitar bastante a sua vida quando há mensagens demais no painel. Listamos abaixo todos os filtros disponíveis no editor.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/32b3d33d-7758-4a28-87d1-5b8a168e8d91" />
</p>

1. Filtra o output para mostrar apenas os prints contendo o conteúdo digitado.
2. Oculta/exibe os prints de output do script.
3. Oculta/exibe os prints de erro.
4. Oculta/exibe os prints de aviso/warning.
5. Oculta/exibe os prints do editor.

## Limpando mensagens

Sempre que você quiser limpar todos os prints do output, basta clicar no ícone de pincel à direita do painel.

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/a83ca072-3bfa-4283-808f-063c26775927" />
</p>

## Printando mensagens

A Godot oferece alguns comandos especiais para printar. O mais comum é o `print()`, que já usamos diversas vezes nos códigos. Segue abaixo a lista de alguns prints interessantes, e depois um exemplo para visualizar.

- **print():** Printa uma mensagem normalmente.
- **print_rich():** Semelhante a `print()`, mas permite o uso de [BBCode](https://www.bbcode.org/reference.php) para formatar o texto.
- **push_error():** Printa uma mensagem de erro. A mensagem é exibida na aba *Debugger → Errors*.
- **push_warning():** Printa uma mensagem de aviso. A mensagem exibida na aba *Debugger → Errors*.
- **print_stack():** Printa a *stack trace* a partir da localização atual. Suportado apenas quando executado a partir do editor ou quando o projeto é exportado em modo de debug.
- **print_tree():** Printa a árvore de cena relativa ao node atual.
- **print_tree_pretty():** Semelhante ao `print_tree()`, mas com caracteres Unicode para uma aparência mais semelhante a uma árvore.

Agora considere o exemplo abaixo.

<p align="center">
  <img width="220" src="https://github.com/user-attachments/assets/a5e389a9-5d02-43b8-a65e-9654e09c95dd" />
</p>
<p align="center">
  <img width="560" src="https://github.com/user-attachments/assets/270b691f-9a19-4c49-8aa3-c7815ead8883" />
  <img width="410" src="https://github.com/user-attachments/assets/669d590e-96da-47cf-960f-2a424f411489" />
</p>

Abaixo temos os outputs que saíram na aba Output.

<p align="center">
  <img width="580" src="https://github.com/user-attachments/assets/6555eef8-1351-407a-b47a-832701b28da7" />
</p>

Por fim, os output que saíram na aba *Debugger → Errors*.

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/d761010c-a6d4-4bcd-bf2b-6c8eb76c124b" />
</p>

> PS: Note que os prints do comando `print_stack()` começaram pelo node mais na base da árvore, depois indo para o topo. A ordem de montagem de uma cena sempre vai de baixo para cima na árvore.
