# Animation 1

Para fazer um sprite ter movimentos, utilizaremos o node `AnimatedSprite2D`. Neste caso o node chamado `Trevor` é do tipo `RigidBody2D`, mas vale ressaltar que outros tipos de nodes também funcionam com `AnimatedSprite2D`. 

Uma coisa interessante que eu não conhecia mas é bem útil é o botão *Group Selected Nodes* destacado na imagem abaixo. Ele faz com que os filhos do node raíz da cena não sejam selecionáveis em outras cenas. Ou seja, se você clicar num deles, automaticamente é o node pai que será selecionado. Várias vezes eu queria mover um sprite na cena principal e movia só a collision shape dele sem querer, ou vice-versa. Então descobrir esse botão foi um alívio para mim!

<p align="center">
    <img src="https://github.com/user-attachments/assets/a761a71f-cb31-43c4-9477-900ee340e000" width="700">
</p>

Agora vamos para a parte que interessa. Selecione o node `AnimatedSprite2D` e abra a aba *Animation* em *Inspector*. Selecione *Sprite Frame* e *New SpriteFrames*, como mostrado abaixo. Clique no nome *SpriteFrames* que apareceu no mesmo local (figura do meio, abaixo), daí o editor de animação (figura da direita, abaixo) deve aparecer. 

<p align="center">
    <img src="https://github.com/user-attachments/assets/ca0a10c6-7b4b-4f6a-a4f6-85119f5294e2" width="1200">
</p>

Começaremos pelo boneco estático, o *idle*. Troque o nome onde está escrito "default" e arraste a imagem do idle, em *FileSystem*, para o editor de animação.

<p align="center">
    <img src="https://github.com/user-attachments/assets/37526b0f-9682-4346-a548-f4791120b9cb" width="600">
</p>

