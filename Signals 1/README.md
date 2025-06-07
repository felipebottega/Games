# Signals 1

Este pequeno jogo teve como objetivo a aplicação de *sinais* em Godot. Apenas utilizamos os sinais na sua forma simples, isto é, sem código, apenas clicando em ícones da interface da Godot. Em *Signals 2* veremos o modo mais avançado de tratar de sinais. 

## Trabalhando apenas com shapes de colisão

Antes de falar de sinais, quero falar de algumas coisas novas que aprendi, começando pelos shapes de colisão. Eu não sabia disso, mas é possível não utilizar sprites e usar apenas os shapes de colisão. Isso significa focar na mecânica e deixar o visual de lado. Com sprites ou não, você pode ir em *Debug* e selecionar a opção *Visible Collision Shapes*, com isso as shapes de colisão sempre estarão visíveis, o que é bom para debugar.

<p align="center">
    <img src="https://github.com/user-attachments/assets/fd0ea7fe-f297-42b6-b632-3595d956a002" width="200">
</p>

## Polygon2D e CollisionPolygon2D

Para este jogo, eu queria formatos que não fossem quadrados ou elipses. Até tem como usar formas côncavas com o `CollisionShape2D` mas não consegui fazer funcionar e o próprio editor me recomendou usar `Polygon2D` e `CollisionPolygon2D`. Ao carregar o `CollisionPolygon2D`, ele te dá uma forma de quadrado no espaço 2D, é para criar o seu shape dentro deste quadrado. Se atente às três opções acima. A que está marcada por default é para acrescentar pontos para o seu shape. A opção ao lado é editar o shape depois de pronto. A terceira opção é para remover pontos (na minha opinião a opção de edição já faz adição e remoção de pontos, então a terceira me pareceu redundante). 

<p align="center">
    <img src="https://github.com/user-attachments/assets/173a51f1-f9a7-4344-af7f-718864ac4f55" width="200">
</p>

Você deve fazer um shape igual com o `Polygon2D`, sobrepor ambos no espaço 2D. Estes dois nodes devem ser filhos de um outro, como um `StaticBody2D` neste caso. O propósito do `Polygon2D` é introduzir a textura dentro de um formato que você criou na Godot. Caso contrário, teria que criar um PNG com o formato exato do shape da colisão, o que seria muito mais trabalhoso.






