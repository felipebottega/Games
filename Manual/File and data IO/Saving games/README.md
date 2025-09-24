# Saving games

Este tutorial será mais extenso que o normal, pois vou mostrar as etapas da criação de um próximo jogo. Além de ser interessante a ideia de salvar e carregar em jogo (em vez de um exemplo avulso), também é um bom momento para colocar em prática tudo o que aprendemos e refrescar a memória.

## Cenário inicial

A ideia é fazer um jogo voltado para a dinâmica de pulos. O personagem principal, que é um gafanhoo, deve chegar até um local, e só é possível fazero caminho pulando. 

Vamos utilizar os assets [sunnyland-tall-forest-environment](https://opengameart.org/content/sunnyland-tall-forest-environment) para o cenário inicial do jogo. Este conjunto de assets possui um pequeno TileSet e alguns sprites. 

<p align="center">
  <img width="650" src="https://github.com/user-attachments/assets/575c675d-31cb-437e-be3b-01493c1cee05" />
</p>

Como certos sprites serão colocados em muitas partes do cenário, é mais interessante utilizá-los como tiles. Apesar do TileSet ser $16 \times 16$, precisamos customizar os tamanhos dos sprites, que são diferentes. Para isso, altere o valor de *Texture Region Size* até ficar adequado. Ao fazer isso, há uma chance de quadrados vazios serem marcados no tilemap. Você deve removê-los indo nos três pontinhos indicados na figura abaixo e selecionar *Remove Tiles Outside the Texture*.

<p align="center">
  <img width="650" src="https://github.com/user-attachments/assets/b21f85d1-8526-4268-9781-93a71a4a024b" />
</p>

Depois disso é só questão de editar os sprites e montar o cenário do jeito que achar melhor. Por enquanto está assim.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/c38deabf-846a-4647-ad2a-ee9af523477e" />
</p>
