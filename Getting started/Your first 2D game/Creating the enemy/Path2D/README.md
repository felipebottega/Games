# Path2D

`Path2D` é utilizado quando você quer traçar trajetórias no ambiente. Pode ser uma trajetória que um inimigo vai trilhar em um loop, pode ser a trajetória que um NPC precisa fazer em dado momento, pode até ser uma trajetória abstrata que serve para determinar os pontos por onde certos projéteis podem ser disparados.

## Manuseando o Path2D

Primeiramente, recomendo colocar o `Path2D` como filho de outro node, como um `Node2D`. Isso porque pode ser interessante deformar a trajetória, e o programa vai emitir warning se ele for o node raiz. 

O manuseio do `Path2D` é bem simples e direto, você clica no espaço 2D e ele vai adicionando e conectando os pontos. A opção destacada pelo quadrado vermelho abaixo é para mostrar a grid de pixels na tela, isso facilita na hora de desenhar a trajetória. Dentro do quadrado amarelo temos as opções básicas para manuear a ferramenta.  

<p align="center">
   <img src="https://github.com/user-attachments/assets/13c94570-8649-42f5-8f6e-2339fd6dfe06" width="500">
</p>

## PathFollow2D

O caminho sozinho não faz muita coisa, é necessário objetos que percorram a trajetória. Esse é o papel do `PathFollow2D`. Temos que adicioná-lo como filho do `Path2D`. Você pode alterar a posição do `PathFollow2D` e até deixá-lo fora da trajetória, mas isso não importa, ele sempre vai começar no ponto inicial. Este é o primeiro ponto que você marcou e que está destacado na trajetória.

<p align="center">
   <img src="https://github.com/user-attachments/assets/0bdbeac8-31f5-4486-9614-5341e440e70f" width="500">
</p>

