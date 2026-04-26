# Introduction to GUI skinning

Todo o processo de trabalhar a skin da UI em Godot é através de [`Themes`](https://docs.godotengine.org/en/stable/classes/class_theme.html#class-theme), que é um tipo de recurso da engine. Geralmente não será necessário trabalhar com a classe diretamente pois há muitas funcionalidades no editor para facilitar a criação de temas/skins.

## Itens de tema

Já tiveram momentos, em tutoriais passados, em que foi necessário acessar o campo *Theme Overrides* no *Inspector*. O maior uso foi para alterar o tipo e tamanho de fonte, o que foi feito através dos campos *Fonts* e *Font Sizes*, respectivamente. Além destes dois campos, há outros para serem alterados. Cada um deles é um "item de tema".

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/c003cbcb-8b84-41b5-8395-4a4e26e4aa9d" />
</p>

Ao abrir o campo de cada item de tema, podemos ter uma ou diversas propriedades para alterar, depende do node control em questão. Não vamos listar as propriedades que existem para cada node, mas apenas dar uma descrição geral de cada item de cena.

- **Colors:** Um valor de cor, frequentemente usado para fontes e planos de fundo. As cores também podem ser usadas para modular controles e ícones.
- **Constants:** Um valor inteiro, que pode ser usado para propriedades numéricas de nodes control.
- **Fonts:** Um recurso de fonte, usado por controles que exibem texto. As fontes contêm a maioria das configurações de renderização de texto, exceto tamanho e cor. Além disso, o alinhamento e a direção do texto são controlados por controles individuais.
- **Font Size:** Um valor inteiro, usado juntamente com uma fonte para determinar o tamanho em que o texto deve ser exibido.
- **Icons:** Um recurso de textura, normalmente usado para exibir um ícone.
- **Styles:** Uma coleção de opções de configuração que definem a forma como um painel da interface do usuário deve ser exibido. Em termos simples, você estiliza a "caixa" contendo o node.

Apenas para se ter um exemplo concreto, abaixo temos todas as propriedades explicitadas dos itens de tema de um node `Button`.

<p align="center">
  <img width="370" src="https://github.com/user-attachments/assets/9b730a5b-52cb-4775-a9fb-b717028355a6" />
  <img width="370" src="https://github.com/user-attachments/assets/89dbf131-f12a-459c-b020-72b3a43a2449" />
</p>

## Tipos de tema

Como dito acima, cada node possui um conjunto diferente de propriedades em cada item de tema. Dizemos que cada node control está associado a um "tipo de tema" ("theme type" em inglês), que basicamente é esta conjunto de propriedades que cada um possui. Vale ressaltar que os itens de tema são sempre os mesmos para todos os nodes control (ou todos os tipos de tema), mudando apenas as propriedades que cada item de tema possui.

## Theme vs Theme Overrides

Como já foi mencionado, até agora apenas o *Theme Overrides* foi utilizado para alterar alguma propriedade de UI de nodes control. O *Theme Overrides* geralmente é utilizado apenas quando a UI é única e não será reutilizada ou é utilizado para alterar/sobrescrever alguma coisa específica de um tema carregado. O mais comum mesmo é carregar um tema através do campo *Theme*. Cada tema é um recurso, ele fica armazenado em um arquivo *.tres*. A vantagem disso em relação ao *Theme Overrides* é que você consegue uniformidade de estilo mais facilmente no jogo, não precisa ficar editando cada item da UI individualmente. Não apenas isso, mas o *.tres* pode ser até utilizado em outros projetos. 

## Customizando o projeto

Existem duas configurações de projeto que podem ser ajustadas para afetar todo o projeto. Indo em *Project → Project Settings → General → GUI → Theme → Custom* permite definir um tema personalizado para todo o projeto. Indo em  *Project → Project Settings → General → GUI → Theme → Custom Font* faz o mesmo com a fonte padrão de fallback. Quando um item de tema é solicitado por um node control, o tema personalizado do projeto, se presente, é verificado primeiro. Somente se o item não estiver presente, o tema padrão é verificado. Isso permite configurar a aparência padrão de cada node control da Godot com um único recurso de tema.

Apesar de conveniente, eu recomendo não utilizar isso pois é um método muito implícito. Não há como descobrir de onde veio o tema inspecionando as cenas e nodes. Qualquer pessoa que for debugar o projeto precisa saber que essa possibilidade existe e deve saber exatamente onde ela é configurada, caso contrário, vai parecer que o tema foi aplicado de maneira mágica.
