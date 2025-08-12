# Animation Track types

Anteriormente, quando clicamos em *+ Add Track* no painel de animação, vimos que havia várias escolhas para o tipo de track, e escolhemos a opção *Property Track*. Neste tutorial, iremos ver como outros tipos de track funcionam. Por enquanto vamos pular tudo de 3D, pois não estamos abordando 3D ainda, e vamos pular a *Bezier Curve Track*, pois ela me pareceu redundante.

<p align="center">
  <img width="180" src="https://github.com/user-attachments/assets/533ffd2e-a4c8-4e50-8d57-8d6b1e5b75b3" />
</p>

## Call Method Track

Este, de longe, me parece ser o tipo de track mais interessante de todos. O track do tipo *call method* permite chamar uma função em um momento especificado dentro de uma animação. Por exemplo, você pode chamar `queue_free()` para excluir um nó no final de uma animação de morte. Clique em *+ Add Track* e selecione *Call Method Track*. Uma janela com a árvore de nodes vai se abrir. Escolhe o node que quer animar. Nós começamos criando uma animação de posição para a espada e depois adicionamos a track de *call method*, como mostrado abaixo.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/80ee2381-7ab8-4770-8b37-155344d54e6a" />
</p>

Na timeline do track *call method*, dê o segundo clique do mouse em algum instante para inserir um keyframe. Uma janela com diversas funções/métodos vai se abrir. 

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/26c8fbe4-b44b-437e-b8e3-f59a60f061e6" />
</p>

Para este exemplo, vamos utilizar o método `rotate`. Insira uma keyframe nesta track e vá para o Inspector. Você deve editar o que está em *Args*, que são os parâmetros passados para a função. É importante ter em mente que a animação com *call method* só tem efeito quando você executa a cena, ela não roda na prévia do editor.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/eecc1ebc-9962-4199-9f17-0e10aa234855" />
  <img width="450" src="https://github.com/user-attachments/assets/5fc2fb25-1eef-4921-96e4-bd6aecf5db3e" />
  <img width="250" src="https://github.com/user-attachments/assets/36396f2b-cd7c-46c3-8e41-c1cbc5388be7" />
</p>

> PS: A função `rotate` é diferente da `rotation` que temos usado até agora. A `rotation` trabalha com radianos e ela não define o ângulo, ela incrementa.

Você pode ir além das funções nativas. É possível chamar funções que você mesmo escreveu para inserir nas animações. Além da movimentação e rotação na espada, iremos utilizar a função abaixo para dar um efeito de cores na espada por um período certo de tempo. Chamamos atenção para o fato do script não estar no `Sprite2D`. Ou seja, é possível chamar uma função de qualquer script que esteja na mesma cena.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/0e87c984-127d-4e41-9fae-973b92155129" />
</p>

Depois que a fnção foi criada, basta repetir os passos anteriores, mas dessa vez buscando essa função. O painel de animação deve estar assim.

<p align="center">
  <img width="950" src="https://github.com/user-attachments/assets/9cccd53c-62c6-47bc-a64c-a7e6951cb35b" />
</p>


