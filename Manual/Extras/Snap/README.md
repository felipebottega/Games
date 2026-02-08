# Snap

A tradução de "snap" para o português pode ser "encaixe" ou "alinhamento". A ideia é fazer algo variar de acordo com encaixes pré-definidos em vez de ser livremente. O exemplo abaixo vai esclarecer isso.

## Grid snap

Quando ativamos o *Grid Snap* no espaço 2D do editor, uma grid aparece. A partir de agora, sempre que você mover um objeto arrastando-o com o mouse, ele vai se mover em passos discretos de acordo com a grid. Como cada bloco da grid tem 8 pixels, o objeto vai se deslocar de 8 em 8 pixels. Não apenas isso, mas a própria régua do editor agora só faz medições de 8 em 8 pixels. Toda a edição funciona em torno dessa discretização.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/b194a55c-5330-4ae5-88a2-a94e36173fb6" />
  <img width="600" src="https://github.com/user-attachments/assets/29d11b3e-ab75-4d0f-bd54-75520d8a1228" />
</p>

## Outros tipos de snap

Caso você use animação, também é possível ativar o snap para a timeline. A ideia é semelhante, mas agora o passo discretizado é temporal em vez de espacial.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/ac39e28b-1726-4662-8be3-d2a049a87e78" />
</p>

Sempre que você encontrar algo de snap na Godot, a ideia é discretizar o espaço dos parâmetros de modo que a alteração sempre se encaixe na nova configuração adotada. Em muitos casos você não precisa de alterações contínuas de parâmetros, e é nestes casos que aplicar o snap pode ser de grande ajuda.

