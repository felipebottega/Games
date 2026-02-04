# Physics engines

Uma *engine física* basicamente é um software que fornece simulações aproximadas para sistemas físicos. Em jogos, o mais comum é termo simulações para dinâmica clássica: corpos rígidos, colisões, gravidade, forças, fluídos, entre outros. Inicialmente a Godot possuía a sua própria engine de física 3D. Anos depois, incorporou na lista de opções a engine física 3D chamada [Jolt](https://github.com/jrouwe/JoltPhysics). Até hoje a engine física 2D default ainda é a engine da própria Godot. 

## Alterando a engine física
Para trocar a engine física do seu projeto, basta ir em *Project → Project Settings → General → Physics → 2D (3D) → Physisc Engine*. No caso do 3D, você tem a opção de usar a engine física da Godot, a Jold ou a dummy (basicamente é anular a física). Já no caso 2D você só tem a física default e a dummy. Note que neste mesmo painel você tem a opção de alterar a quantidade de iterações físicas por segundo (vimos [anteriormente](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20introduction#physics-process) que são 60).

Caso você queira uma engine física externa, deve baixá-la e colocar a pasta dessa engine dentro da pasta **addons* no seu projeto. Importante notar que não pode ser qualquer engine física, mas sim uma feita especificamente para a Godot. Abaixo, mostramos um conteúdo típico da pasta de uma engine física. Neste exemplo, foi usada a engine [Godot Rapier Physics](https://godot.rapier.rs/). Depois que a engine foi inserida dentro do seu projeto, ela deverá aparecer na lista de engines.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/9ebfb125-b438-4bdc-add1-79852cced898" />
  <img width="700" src="https://github.com/user-attachments/assets/fa81a124-a03f-4168-be67-6de4c50f9131" />
</p>
