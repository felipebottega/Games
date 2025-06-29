# 2D lights and shadows

O principal node para a aplicação de luzes é o `PointLight2D`. Todos os outros nodes e técnicas são para melhorias extras.  Para apresentar este node, iremos recriar a cena do Castlevania vista no [Animation 1](https://github.com/felipebottega/Games/tree/gh-pages/Getting%20started/Your%20first%202D%20game/Coding%20the%20player/Animation%201).

Após copiar as pastas daquela cena para o projeto atual, precisamos ajustar as configurações do projeto, como mostrado abaixo. Para manter as coisas mais organizadas, scriamos também a pasta *scripts* para colocar os sripts lá.

<p align="center">
  <img src="https://github.com/user-attachments/assets/e81844e7-06d7-4b07-b4f5-2439c2b6c676" width="500">
  <img src="https://github.com/user-attachments/assets/99f751aa-0145-49ec-bc5b-d15b1e6b7801" width="500">
</p>

Além dos sprites anteriores, também incluímos um sprite para o fundo, outro de blocos flutuantes e uma pilastra. O fundo e a pilastra são `Sprite2D`, enquanto que o bloco é um `StaticBody2D`. Cada um tem a sua própria cena. No bloco, colocamos fricção igual a zero. Se a fricção fosse positiva, o boneco poderia "grudar" momentaneamente na lateral dela e pular dali, o que seria um bug indesejável.

<p align="center">
  <img src="https://github.com/user-attachments/assets/9ab87513-be51-4712-8543-f39b3f3a3b89" width="200">
</p>

Na cena principal, também colocamos barreiras laterais invisíveis para que o jogador não saia da tela. Faça essas paredes invisíveis como `StaticBody2D` sem textura e fricção igual a zero. Abaixo temos uma visão geral de como está o projeto até o momento.

## PointLight2D

Finalmente chegou o momento de colocar alguma iluminação na cena! Primeiro vamos criar a tocha com animação.

<p align="center">
  <img src="https://github.com/user-attachments/assets/d0d6efb5-0519-426f-b46b-2d060fdfbbdd" width="700">
</p>

Lembre-se de que a ordem dos nodes importa. Queremos os blocos flutuantes antes do boneco pois eles não cobrem o seu pé quando ele ele estpa em cima deles. Queremos o pilar vindo depois do boneco pois na cena ele passa por trás do pilar, dá um efeito bonito e a cena ganha mais tridimensionalidade. Marque a opção *Autoplay on Load* para que a animação seja executada assim que entra na cena. Feito isso, coloque-a na cena Main, acima dos blocos mais distantes. Na árvore de nods, coloque-a depois dos blocos e antes do Trevor.

<p align="center">
  <img src="https://github.com/user-attachments/assets/c905f6fa-3b7b-4ef5-a608-5dc69478f6f1" width="400">
</p>

Volta na cena da tocha e acrescente o node `PointLight2D` como filho. Apenas isso não basta para a luz surgir, você deve adicionar uma textura para ela, um sprite que irá ditar o formato da luz. Nesse caso nós utilizamos uma esfera em gradiente, que decai aos poucos. Você já pode voltar à cena Main e constatar que o efeito de luz já está funcionando.

<p align="center">
  <img src="https://github.com/user-attachments/assets/2010d08f-2fcd-4e0d-943c-824d69405541" width="200">
  <img src="https://github.com/user-attachments/assets/da102034-47e0-4efc-8e0f-0fb1e269c0b1" width="200">
</p>

## Propriedades do PointLight2D

Apesar da tocha de fato estar emitindo luz, provavelmente não está satisfatório. Agora chegamos na etapa de configurar os parâmetros deste node. A breve descrição abaixo deve ser suficiente para entender como funciona.

- **Texture Scale:** O tamanho do alcance da luz.
- **Color:** A cor da luz.
- **Energy**: A instensidade da luz.
- **Blend Mode:** Algoritmos da iluminação. O `Add`(default) é a iluminação o normal, os outros dois é testar e ver onde encaixa.

Mesmo que você diminua o alcance de intensidade da luz, ainda vai achar que a iluminação da tocha é irrelevante para cena. Isso não é culpa da iluminação. O que acontece é que geralmente os sprites são claros. Então você precisa escurecê-los um pouco para que o efeito de luz tenha algum impacto. Isso é possível com o comando `modulate = Color(x, y, z)` no script da Main. O `modulate` é um atributo nativo de todos os filhos do `Node2D` e serve para alterar a cor do sprite. Vimos ele [anteriormente](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Viewport%20and%20canvas%20transforms/Movements%203#sprites-de-sprites). Como ele será aplicado no node pai, o escurecimento será para a cena inteira, que é o que queremos mesmo.

<p align="center">
  <img src="https://github.com/user-attachments/assets/2528f479-3c10-40c9-9c84-54a2bb23a319" width="400">
  <img src="https://github.com/user-attachments/assets/cafed418-852d-477e-aa8a-a5365737a032" width="600">
</p>

  ## Configurando sombras

  O resultado obtido até aqui já é muito bom, é possível parar neste ponto e já ter um jogo com efeitos de luz e sombra bonitos. Mas dá para fazer melhor! Note que a luz da nossa cena é absoluta, ela ultrapassa qualquer objeto. Nehuma sombra ocorre por algum objeto estar no caminho da luz, a única sombra que tem é a da cena escurecida que está longe o suficiente da esfera de luz absoluta. 

  Para obter sombras de fato, usaremos o node `LightOccluder2D`. Vá para a cena dos blocos, selecione o sprite e clique no botão *Sprite2D* acima da tela 2D. Feito isso, selecione a opção *Create LightOccluder2D Sibling*.

<p align="center">
  <img src="https://github.com/user-attachments/assets/d09dc018-c0aa-4859-b1f0-e0b1f2a67a49" width="700">
</p>

A janela mostrada abaixo irá se abrir. O objetivo desta janela é criar um shape de sombra para o seu sprite. A região dentro deste shape estará na sombra e vai também bloquear a luz para tudo que vier depois. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/3b5a3b67-6bf4-4543-aca1-37bace72d2be" width="450">
</p>

Não se preocupe se você não conseguir configurar perfeito agora, depois é possível editar manualmente o shape que nem se faz com um `Path2D`.

<p align="center">
  <img src="https://github.com/user-attachments/assets/b00480cd-bbf6-4d02-b196-513e0926b9e5" width="600">
</p>

Depois de fazer isso, crie uma shape de sombra para o pilar também. O último (e mais importante) passo é você voltar ao `PointLight2D` e deixar o sombreamento habilitado, caso contrário nada disso terá efeito.

<p align="center">
  <img src="https://github.com/user-attachments/assets/fa64e81b-1963-49d9-b151-24d04d93dd5d" width="200">
</p>

Agora você tem uma cena com iluminação e sombras de verdade. Nada mal!

<p align="center">
  <img src="https://github.com/user-attachments/assets/01aa1319-55ca-4064-8158-a6e7fc9b4734" width="600">
</p>

## Propriedades da sombra

- **Color:** Cor das áreas sombreadas. O default é deixar preto.
- **Filter:** Tipo de renderização das sombras. As renderizações deixam ela mais suave. Caso você escolha alguma, vai aparecer o slider *Filter Smooth*, onde você configura o nível de suavidade da sombra.

Tanto para luz quanto para sombra há outras propriedades que não mencionei aqui. Esse é o "pacote básico" e com certeza vai servir para a maior parte das ocasiões. O restante você aprenderá com o tempo.
