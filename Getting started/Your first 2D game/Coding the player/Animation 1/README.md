# Animation 1

Para fazer um sprite ter movimentos, utilizaremos o node `AnimatedSprite2D`. Neste caso o node chamado `Trevor` é do tipo `RigidBody2D`, mas vale ressaltar que outros tipos de nodes também funcionam com `AnimatedSprite2D`. 

Uma coisa interessante que eu não conhecia mas é bem útil é o botão *Group Selected Nodes* destacado na imagem abaixo. Ele faz com que os filhos do node raíz da cena não sejam selecionáveis em outras cenas. Ou seja, se você clicar num deles, automaticamente é o node pai que será selecionado. Várias vezes eu queria mover um sprite na cena principal e movia só a collision shape dele sem querer, ou vice-versa. Então descobrir esse botão foi um alívio parar mim!

<p align="center">
    <img src="https://github.com/user-attachments/assets/a761a71f-cb31-43c4-9477-900ee340e000" width="700">
</p>

