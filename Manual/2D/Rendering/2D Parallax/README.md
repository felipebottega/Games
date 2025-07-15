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

A segunda camada eu quero que sejam diversas bolas lado a lado. Para obter uma separação uniforme, o ideal é criar uma grid para controle. Isso também serve para sprite sheets. Começamos com a figura de uma única bola. Note que a largura da imagem já está em $1302$.

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
  <img width="600" src="https://github.com/user-attachments/assets/49b54936-d891-4762-b34a-77b345402375" />
</p>

## Posicionando as camadas de paralaxe

Em termos de estrutura da árvore de nodes não tem mistério, adicionamos um node `Parallax2D` com um filho `Sprite2D` para cada camada. É importante lembrar que os últimos nodes são os que vão aparecer mais à frente.

Na hora de posicionar os nodes, basta posicionar o `Sprite2D`, e deixe `Parallax2D` na origem. Note que ambos se encaixaram perfeitamente na viewport. Ainda não colocamos a terceira camada.

<p align="center">
  <img width="1000" src="https://github.com/user-attachments/assets/b6fe02f5-a61b-49f1-8a0c-4a97f34e60e2" />
</p>

## Paralaxe sem movimento de câmera

Vamos começar com o mais simples, que é fazer o background se mover sozinho em loop sem câmera na cena. Isso por si só já dá o efeito de movimento e possui diversas aplicações. 

Omitimos a segundo camada para focar apenas na primeira por enquanto. Como a figura desta camada já está com o formato adequado, basta configurar os parâmetros *Repeat Size* para $1302$ pixels e *Autoscroll.x* para qualquer velocidade que quiser, em pixels/segundo. A velocidade é o mais simples, é a velocidade com que a figura vai se mover em cada eixo. O *Repeat Size* seria algo como a "tela" da paralaxe. Ou seja, depois de $1302$ pixels vai aparecer a mesma figura novamente, dando a ilusão de uma repetição infinita. Por isso que é tão importante a atenção ao tamanho das figuras. 

<p align="center">
  <img width="1000" src="https://github.com/user-attachments/assets/d17c7357-7dfc-4c41-bad2-2e34b7221260" />
</p>

Abaixo, mostramos duas imagens, a primeira usando um *Repeat Size* menor que $1302$ e depois um *Repeat Size* maior. A tela do editor dá uma preview de como virá a próxima figura da repetição.

<p align="center">
  <img width="1000" src="https://github.com/user-attachments/assets/6934f917-d647-4f1e-82db-2a1cdbbefb3a" />
  <img width="1000" src="https://github.com/user-attachments/assets/6fc91352-23d1-4d0b-a17f-5883bf250922" />
</p>

### Arrumando paralaxe para figura com o tamanho correto mas espaço extra sobrando

Para a figura acima, qualquer desvio do tamanho original ficará errado. Porém, o que é um erro aqui é um ajuste para o caso das bolas. Lembre que elas tem um espaço a mais sobrando. Podemos resolver isso antecipando a repetição. Essa repetição vai ficar por cima do espaço extra que queremos esconder. A escolha do quanto o *Repeat Size* deve ficar abaixo de $1302$ acaba sendo no olho, mas podemos usar a ferramenta da regra para ganhar mais precisão no ajuste.

<p align="center">
  <img width="1000" src="https://github.com/user-attachments/assets/eda844eb-a062-4de3-a19c-80be5abe286f" />
</p>

Note que a velocidade desta camada é mais baixa que a anterior. Como ela está mais atrás, ela deve se mover mais lentamente para dar o efeito de paralaxe. E é isso! Agora você já pode rodar a cena e ver o efeito paralaxe em ação!

https://github.com/user-attachments/assets/ad941bc4-4858-4e5c-93a0-400abb6bfd6c

### Arrumando paralaxe para figura com o espaçamento correto mas figura menor que o viewport

Agora vamos para a terceira camada. Apesar dela ser um quadriculado onde o fim se encaixa com o início corretamente, ela é menor que o viewport. 

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/d941642f-3c76-4330-bf18-2d47822086c0" />
</p>

Há pelo menos duas maneiras de se resolver isso no editor:

- Aumentar a escala do sprite
- Diminuir o *Repeat Size* que nem fizemos anteriormente
