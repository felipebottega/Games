# Physics engines

Uma *engine física* basicamente é um software que fornece simulações aproximadas para sistemas físicos. Geralmente em jogos temos simulações para dinâmica clássica: corpos rígidos, colisões, gravidade, forças, fluídos, entre outros. Inicialmente a Godot possuía a sua própria engine de física 3D. Anos depois, incorporou na lista de opções a engine física 3D chamada [Jolt](https://github.com/jrouwe/JoltPhysics). Até hoje a engine física 2D default ainda é a engine da própria Godot. 

## Alterando a engine física
Para trocar a engine física do seu projeto, basta ir em *Project → Project Settings → General → Physics → 2D (3D) → Physics Engine*. No caso do 3D, você tem a opção de usar a engine física da Godot, *Jolt* ou dummy (esta última basicamente anula a física). Já no caso 2D você só tem a física default e a dummy. 

Caso você queira uma engine física externa, deve baixá-la e colocar a pasta dessa engine dentro da pasta *addons* no seu projeto. Importante notar que não pode ser qualquer engine física, mas sim uma feita especificamente para a Godot. Abaixo, mostramos um conteúdo típico da pasta de uma engine física. Neste exemplo, foi usada a engine [Godot Rapier Physics](https://godot.rapier.rs/). Depois que a engine foi inserida dentro do seu projeto, ela deverá aparecer na lista de engines.

<p align="center">
  <img width="220" src="https://github.com/user-attachments/assets/9ebfb125-b438-4bdc-add1-79852cced898" />
  <img width="780" src="https://github.com/user-attachments/assets/fa81a124-a03f-4168-be67-6de4c50f9131" />
</p>

Por default, as engines utilizadas na Godot não possuem física de fluídos. A engine *Rapier* é uma alternativa para quem precisa dessas simulações, tanto em 2D quanto 3D. Para quem tiver interesse em ver um caso de aplicação em 2D, recomendo ver o meu [tutorial sobre fluídos com Rapier](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Extras/Godot%20Rapier%20Physics).

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20introduction">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/StaticBody">Próximo ➡</a>
</p>
