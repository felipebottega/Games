# ParticleProcessMaterial 2D Usage

Vimos bastante coisa no [tutorial de partículas](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Rendering/2D%20particle%20systems), mas deixamos algumas propriedades de lado. Vamos dar um passo para trás e ver algumas propriedades do *Particle Process Material*. Para lembrar como abrir a aba das propriedades, dê uma olhada no tutorial mencionado.

## Mais propriedades do Particle Process Material

- **Angle:** É possível aplicar uma rotação na partícula quando ela é emitida. Deixando um range de valores, as rotações variam aleatoriamente naquele range. É importante ressaltar que esse ângulo de rotação não é alterado durante o tempo de vida da partícula, ela permanece naquele ângulo. Se quiser que ele seja alterado, é necessário abrir a aba da curva e definir o comportamento da mudança de ângulo, como mostrado na imagem abaixo.
  > PS: É importante não confundir esse ângulo com o ângulo da trajetória da partícula. Note na imagem que todas estão caindo em linha reta, são seus sprites que estão sendo rotacionados.

<p align="center">
  <img src="https://github.com/user-attachments/assets/3aada1fa-acc3-4ea2-8936-bd669b750577" width="600">
</p
  


