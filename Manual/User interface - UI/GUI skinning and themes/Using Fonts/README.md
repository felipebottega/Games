# Using Fonts

Existem dois tipos de arquivos de fonte: dinâmicas (formatos *TTF/OTF/WOFF/WOFF2*) e bitmap (formato *.fnt*). As fontes dinâmicas são a opção mais comum, pois podem ser redimensionadas e ainda manter a nitidez em tamanhos maiores. Graças à sua natureza vetorial, elas também podem conter muito mais glifos, mantendo um tamanho de arquivo razoável em comparação com as fontes bitmap. Uma fonte bitmap é basicamente um conjunto de letras desenhadas como imagens prontas, pixel por pixel.

Em tipografia, *glifo* é uma figura que dá um tipo de característica particular a um símbolo específico. 

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/aec28c27-ff0f-4e28-b748-c469f528b364" />
</p>

## Fontes dinâmicas

As fontes dinâmicas da Godot são as seguintes:

- TrueType Font or Collection (*.ttf*, *.ttc*)
- OpenType Font or Collection (*.otf*, *.otc*)
- Web Open Font Format 1 (*.woff*)
- Web Open Font Format 2 (*.woff2*)

O modo de lidar com elas é o usual que fizemos nos tutoriais, anteriores: colocar o arquivo no projeto e fazer load nele. 

## Fontes bitmap

Você pode baixar e carregar arquivos de fonte *.fnt* no seu projeto da maneira usual. Alternativamente, você pode importar qualquer imagem para ser usada como uma fonte bitmap. Para explicar as fontes de bitmap, usamos a imagem abaixo de exemplo, da documentação oficial.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/c0536390-95b4-4cfa-9aa0-c801fe942de1" />
</p>

Selecione a imagem no painel *FileSystem*, vá para a aba de *Importar* acima, altere o campo *Import As:* para *Font Data (Image Font)* e clique em *Reimport*.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/ea6e9ea5-acc1-4830-97ce-1a5a8d146cce" />
</p>

Feito isso, a fonte estará pronta para ser carregada no projeto.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/56af9a4c-227c-44e4-b22a-5520f6c60a20" />
</p>

Ao tentar usar essa fonte, você perceberá que ela não renderiza corretamente. Acontece que não basta fazer os passos acima, também é necessário configurar a imagem para que a engine consiga ler corretamente os seus caracteres. Os passos abaixo devem ser seguidos. 

 1. A opção *Character Ranges* é um array que mapeia cada posição na imagem (em coordenadas de tiles, não em pixels). O atlas de fontes é percorrido da esquerda para a direita e de cima para baixo. 

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/4bb28ae2-1867-4fa6-b4bb-55914407f689" />
</p>

2. Os valores *Columns* e *Rows* deve corresponder ao número de colunas e linhas deste atlas. é necessário quo o produto *Columns* $\times$ *Rows* corresponda ao total de elementos declarado no item acima.

Apenas com esta configuração já é possível visualizar os caracteres corretamente no projeto.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/ae00b063-efea-4584-9a1b-408c1d5b8254" />
</p>

 3. Se a imagem da fonte contiver margens não utilizadas pelos glifos, tente ajustar os valores *Image Margin*. Essa margem é aplicada apenas uma vez ao redor de toda a imagem. Se a imagem da sua fonte contiver guias (na forma de linhas entre os glifos) ou se o espaçamento entre os caracteres parecer incorreto, tente ajustar os valores *Character Margin*. Essa margem é aplicada a cada glifo importado.

## Contornos

É possível ativar o contorno de uma fonte indo em *Inspector → Control → Theme Overrides → Colors → Font Outline Color*. Depois disso, é necessário ainda alterar o tamanho do contorno em *Inspector → Control → Theme Overrides → Constants → Outline Size*. Se quiser isso como um recurso de tema, também é possível. Basta seguir os passos vistos no [tutorial de temas](https://github.com/felipebottega/Games/tree/gh-pages/Manual/User%20interface%20-%20UI/GUI%20skinning%20and%20themes/Using%20the%20theme%20editor) e alterar estas mesmas propriedades.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/b8cecf71-cbe4-45f1-be83-209dbad3c029" />
</p>

## Sombras

O suporte para sombras é mais limitado que o de contornos, só funciona para `Label` e `RichTextLabel`. 

É possível ativar as sombras de uma fonte indo em *Inspector → Control → Theme Overrides → Colors → Font Shadow Color*. Depois disso, é necessário ainda alterar o tamanho e forma da sombra em *Inspector → Control → Theme Overrides → Constants*, alterando os valores de *Shadow Offset X*,  *Shadow Offset Y* e *Shadow Outline Size*. Da mesma maneira que foi para contornos, também é possível fazer sombras através de recurso de tema.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/30464cfe-3a24-48eb-9c2d-0fd2c3e131df" />
</p>
