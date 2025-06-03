# Movements

Este projeto é apenas um estudo de como fazer movimentos com os sprites (node `Sprite2D`). Isso é diferente de sprites animados (`AnimatedSprite2D`), pois sprites animados mudam a imagem, enquanto que um sprite é uma imagem fixa. Eu apenas fiz scripts que pudessem movimentar e deformar estas imagens.

Assim como no projeto do tabuleiro de Galton, é necessário ir para *Project → Project Settings → Display → Window* e coloque as configurações abaixo:
  
  *Initial Position Type = Absolute*
  
  *Mode = viewport*
  
  *Aspect = keep*  
  
Para manter a nitidez dos pixels, vá em *Project → Project Settings → Rendering → Textures* e coloque *Default Texture Filter = Nearest*, caso contrário você terá um efeito mais "borrado" (smooth) nos pixels.
