# Scene Unique Nodes

Acessar nodes pelo caminho pode ser um método frágil às vezes. Se você precisar mover um node na árvore e vários do código referenciavam o caminho até este node, você terá que reescrever o caminho em todos eles. A solução para isso é o *unique node* (ou *unique name*). Cahamremos ele de *node único*.

## Criando nodes únicos pelo editor

Para fazer um node ser único, basta dar o segundo clique do mouse nele e habilitar a opção *Access as Unique Name*.

<p align="center">
  <img width="330" src="https://github.com/user-attachments/assets/6ca13b2f-04a5-4cfc-a2fc-b56af49f80f1" />
</p>

Ao fazer isso, vai aparecer um símbolo de percentual (%) junto aos ícones do node na árvore da cena. Isso indica que agora ele de fato é um *node único*.

<p align="center">
  <img width="230" src="https://github.com/user-attachments/assets/95887127-2ee7-4304-b854-851575382aba" />
</p>

Outra maneira de fazer o node ser único é simplesmente renomear o nomde dele colocando o símbolo de percentual (%) na frente do nome. O editor automaticamente vai convertê-lo para um node único.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/6e8392ed-2086-4fb1-b49d-efbc5b11a33d" />
</p>
