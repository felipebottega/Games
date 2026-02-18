# ShapeCast2D

O node `ShapeCast2D` é muito parecido com o `RayCast2D` visto [anteriormente](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Ray-casting), com a diferança que o `ShapeCast2D` emite uma shape em vez de uma linha para detectar colisões. 

## Criando um ShapeCast2D

O processo de criação também é parecido. Adicione o node `ShapeCast2D` à sua cena e, no *Inspector*, selecione a shape que você quer. A maior parte das propriedades são as mesmas do `RayCast2D`, e as diferentes não são muito complicadas de entender.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/5a69cd45-9c35-4e8a-b433-60fdcb71ed5d" />
  <img width="250" src="https://github.com/user-attachments/assets/9f5e1ece-7bac-4780-a102-28db02a26789" />
</p>

Depois de selecionar uma shape, você pode clicar no nome da shape selecionada novamente para abrir mais opções de customização da shape.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/614d32a1-b669-4a01-b45b-f8a235b61cd9" />
  <img width="300" src="https://github.com/user-attachments/assets/0710ffa7-9e0f-449e-bfd5-ba8cd1044470" />
</p>

Você tem um ponto inicial e final, assim como no `RayCast2D`, mas a engine projeta uma sequência de shapes em vez de projetar uma linha. 

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/b6b00d2a-dcde-43f4-961b-2840a799b9f2" />
</p>

## Múltiplas detecções

Diferentemente do `RayCast2D`, é possível obter múltiplas detecções de colisão ao mesmo tempo. Para isso acontecer, é necessário que os corpos detectados estejam dentro da mesma shape no instante da colisão, como indicado na figura abaixo. A lógica de detectar colisões é igual ao `RayCast2D`, isto é, assim que uma detecção ocorre, o `ShapeCast2D` não tenta mais buscar colisões naquele frame físico. Por isso que múltiplas colisões só são possíveis se os corpos estiverem dentro da mesma shape usada para detecção no mesmo instante.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/cd8483d3-5366-4bae-809f-9e2b56f9c80f" />
</p>

Mostramos abaixo como funciona o `ShapeCast2D` no editor.

https://github.com/user-attachments/assets/c9ee271e-20ed-44c8-8aaa-f569f1ca257b
