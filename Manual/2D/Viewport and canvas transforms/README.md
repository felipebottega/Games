# Viewport and canvas transforms

## Sistema de coordenadas locais e globais
Vamos falar sobre sistemas de coordenadas neste tutorial. Começamos inicializando uma cena simples, um  `Node2D` contendo o `Sprite2D` do logo da Godot.

<p align="center">
  <img src="https://github.com/user-attachments/assets/41c58729-46fe-497f-981d-99dfbf2ec4c2" width="600">
</p>

Se você for no Inspector agora e abrir a aba *Transform* de ambos, as posições deles devem ser $(0, 0)$. A figura abaixo mostra isso, o `Node2D` à esquerda e o `Sprite2D` à direita.

<p align="center">
  <img src="https://github.com/user-attachments/assets/26904547-7b24-4582-acbc-a255593bb572" width="150">
  <img src="https://github.com/user-attachments/assets/eb8dd125-bf5f-42cf-9c85-f6e4a6584019" width="140">
</p>

Agora vamos mover apenas o node do sprite. Repare que o `Node2D` continua na origem enquanto que o filho mudou de posição.

<p align="center">
  <img src="https://github.com/user-attachments/assets/98985292-8f48-4731-8de3-4ebe335d9f0b" width="500">
  <img src="https://github.com/user-attachments/assets/be7340a8-4fce-47d3-95a3-780a5a633f1e" width="150">
  <img src="https://github.com/user-attachments/assets/8eeb30c8-eaf5-47a7-8eba-394a590aad56" width="150">
</p>

Salve essa cena do jeito que está e crie uma outra cena chamada *World*, com apenas um node do tipo `Node2D`. Feito isso, coloque a cena inicial dentro da *World* e mova ela de posição. Como podemos ver, dentro da cena *World* a nossa cena inicial encontra-se em $(44, 112)$. Isso significa que o sprite também está numa posição nova, que é $(485+44, 243+112) = (529, 355)$. O sistema de coordenadas do sprite com o node raíz é o sistema de coordenadas locais, enquanto que o sistema em relaçao ao mundo é o sistema de coordenadas globais.


<p align="center">
  <img src="https://github.com/user-attachments/assets/adae25ce-f16e-4a63-8832-4146efbe446c" width="1100">
</p>

A partir disso, notamos que o sprite possui pelo menos dois sistemas de coordenadas: o sistema em relação ao node raíz de sua cena e o sistema em relação ao "mundo real" (a cena onde ele é executado).  
