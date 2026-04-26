# Using the theme editor

O tutorial anterior foi para aprender os conceitos básicos de tema/skin em GUI. Agora iremos ver como funciona a parte prática.

## Criando um tema

Existem duas maneiras de começar a criar um tema: pelo *FileSystem* ou pelo *Inspector*. No fim das contas teremos a mesma coisa, um arquivo de recurso. A diferença é que na primeira maneira o tema é criado de maneira independente, enquanto que na segunda ele é criado já vinculado a um node control.

Para criar pelo *FileSystem*, vá no *FileSystem*, dê o clique direito do mouse, selecione *New Resource* e depois selecione *Theme*. Dê um nome para o arquivo e mande salvar. Logo após isso o painel de edição de tema já deve abrir no editor. É neste painel que toda a edição do tema acontece.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/3f8681cb-6844-40aa-93a3-99844ad33921" />
  <img width="570" src="https://github.com/user-attachments/assets/2a692f6c-386a-424c-9bb5-b3ee31cd9396" />
  <img width="900" src="https://github.com/user-attachments/assets/38da5c84-3d07-4227-86d3-e85a3f07c3f3" />
</p>

Para criar pelo *Inspector*, você deve selecionar algum node control e ir em *Inspector → Control → Theme → Theme* e clicar onde está *empty*. Aí selecione a opção *Theme* e depois clique nela novamente para abrir o painel de edição. 

<p align="center">
  <img width="280" src="https://github.com/user-attachments/assets/701d1572-76f2-4e40-9ff2-ac34ef86e591" />
  <img width="260" src="https://github.com/user-attachments/assets/61fe28a5-797b-43d2-ab97-1345b53caa56" />
  <img width="1100" src="https://github.com/user-attachments/assets/8dcf74bd-5f32-4efa-bd5a-65aee1f0ac86" />
</p>

> PS: As opções *Default Base Scale, Default Font, Default Font Size* não precisam ser alteradas e não são tão relevantes. A primeira é um controle geral de escala dos objetos do tema, enquanto que as duas seguintes são propriedades de fallback (reserva) usadas apenas quando as principais falham (e caso essas também falhem, ainda tem o default da Godot que nunca falha).

## Overview do editor de tema

