# Custom post-processing

Pós-processamento com shaders consiste em aplicar um ou mais efeitos/filtros sobre a tela. Cada efeito é implementado através de um `CanvasLayer` contendo um `ColorRect`. Pode-se repetir essa estrutura múltiplas vezes, afim de aplicar múltiplos efeitos em sequência. Uma diferença relevante em relação a tudo o que vimos até agora é que o efeito é aplicado na tela como um todo, não na textura de um objeto em particular.

## Implementando um pós-processamento

Montamos uma cena contendo dois sprites e uma label. Um dos sprites é a imagem utilizada no [tutorial oficial](https://docs.godotengine.org/en/stable/tutorials/shaders/custom_postprocessing.html) e a outra imagem é o logo da Godot. Tanto o logo da Godot quanto a label ficaram com metade dentro da viewport e a outra metade fora. Isso foi feito assim para mostrar a diferença entre ter o filtro aplicado ou não.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/370c778c-aa2e-463b-b746-3fa8bc234a4e" />
  <img width="500" src="https://github.com/user-attachments/assets/8899709a-075d-4ba7-8f84-db2bd69a3fd2" />
</p>

Agora adicione um `CanvasLayer` contendo um `ColorRect`. Em alguns tutoriais passados, foi utilizada essa mesma combinação de nodes para alterar a textura do próprio `ColorRect`. Neste tutoriais, o `ColorRect` foi esticado manualmente para ficar com o tamanho da viewport, mas isso não é necessário. Você pode clicar no *Anchor Preset* do node e selecionar o *Full Rect*, indicado na figura abaixo. Isso criará um retângulo branco ocupando todo o viewport. 

<p align="center">
  <img width="150" src="https://github.com/user-attachments/assets/993ef9fd-3832-49af-af64-9348b86b815d" />
</p>

O próximo passo agora é ir no *Inspector → CanvasItem → Material* e criar um arquivo de shader, é o processo usual.

Já usamos a chamada `texture(TEXTURE, UV)` em tutoriais anteriores. Ela extrai a cor do pixel da posição `UV` da textura `TEXTURE`. O argumento da textura não precisa ser o `TEXTURE`, que é a textura do `ColorRect` neste caso. Inclusive, já trabalhamos com texturas vindas do exterior através de um uniform. Faremos o mesmo aqui. Essa textura será definida por `uniform sampler2D screen_texture : hint_screen_texture`. Ao usar essa [uniform hint](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Shading%20reference/Shading%20language#uniform-hints), automaticamente o shader usa a tela toda como textura.

Abaixo temos um shader que aplica um efeito blur pelo eixo $x$. Ao usar o `hint_screen_texture`, é necessário usar também o [`SCREEN_UV`](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Shading%20reference/CanvasItem%20shaders#valores-nativos-do-fragment) para aessar o pixel correto. Esse valor nativo te dá a coordenada UV em relação a tela, que é o que precisamos nesse caso. Abaixo você pode ver o efeito deste shader na cena.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/9586b945-9c2e-42be-8eea-d89feec915cf" />
</p>

Caso o `CanvasLayer/Label` venha após o shader, na árvore de nodes, o efeito não é aplicado nele. Isso é útil em situações que queremos aplicar um efeito em múltiplas texturas da cena mas não em todas.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/abb9a633-302b-4d65-9f5c-f2368facbe84" />
</p>

## Implementando múltiplos pós-processamentos

É possível encadear uma sequência da efeitos/filtros sobnre os nodes. Basta repetir a estrtura `CanvasLayer/ColorRect` múltiplas vezes, cada uma implementada cmo explicado acima. 

Na cena abaixo, temos um efeito de mosaico (`CanvasLayer`), seguido do efeito de blur pelo eixo $x$ que fizemos acima (`CanvasLayer2`), seguindo do efeito blur pelo eixo $y$ (`CanvasLayer3`), seguido do efeito de deixar a cena mais avermelhada (`CanvasLayer4`).

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/12eb2453-2f65-4497-afc3-15422d9e82ee" />
</p>

Abaixo está o código que aplica o efeito de deixa tudo avermelhado. Recomendo ver os outros, mas decidi mostrar apenas esse aqui pois ele é um código minimal que mostra tudo o que precisamos saber deste tutorial.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/e398b77b-de2d-4e9f-ba99-36998ca485f0" />
</p>
