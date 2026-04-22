# Using Containers

`Container` é outra classe que é filha da `Control`. Ela não é usada diretamente, geralmente se usa um dos seus filhos, cada um com um propósito. Sem saber, nós já usamos diversas vezes o node `SubViewportContainer`, que é um container específico para o node `SubViewport`.

<pa glin="center">
  <img width="900" src="https://github.com/user-attachments/assets/439a24bd-6312-4909-a0f3-3431bb9ad9fc" />
</p>

No [tutorial passado](https://github.com/felipebottega/Games/tree/gh-pages/Manual/User%20interface%20-%20UI/UI%20building%20blocks/Size%20and%20anchors), o conhecimento de âncora e as propriedades relacionadas foram úteis para criar nodes control de maneira mais controlada e organizada. Porém, este conhecimento não ajuda quando se tem um conjunto de nodes control. Por exemplo, se um jogo precisar de uma grid de botões, você terá que posicionar cada um por vez. Os nodes de container existem justamente para esse tipo de problema.

Vamos discutir um pouco dos containers mais usuais e suas propriedades. A partir desse pequeno conjunto de containers será possível se aventurar nos outros com pouca dificuldade.

> PS: É comum chamar de "node control" qualquer node filho da classe `Control`. Esse termo será adotado nos tutoriais daqui para frente.

## HBoxContainer

A imagem abaixo sozinha já deve deixar bem claro como esse container funciona. Conforme mais nodes control forem sendo adicionados ao `HBoxContainer`, o container vai posicionado-os horizontalmente.

<p align="center">
  <img width="470" src="https://github.com/user-attachments/assets/6e017d1e-0602-4e4d-9aed-87e2f0095821" />
  <img width="530" src="https://github.com/user-attachments/assets/1973b4d2-b768-4959-9bbd-96cdaa44cf09" />
</p>

Conforme a delimitação do `HBoxContainer` é alterada, o modo como cada node filho se ajusta depende de algumas propriedades. Vamos usar a `OptionButton` de exemplo para explicar.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/fa8f4de0-7e3b-4577-8daf-aaa6f1afb611" />
</p>

Vá em *Inspector → Control → Container Sizing*. O default mostrado abaixo é o mesmo para todos os nodes control.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/43435071-f699-4cbf-9c20-a407e212db44" />
</p>

- **Horizontal:** Esta propriedade diz como o node control deve preencher e se posicionar horizontalmente quando o container é alterado. Para a propriedade fazer efeito, é necessário que a propriedade *Expand*, logo abaixo, esteja habilitada.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/6a1484dc-7091-44ca-b704-765d7b9eed40" />
</p>

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/31b2fcfb-b966-4ff7-9a9b-171f39e52a84" />
</p>

- **Vertical:** Análogo ao anterior, mas para a vertical.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/c493062b-2bf1-4e0d-baba-17f93fa5a37e" />
</p>

- **Stretch Ratio:** Essa propriedade apenas funciona quando o node e um vizinho dele a estão alterando. Ela determina o quando de espaço em relação ao node vizinho este node pode ocupar. Por exemplo, se este node tiver *Stretch Ratio* igual a $2$ e o do vizinho for $1$, então este node pode ocupar 2x mais espaço que o vizinho, o que inclui utilizar o espaço que originalmente era do vizinho (por default a distribuição de espaço é igualitária). Abaixo temos um exemplo onde o espaço do `Button` ficou muito maior que o do `OptionButton` por conta desta propriedade. 

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/2b98c9a6-41a4-40ff-a27b-7624f990fef2" />
</p>

Todas as propriedades mostradas acima podem ser alteradas em conjunto. Recomendo testar para ver.

## VBoxContainer

Este container é a versão vertical do `HBoxContainer`.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/33826fb2-daf6-463f-8fd1-40aeb9aba9d4" />
</p>

As propriedades *Horizontal, Vertical, Expand* e *Stretch Ratio* continuam valendo, só que para a vertical. É importante chamar a atenção para a propriedade *Expand*, pois agora ela se encontrada vinculada à *Vertical*. Esta propriedade altera seu efeito dependendo do container em questão.

## Grid Container

Este container posiciona os nodes filhos em formato de grid, preenche linha por linha. Quando uma linha é preenchida, ele continua posicionando os nodes na linha seguinte. No exemplo abaixo, temos uma grid $2 \times 2$ composta por 3 nodes control filhos.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/7e78dc33-6c08-422a-a385-b4c44fc73023" />
</p>

O número de colunas é determinado pela propriedade *Columns*, no *Inspector*.

<p align="center">
  <img width="380" src="https://github.com/user-attachments/assets/ac3f8b8e-0482-457f-9fea-205c3da8f39d" />
</p>

As propriedades *Horizontal, Vertical, Expand* e *Stretch Ratio* continuam valendo, inclusive com o *Expand* nas duas direções. 

<p align="center">
  <img width="310" src="https://github.com/user-attachments/assets/ba43343c-e3a1-470f-a11f-2b773ef23780" />
  <img width="360" src="https://github.com/user-attachments/assets/1c2fce25-1777-4328-a0b0-59c3645d76c4" />
</p>
