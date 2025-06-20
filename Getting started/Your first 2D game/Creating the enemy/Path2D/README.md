# Path2D

`Path2D` é utilizado quando você quer traçar trajetórias no ambiente. Pode ser uma trajetória que um inimigo vai trilhar em um loop, pode ser a trajetória que um NPC precisa fazer em dado momento, pode até ser uma trajetória abstrata que serve para determinar os pontos por onde certos projéteis podem ser disparados.

## Manuseando o Path2D

Primeiramente, recomendo colocar o `Path2D` como filho de outro node, como um `Node2D`. Isso porque pode ser interessante deformar a trajetória, e o editor vai emitir warning se ele for o node raiz. 

O manuseio do `Path2D` é bem simples e direto, você clica no espaço 2D e ele vai adicionando e conectando os pontos. A opção destacada pelo quadrado vermelho abaixo é para mostrar a grid de pixels na tela, isso facilita na hora de desenhar a trajetória. Dentro do quadrado amarelo temos as opções básicas para manusear a ferramenta.  

<p align="center">
   <img src="https://github.com/user-attachments/assets/13c94570-8649-42f5-8f6e-2339fd6dfe06" width="600">
</p>

## PathFollow2D

O caminho sozinho não faz muita coisa, é necessário objetos que percorram a trajetória definida. Esse é o papel do `PathFollow2D`. Temos que adicioná-lo como filho do `Path2D`. Você pode alterar a posição do `PathFollow2D` e até deixá-lo fora da trajetória, mas isso não importa, ele sempre vai começar no ponto inicial. Este é o primeiro ponto que você marcou e que está destacado na trajetória.

<p align="center">
   <img src="https://github.com/user-attachments/assets/0bdbeac8-31f5-4486-9614-5341e440e70f" width="600">
</p>

Apesar de termos a trajetória desenhada e o sprite posicionado, isso não basta para começar o movimento. O modo como o sprite vai seguir a trajetória é determinado a partir de um script associado ao `PathFollow2D`. A variável `progress_ratio` é herdada do `PathFollow2D`. Considerando o ponto inicial como 0 e o final como 1, essa variável nos dá um valor entre 0 e 1 indicando a posição do ponto na trajetória. No script abaixo, estamos dizendo que ele começa no início da trajetória e avança $0.1$% do total a cada frame. Note que depois disso os incrementos continuam, mas isso não é problema pois `progress_ratio` será igual a 0 novamente assim que o objeto der uma volta completa.

<p align="center">
   <img src="https://github.com/user-attachments/assets/c5a2eb2b-3e55-493b-8bf1-0ead97f39542" width="500">
</p>

## Variações do mesmo objeto

É importante lembrar que mesmo com o *Editable Children*, o script ainda é o mesmo para todas as cópias. Se quiser um script diferente, terá que desvincular o atual do node e criar um novo do zero. Neste caso aqui isso poderia parecer uma solução viável, pois criamos duas cópias do mesmo objeto mas queremos que eles percorram a trajetória de maneiras distintas.

<p align="center">
   <img src="https://github.com/user-attachments/assets/eb683a33-adc1-41fc-b493-d0f3f9996f04" width="600">
</p>

O objeto da esquerda (P1), vai seguir a fórmula que definimos anteriormente, mas queremos que o da direita (P2) siga a regra `progress_ratio` = $sin(t)$, com $t \in [0, \pi/2]$. Uma maneira de evitar múltiplos scripts é buscar os nomes P1 e P2 e fazer a diferenciação de regras a partir disso. A função `get_parent()` retornar o pai do objeto atual. Neste caso, como o script está rodando em `PathFollow2D`, pai sempre será `Path2D`. Então devemos chamar mais uma vez o método, `get_parent().get_parent()` para obter o pai do pai. Na cena original do `Path2D` isso seria o `Node2D`, mas ao chamar da cena principal, este node foi renomeado para P1 e P2. Daí é possível obter as referências. O código novo fica assim:

<p align="center">
   <img src="https://github.com/user-attachments/assets/a97b8f3e-74c8-459f-883a-1f2af0386309" width="500">
</p>



