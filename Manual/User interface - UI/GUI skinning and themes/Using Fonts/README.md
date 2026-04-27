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

Você pode baixar e carregar arquivos de fonte *.fnt* no seu projeto da maneira usual. Alternativamente, você pode importar qualquer imagem para ser usada como uma fonte bitmap. Para isso, selecione a imagem no painel *FileSystem*, vá para a aba de *Importar* acima, altere o campo *Import As:* para *Font Data (Image Font)* e clique em *Reimport*.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/ea6e9ea5-acc1-4830-97ce-1a5a8d146cce" />
</p>

Feito isso, a fonte estará pronta para ser carregada no projeto.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/56af9a4c-227c-44e4-b22a-5520f6c60a20" />
</p>


