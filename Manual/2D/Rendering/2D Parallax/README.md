# 2D Parallax

Para apresentar as principais funcionalidades de paralaxe em Godot, faremos uma cena de paralaxe com objetos abstratos. 

## O quadriculado do editor é 8x8 pixels

Para obter o efeito de paralaxe, você deve preparar as figuras das camadas e se certificar de que elas tem os tamanhos apropriados. O modo mais comum de errar paralaxe é errando nos tamanhos. Caso os tamanhos sejam diferentes e você pretenda ajustar no editor da Godot, tenha em mente que o ajuste pelo gráfico se dá de 8 em 8 pixels. O ajuste fino deve ser no *Inspector*.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/46f9827b-7e98-4692-b8d8-17d9f9f0a0c3" />
</p>

## Preparando as camadas para o Parallax2D

Note que o objeto mais da frente tem dimensões $1302 \times 402$. Além de se atentar a isso quando for fazer as outras camadas, também não esqueça de configurar o viewport de acordo. Neste exemplo eu quero que o viewport tenha a largura igual à da figura.

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/1d784fd5-3b89-469b-9273-6576d374680b" />
</p>

### Dica para criar sprite sheet

A segunda camada eu quero que sejam diversas bolas lado a lado. Para obter uma separação uniforme, o ideal é criar uma grid para controle. Isso também serve para sprite sheets. Começamos com a figura de uma única bola. Note que a largura da imagem já está em $1302$..

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/0c725d62-9589-4fcd-8ba1-0edf5a298504" />
</p>

Depois disso vamos em *Visualizar → Exibir grade* e depois em *Imagem → Configurar grade*. Depois disso é ajustar até encontrar o ponto ideial. Feito isso, copie a bola e coloque em cada uma das lacunas.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/169d08c8-91bf-4880-899e-8bf6e5506277" />
  <img width="250" src="https://github.com/user-attachments/assets/a9b4ac97-e020-4409-b1fb-0a0920586d7e" />
</p>

A colocação da bola dentro de cada frame foi no olho. Pode-se melhorar a precisão utilizando uma grid mais fina e depois reduzindo para a separação de cada frame. Abaixo segue o resultado final. Note que há uma gap no final. Ajustaremos isso mais adiante com uma ferramenta da Godot para configurar paralaxe.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/03d55fd3-f408-4e93-8e07-3b590fac7615" />
</p>

Este procedimento mostra a grade mas ela não é salva quando você exporta para PNG. Se fizer questão de salvar a grade junto, deve ir em *Filtros → Renderizar → Texturas → Grade*, como mostrado abaixo. 

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/cdbf041c-6b43-4d45-b6c0-39c5baaa8dbc" />
</p>

A terceira e última camada não tem o mesmo problema que a segunda, mas a figura tem largura de $1100$ pixels em vez dos $1302$ que gostaríamos. Também veremos como resolver isso com as ferramentas da Godot. Note que ambos os problemas poderiam ser tratados no próprio GIMP, de modo a começar a trabalhar na Godot com as figuras já corretas. Não faremos isso aqui apenas para mostrar as possibilidades pela Godot.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/49b54936-d891-4762-b34a-77b345402375" />
</p>