Este painel que se abrir é o *editor de tema*. Há bastante coisa para ser vista nele. A figura abaixo nos dá um resumo geral de cada uma das suas funcionalidades.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/bc80cb88-8032-494e-bd7e-f9affa43e85d" />
</p>

 1. Nome do arquivo. A engine sempre inicializa com esse nome dummy que está na figura.
 2. O *Manage Items* é usado para customização mais específica, não pretendo usar.
 3. Salvar o arquivo atual.
 4. Criar e salvar.
 5. O *Default Preview* se refere ao retângulo vermelho inteiro logo abaixo. Este retângulo contém diversos nodes control interativos para que você possa testar o resultado das customizações enquanto edita.
 6. Na verdade o *Default Preview* é apenas a preview que já vem por default no editor, mas você pode criar outras. Ao clicar nesse *+*, vai abrir uma janela para seleção de cenas. Qualquer cena com outro node control pode ser aberta para ter uma preview dos resultados enquanto edita.
 7. O campo *Type* se refere ao [tipo de tema](https://github.com/felipebottega/Games/tree/gh-pages/Manual/User%20interface%20-%20UI/GUI%20skinning%20and%20themes/Introduction%20to%20GUI%20skinning#tipos-de-tema) escolhido para customizar. Diferentes propriedades aparecem para cada escolha de tipo de tema. VocÊ deve clicar no *+* ao lado para escolher um tipo de tema.

Faltou mencionar alguns outros campos deste painel de edição. É melhor fazer eles em separado dos anteriores pois há mais detalhes para se considerar agora. Pode-se considerar que as funcionalidades acima são as básicas do painel, enquanto que as de agora são avançadas.

<p align="center">
  <img width="390" src="https://github.com/user-attachments/assets/dbdf799f-5e67-44d7-9285-5df206ae24b5" />
</p>

 1. Se o *Show Default* estiver habilitado, mostra todas as propriedades daquele tipo de tema, incluindo as que não foram editadas e estão no valor default. Se não estiver habilitada, mostra apenas as propriedades que foram editadas.
 2. Quando você está criado um tema, apenas as propriedades editadas vão aparecer no *Inspector* e no arquivo de recurso. As propriedades não editadas usarão os valores default da Godot, mas não vão aparecer nem no *Inspector* e nem no arquivo. A opção *Override All* faz com que todas as propriedades aparecem no *Inspector* e sejam salvas no arquivo. Na primeira figura abaixo, apenas a propriedade *font_color* foi editada. Já na segunda imagem, a opção *Override All* foi habilitada e todas as propriedades foram exportadas.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/59f2d351-b956-4f47-8f5f-5300e91d817e" />
  <img width="500" src="https://github.com/user-attachments/assets/8c6a6d01-6524-44ea-a45a-711d20953d8d" />
</p>

 3,4,5,6,7,8. Cada uma destas abas é um dos [itens de tema](https://github.com/felipebottega/Games/tree/gh-pages/Manual/User%20interface%20-%20UI/GUI%20skinning%20and%20themes/Introduction%20to%20GUI%20skinning#itens-de-tema) discutidos no tutorial anterior. O que cada um contém vai depender do tipo de tema escolhido. Lembrando que cada tipo de tema está associado a um node control. Recomendo testar para aprender melhor. Apenas iremos discutir aqui o item 8, pois é o menos evidente de como funciona. Abaixo segue a relação entre ícones e seus nomes.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/4b87a430-d927-49c4-8081-6c8088d2c7dd" />
</p>

 9. Este item não é importante e será ignorado.

## Styles

Criamos uma cena com um botão e inicializamos um tema para ser customizado neste botão. 

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/3054df57-bb1b-440d-9041-0ce923cc1ff1" />
</p>

Para inserir a cena no editor de temas, vá no *+* ao lado de *Default Preview* e selecione a cena desejada. Após isso ela deve aparecer no editor. É necessario que o node raíz da cena seja um node control.

<p align="center">
  <img width="950" src="https://github.com/user-attachments/assets/f0fa2a32-f043-4fcc-be5b-d4cfb3761d27" />
</p>

Feito isso, vá no *+* ao lado de *Type*, para escolher o tipo de tema, e selecione `Button`. Depois clique no ícone de *Styles* e finalmente podemos começar a customizar o estilo do botão.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/f1d40763-02b7-48fc-83db-c020faec0042" />
</p>

Vamos customizar o botão no estado normal (idle). Para isso, clique no *+* ao lado do campo *normal*. Note que o respectivo campo aparecerá no *Inspector*. Para começar a customização, clique onde está escrito *empty*, ao lado do campo *normal*. Isso vai abrir algumas opções para selecionar. Vamos falar um pouco de cada uma.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/ea0b4ad9-5292-4133-9ec0-b0c24e43f1f3" />
</p>

### StyleBoxEmpty

Ao selecionar esta opção, toda a estilização default do node desaparece. Ele possui o mínimo possível para existir. Você pode clicar novamente no *StyleBoxEmpty* para abrir as propriedades dele no *Inspector*. Vai notar que ele possui apenas propriedades de margem, que sempre estão disponíveis para todos os estilos. Geralmente se usa essa opção de estilo quando toda a estilização que você precisa já veio de outros itens de tema, como cores, fontes, etc. 

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/84c45a68-a97a-4ede-8729-d197d18040a2" />
</p>

### StyleBoxTexture

Esse possui mais opções que o anterior. Ele foi feito para receber um textura como background do node control. 

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/47a7a9b4-9e57-48b5-a9c6-04df5f7eaa6f" />
</p>

Uma vez que a textura foi selecionada, é possível aplicar alguns efeitos, como deformações, alterações nas margens, na cor, repetições como tiles, entre outros. O número de efeitos é limitado, pois a ideia é que a textura já venha praticamente pronta para servir de background. Se quiser alterações mais sofisticadas, é aconselhável trabalhar a textura por fora, em outro programa. 

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/7634efbb-cfa9-46d3-9fd6-9308950c695a" />
  <img width="300" src="https://github.com/user-attachments/assets/42820fe5-20fd-4050-8125-fcccc451fd9f" />
</p>

### StyleBoxFlat

Esse é o estilo mais usado no default da Godot. A quantidade de efeitos também é limitada, assim como o anterior, mas com alguma criatividade é possível conseguir efeitos interessantes.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/a5354420-fa1c-48eb-917c-884bcbf2402e" />
</p>

Abaixo segue um exemplo do que é possível conseguir com algumas customizações.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/ca825f6e-7fa1-4785-b8e7-d9a1415c1578" />
  <img width="300" src="https://github.com/user-attachments/assets/1e9fcc37-7021-4eeb-a957-d0ed09966de8" />
  <img width="300" src="https://github.com/user-attachments/assets/cc02bd5d-7381-4727-a0e7-d7bf3db9eb5f" />
</p>

### StyleBoxLine

Esse estilo é bem simples, é apenas uma linha horizontal ou vertical acompanhando o node control. É útil para layouts minimalistas.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/23d1756e-591c-4103-a431-1ae21e5a7c9a" />
</p>

Abaixo segue um exemplo de aplicação.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/1dc5d572-dc46-4a24-ae88-4417b7b396aa" />
  <img width="300" src="https://github.com/user-attachments/assets/a11dcd2f-523a-4dc1-b6fd-6cfd26eaad1b" />
</p>

### Pin do estilo

Quando você seleciona um stylebox em específico, aparecem alguns ícones ao lado dele no páinel de edição. Vou explicar apenas o destacado em vermelho abaixo, acredito que os outros são de fácil entendimento a essa altura.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/179232e4-3fce-433d-adf4-ea49736858fe" />
</p>

Esse é o ícone de *pin*. Quando você clica nele, o stylebox foi "pinado" ou "fixado", usando a tradução para o português. Isso significa que qualquer stylebox novo do mesmo tipo irá copiar as alterações feitas no fixado. Por exemplo, na imagem abaixo o *StyleBoxLine* associado ao campo *normal* foi fixado. Isso significa que qualquer alteração feita nesse estilo será copiada também no stylebox do campo *hover*, pois ele é do mesmo tipo de stylebox.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/28d62bf3-d56e-4814-90f6-5f65d194e108" />
</p>

Fixar stylebox desta maneira é útil quando você tem um conjunto de GUIs do mesmo tipo que requerem as mesmas edições. Isso garante que as edições são feitas em paralelo.

> PS: Só é possível ter um stylebox fixado por vez.

## Exemplos

### Botão 1

Criamos um cena contendo um único botão e criamos um tema para editar. Este tema é do tipo `Button`. Criamos stylebox para os campos *focus, hover, pressed* e *normal*, e fixamos o stylebox do *normal*. A ideia é começar customizando todos estes de maneira idêntica, mas depois criar as diferenças de cada um individualmente. 

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/d1ba5d54-8f61-4a3a-acc2-c6dc67674da2" />
</p>

> PS: Também seria possível criar as diferenças de cada um pelo *Theme Overrides*, mas isso não ficaria salvo no arquivo de recurso. Não existe certo e errado nesse caso. Depende se vale a pena ou não salvar essas diferenças em arquivo de recurso.

Abaixo seguem as customizações utilizadas para este botão. Apenas o *hover* e *pressed* tiveram algumas alterações em relação ao *normal* (que pode ser vista como o estilo base). O *focus* ficou igual neste caso.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/be1a2333-69c0-4943-9647-57dbb6d283a5" />
</p>

### Botão 2

O anterior foi feito com *StyleBoxFlat*, mas esse de agora será feito com *StyleBoxTexture*. Procedemos de maneira análoga ao anterior, até a parte de fixar o stylebox normal. Abaixo segue a customizção dele. A textura é o arquivo *BTN_BLUE_CIRCLE_OUT.png*, obtida [aqui](https://opengameart.org/content/free-ui-asset-pack-1).

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/db761dff-8c23-4b52-b05d-bae3e782d237" />
</p>

Só o que alteramos depois foi a textura do *pressed*, que usou a textura do mesmo botão, mas pressionado para baixo. Com isso nós obtemos uma animação de apertar botão através da estilização.

### Botão 3

Esse botão recebeu o estilo *StyleBoxEmpty*, que basicamente deixou ele sem estilo nenhum. Foi feita uma manipulação da cor e tamanho da margem para poder perceber o *hover* e o *pressed*, mas são efeitos sutis.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/5b0d632b-5aea-4857-91f7-d7f82fa6ff32" />
</p>

O interessante deste botão é que ele possui um efeito de shader de background. Para isso utilizamos a estrutura de cena abaixo. Não é possível visualizar o botão desta cena no painel de edição de temas. Caso prefira, primeiro edite o botão e depois acrescente o `ColorRect`.

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/98e771cc-474e-4e5a-8ee3-98b6e2e73ec4" />
</p>

Depois disso, os três botões foram colocados em uma cena principal. Este pequeno projeto de testes pode ser acessado [neste link]().

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/402ab617-1407-49b4-84c8-84f0d56cc8ca" />
</p>
