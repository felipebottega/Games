# Handling quit requests

## Lidando com notificação para sair do jogo

Vimos um pouco sobre notificações [neste tutorial de internacionalização](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Internationalization/Internationalizing%20games#_notification). Basicamente é uma função que fica escutando notificações emitidas pelo jogo durante a execução. O argumento de entrada desta função é um número inteiro associado ao evento que foi notificado. O código abaixo lida com notificações para sair do jogo.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/6769ecfd-fdbd-49a5-942c-c76b3e504c8d" />
</p>

Essa função lida com notificações do sistema, como clicar no X da janela, usar Alt+F4, comando externo para fechar a janela, evento de shutdown do sistema, entre outros. 

> PS: Caso você queira fazer algum botão no jogo para sair, ou algo do tipo, pode só chamar a `get_tree().quit()` diretamente, sem notificações. Inclusive, foi o que fizemos no [jogo do gafanhoto](https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/Saving%20games), no scritp do [menu](https://github.com/felipebottega/Games/blob/gh-pages/Manual/File%20and%20data%20IO/Saving%20games/scripts/game/ui/menu.gd). 

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Input%20handling/Controllers%2C%20gamepads%2C%20and%20joysticks">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Math/Math">Próximo ➡</a>
</p>
