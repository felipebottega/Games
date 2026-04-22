# Using Containers

`Container` é outra classe que é filha da `Control`. Ela não é usada diretamente, geralmente se usa um dos seus filhos, cada um com um propósito. Sem saber, nós já usamos diversas vezes o node `SubViewportContainer`, que é um container específico para o node `SubViewport`.

<pa glin="center">
  <img width="900" src="https://github.com/user-attachments/assets/439a24bd-6312-4909-a0f3-3431bb9ad9fc" />
</p>

No [tutorial passado](https://github.com/felipebottega/Games/tree/gh-pages/Manual/User%20interface%20-%20UI/UI%20building%20blocks/Size%20and%20anchors), o conhecimento de âncora e as propriedades relacionadas foram úteis para criar nodes control de maneira mais controlada e organizada. Porém, este conhecimento não ajuda quando se tem um conjunto de nodes control. Por exemplo, se um jogo precisar de uma grid de botões, você terá que posicionar cada um por vez. Os nodes de container existem justamente para esse tipo de problema.

Vamos discutir um pouco dos containers mais usuais e suas propriedades. A partir desse pequeno conjunto de containers será possível se aventurar nos outros com pouca dificuldade.

## HBoxContainer


