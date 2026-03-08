# Overview of renderers

Em qualquer engine de jogos, a "renderização" é o ato de se desenhar algo na tela. O método como o desenho é feito depende do "renderer" (em português, "renderizador") utilizado. Na Godot, temos 3 principais renderers: *Forward+*, *Mobile* e *Compatibility*. Já esbarramos com este tópico [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Rendering/2D%20antialiasing#antialiasing-no-projeto) e [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Export/Exporting%20for%20the%20Web#lista-de-dicas-para-exportar-jogos-para-a-web).

## Escolhendo o renderizador

Assim que você cria um projeto novo, tem que escolher um renderizador. A escolha do renderizador depende muito do hardware target da sua aplicação.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/ec1cd989-239a-4b01-998e-3d80e2270e97" />
</p>

Escolha *Forward+* se:
  - Você estiver desenvolvendo para desktop.
  - Você tiver hardware relativamente novo.
  - Você estiver desenvolvendo um jogo 3D.
  - Você quiser usar os recursos de renderização mais avançados.

Escolha *Mobile* se:
  - Você estiver desenvolvendo para dispositivos móveis mais recentes, XR para desktop ou desktop.
  - Você estiver desenvolvendo um jogo 3D.
  - Você quiser usar recursos de renderização avançados, sujeitos às limitações do hardware móvel.

Escolha *Compatibility* se:
  - Você estiver desenvolvendo para dispositivos móveis mais antigos, dispositivos desktop mais antigos ou XR independente. O renderizador *Compatibility* oferece suporte à maior variedade de hardware.
  - Você estiver desenvolvendo para a web. Nesse caso, *Compatibility* é a única opção.
  - Você possui hardware antigo. Nesse caso, a opção *Compatibility* é a única escolha.
  - Você está desenvolvendo um jogo 2D ou um jogo 3D que não precisa de recursos avançados de renderização.
  - Você deseja o melhor desempenho possível em todos os dispositivos e não precisa de recursos avançados de renderização.
  
Lembre-se de que cada jogo é único e este é apenas um ponto de partida. Por exemplo, você pode optar por usar o renderizador *Compatibility* mesmo tendo a GPU mais recente, para poder oferecer suporte à maior variedade possível de hardware. Ou pode preferir usar o renderizador *Forward+* para um jogo 2D, para poder usar recursos avançados como shaders de computação.

## Trocando de renderizador 

