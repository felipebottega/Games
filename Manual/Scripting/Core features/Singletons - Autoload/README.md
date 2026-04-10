# Singletons - Autoload

*Autoload* (ou o termo menos usado, *singleton*) é algo que já aplicamos na prática algumas vezes, mas sem explicar o conceito. Recomendo dar uma olhada nos tutoriais de [TileMap](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Tools/Using%20TileMaps%20-%20Game#toques-finais), [Background loading](https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/Background%20loading#m%C3%A9todo-esperto-de-pr%C3%A9-carregamento) e [Saving games](https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/Saving%20games#npcs-e-checkpoints).

Autoload em Godot é um recurso que permite manter um script ou cena sempre carregada durante toda a execução do jogo. Na prática, ele funciona como um ponto global de acesso, onde você pode armazenar dados ou comportamentos que precisam persistir. Considere a situação em que o jogo precisa manter a quantidade de moedas do jogador entre diferentes fases. Se esse valor estiver em uma cena comum, ele será perdido ao trocar de fase. Ao usar um Autoload, esse dado permanece disponível e pode ser acessado de qualquer parte do jogo. Em resumo, Autoload é usado para representar estado ou sistemas globais persistentes.

## 
