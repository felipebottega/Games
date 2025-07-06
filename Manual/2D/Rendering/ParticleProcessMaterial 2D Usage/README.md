# ParticleProcessMaterial 2D Usage

Vimos bastante coisa no [tutorial de partículas](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Rendering/2D%20particle%20systems), mas deixamos algumas propriedades de lado. Vamos dar um passo para trás e ver algumas propriedades do *Particle Process Material*. Para lembrar como abrir a aba das propriedades, dê uma olhada no tutorial mencionado.

## Mais propriedades do Particle Process Material

- **Spawn/Angle:** É possível aplicar uma rotação na partícula quando ela é emitida. Deixando um range de valores, as rotações variam aleatoriamente naquele range. É importante ressaltar que esse ângulo de rotação não é alterado durante o tempo de vida da partícula, ela permanece naquele ângulo. Se quiser que ele seja alterado, é necessário abrir a aba da curva (*Angle Curve*) e definir o comportamento da mudança de ângulo, como mostrado na imagem abaixo.
  > PS: É importante não confundir esse ângulo com o ângulo da trajetória da partícula. Note na imagem que todas estão caindo em linha reta, são seus sprites que estão sendo rotacionados.

<p align="center">
  <img src="https://github.com/user-attachments/assets/3aada1fa-acc3-4ea2-8936-bd669b750577" width="600">
</p>

- **Animated Velocity:** Define a velocidade da rotação que foi definida na propriedade *Angle*. A lógica dos parâmetros é a de sempre.
- **Orbital Velocity:** Define a velocidade com que as partículas orbitam em torno da origem do node. É interessante deixar a gravidade baixa para isso, caso contrário elas simplesmente vão cair e a órbita sequer será notada.
  > PS: Notei que há um problema na animação quando as partículas vão para cima quando esta propriedade está ativa. Aumentar o FPS para $120$ resolver. O FPs é a propriedade *Fixed FPS* que fica dentro de *Time*.

<p align="center">
  <img src="https://github.com/user-attachments/assets/bb7e1bc2-e879-4374-b3e6-71107ff548ae" width="750">
</p>

- **Radial Velocity:** É a velocidade com que as partículas se afastam do centro. Se for negativa, elas são atraídas para o centro. 
- **Linear Accel:** Define a aceleração linear de cada partícula. Deste modo, ela pode ganhar mais velocidade com o passar do tempo.
- **Radial Accel:** Análogo à aceleração linear, mas é para a velocidade radial.

## Experimento com velocidade radial

De início, a velocidade e aceleração radial podem parecer conceitos vagos, mas existe um experimento que deixa claro como tudo funciona. Coloque uma quantidade razoável de partículas por ciclo, pelo menos $100$. Vá na velocidade radial e defina a curva para partir do zero até um valor positivo não muito alto e depois faça a curva cair até o máximo negativo. Qual o comportamento esperado disso? Os pontos vão se afastar da origem por um tempo (velocidade radial positiva) e depois serão sugados de volta (velocidade radial negativa). Note que o comportamento default é que as partículas sejam emitidas numa frequência constante no tempo. Para ter o efeito de círculo mostrado na figura, é necessário que todas as partículas sejam emitidas ao mesmo tempo. Conseguimos deixando o *Explosiveness* no máximo.

<p align="center">
  <img src="https://github.com/user-attachments/assets/820b62df-1db0-4b1b-b876-a5f1bfbe7c48" width="750">
</p>
