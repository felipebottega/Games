# Movements

Este projeto é apenas um estudo de como fazer movimentos com os sprites (node `Sprite2D`). Isso é diferente de sprites animados (`AnimatedSprite2D`), pois sprites animados mudam a imagem, enquanto que um sprite é uma imagem fixa. Eu apenas fiz scripts que pudessem movimentar e deformar estas imagens.

Assim como no projeto do tabuleiro de Galton, é necessário ir para *Project → Project Settings → Display → Window* e coloque as configurações abaixo:
  
  - *Initial Position Type = Absolute*  
  - *Mode = viewport*  
  - *Aspect = keep*  
  
Para manter a nitidez dos pixels, vá em *Project → Project Settings → Rendering → Textures* e coloque *Default Texture Filter = Nearest*, caso contrário você terá um efeito mais "borrado" (smooth) nos pixels. Também utilizei a técnica de criar transparência ao background dos sprites, algo muito importante para se fazer. Abra o sprite no GIMP e use a *magic wand tool* para selecionar apenas o background. Daí dê o segundo clique do mouse em qualquer região do background e selecione *Camada -> Transparência -> Adicionar canal alfa*, após isso é só apertar *delete* e o background vai embora.

<p align="center">
  <img src="https://github.com/user-attachments/assets/387da7ff-855f-41c5-94d0-2a6eed125309" width="400"/>
</p>

Outra coisa que este projeto trouxe à minha atenção é o fato de que apenas duplicar um node na cena principal não garante que ele é totalmente independente do node de origem. Em particular, eu fiz 4 cópias do node `cross` e os posicionei em locais diferentes na cena, mas na hora de executar só aparecia o da posição original. A variável `position` estava atrelada ao node original. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/7cd0de5f-c4f4-4b46-80df-70b594d492bf" width="350"/>
</p>

Para garantir independência, dê o segundo clique do mouse no node e selecione *Make Local*. 


