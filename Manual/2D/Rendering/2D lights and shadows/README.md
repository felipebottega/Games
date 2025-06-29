# 2D lights and shadows

O principal node para a aplicação de luzes é o `PointLight2D`. Todos os outros nodes e técnicas são para melhorias extras.  Para apresentar este node, iremos recriar a cena do Castlevania vista no [Animation 1](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Coding%20the%20player/Animation%201).

Após copiar as pastas daquela cena para o projeto atual, precisamos ajustar as configurações do projeto, como mostrado abaixo. Para manter as coisas mais organizadas, scriamos também a pasta *scripts* para colocar os sripts lá.

<p align="center">
  <img src="https://github.com/user-attachments/assets/e81844e7-06d7-4b07-b4f5-2439c2b6c676" width="500">
  <img src="https://github.com/user-attachments/assets/99f751aa-0145-49ec-bc5b-d15b1e6b7801" width="500">
</p>

Além dos sprites anteriores, também incluímos um sprite para o fundo, outro de blocos flutuantes e uma pilastra. O fundo e a pilastra são `Sprite2D`, enquanto que o bloco é um `StaticBody2D`. Cada um tem a sua própria cena. No bloco, colocamos fricção igual a zero. Se a fricção fosse positiva, o boneco poderia "grudar" momentaneamente na lateral dela e pular dali, o que seria um bug indesejável.

<p align="center">
  <img src="https://github.com/user-attachments/assets/9ab87513-be51-4712-8543-f39b3f3a3b89" width="200">
</p>

Na cena principal, também colocamos barreiras laterais invisíveis para que o jogador não saia da tela. Faça essas paredes invisíveis como `StaticBody2D` sem textura e fricção igual a zero. Abaixo temos uma visão geral de como está o projeto até o momento.

<p align="center">
  <img src="https://github.com/user-attachments/assets/d0d6efb5-0519-426f-b46b-2d060fdfbbdd" width="700">
</p>

Lembre-se de que a ordem dos nodes importa. Queremos os blocos flutuantes antes do boneco pois eles não cobrem o seu pé quando ele ele estpa em cima deles. Queremos o pilar vindo depois do boneco pois na cena ele passa por trás do pilar, dá um efeito bonito e a cena ganha mais tridimensionalidade.
