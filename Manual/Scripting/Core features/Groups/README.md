# Groups

Na Godot, grupos funcionam como tags. Você pode adicionar um node a quantos grupos quiser. Em seguida, no código, você pode fazer coisas como:
- Obter uma lista de nodes em um grupo.
- Chamar um método em todos os nodes de um grupo.
- Enviar uma notificação para todos os nodes de um grupo.

⚠️ **Atenção:** Esta série de tutoriais começou na Godot 4.4 e agora já está na 4.6. O painel à direta foi ligeiramente alterado. Anteriormente, para acessar os grupos, deveríamos ir na aba *Node* e depois *Groups*. Agora a aba *Groups* já está disponível diretamente.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/c6696d94-ab46-4abf-af1d-2231ccde8f5f" />
</p>

## Adicionando nodes a um grupo pelo editor

Para criar um grupo novo, primeiro você deve escolher um node que fará parte dele (na Godot não existem grupos vazios). Feito isso, vá para *Inspector → Groups*, clique no sinal de "+" e dê um nome para o grupo. Ao lado do campo de nome, você deve escolher se habilita o grupo como "Global" ou não. Se for global, o nome deste grupo será reconhecido pelo projeto inteiro. Caso contrário, ele estará restrito à cena onde foi criado.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/85e2db88-326f-4424-ac0e-e6407901ff3e" />
</p>

Criamos um pequeno exemplo de uma cena principal contendo duas cenas instanciadas. 

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/01d565ac-bfc9-4fd5-9f88-3d6a648ef634" />
</p>

O node do sprite azul pertence ao grupo "BlueGroup", que é do tipo *Scene Group*. Enquanto que o sprite vermelho pertence ao "RedGroup", que é do tipo *Global Group*. Perceba que, na cena do sprite azul, o grupo "RedGroup" é reconhecido, mas o contrário não acontece. 

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/d57d45dd-cd2e-4d0a-8c0a-f8cd2d4f789a" />
  <img width="335" src="https://github.com/user-attachments/assets/3ba0dfa9-bb3b-470a-bdcc-721ad3398ebc" />
</p>

Ao instanciar estas cenas na cena principal, eles herdam as configurações de grupo também. Porém, note que não é possível mais editar isso pelo *Inspector*.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/58aaea2f-8a6b-49c4-9c50-aeb4f818eb68" />
  <img width="1100" src="https://github.com/user-attachments/assets/3a7c62ca-d6ac-4303-90a3-f78148ad76c4" />
  <img width="1100" src="https://github.com/user-attachments/assets/dce6491f-b090-41f3-a076-3cff8e380c30" />
</p>

> PS: Apesar do "BlueGroup" ser um *Scene Group*, a existência dele foi reconhecida em outra cena quando ele foi instanciado nesta. A maior diferença entre este tipo de grupo e o global é justamente o fato do *Scene Group* precisar ter um node do grupo instanciado na cena para a cena reconhecer o grupo, enquanto que o global é reconhecido mesmo que nenhum node do grupo exista na cena.

Se tiver outro node na cena, você pode incluí-lo em qualquer um dos grupos existentes. Basta ir na aba dos grupos e selecionar os grupos nos quais você deseja incluí-lo.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/c3842344-1f03-4694-a66b-87878e584b51" />
</p>

Quando um grupo é global, não é mais possível utilizar aquele nome para criar nenhum tipo de grupo. Por outro lado, se for um grupo de cena, você pode reutilizar o nome para criar outro grupo de mesmo nome em outra cena. Aqui é importante ter cuidado pois se você reutilizar o nome e criar um grupo global, o grupo de cena anterior que estava usando esse nome passará a ser global e será incluído automaticamente nesse que você acabou de criar. O recomendado é que não se repita nomes de grupos, mesmo que sejam todos grupos de cena. 

## Adicionando nodes a um grupo por código

Criamos uma nova cena, com o sprite rosa desta vez. Em vez de adicioná-lo a um grupo pelo editor, isso foi feito por código, como mostrado abaixo. Isso significa que, assim que o node associado ao script entra na cena, ele é adicionado ao grupo "PinkGroup".

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/6b120c3f-0f71-4583-a4ad-d233e3606492" />
</p>

A função `add_to_group` não cria grupo global nem grupo de cena no sentido do editor. Ele simplesmente adiciona o nde a um grupo com aquele nome. Se o grupo não existir ainda, ele é criado automaticamente em runtime. Se já existir um grupo global com esse nome, ele usa o mesmo nome normalmente, não há conflito (grupos não têm "namespace").

Abaixo temos uma aplicação deste método. Nenhum node pertencente ao grupo "PinkGroup" estava na cena inicialmente, mas foi adicionado por código. Depois disso o programa checou cada node da árvore para ver a quais grupos cada um pertencia.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/abbb17f6-7dda-449b-8697-78d0465d4094" />
</p>

## Métodos

Existem métodos de grupos da classe `Node` e da `SceneTree`. O método `add_to_group`, por exemplo, é da classe `Node`. Estes métodos você usa no script do próprio node, são métodos que dizem respeito ao node.

- **add_to_group(group_name):** Adiciona o node ao grupo `group_name`. Caso não exista, é criado na hora.
- **remove_from_group(group_name):** Remove o node do grupo `group_name`. Não faz nada se o node não pertencer ao grupo.
- **get_groups():** Retorna um array com os nomes dos grupos aos quais o node foi adicionado. Este método também pode retornar alguns nomes de grupos que começam com um underscore. Estes são usados ​​internamente pela engine. Para evitar conflitos, não use grupos com nomes começando com underscore.
- **is_in_group(group_name):** Retorna *true* se este node tiver sido adicionado ao grupo `group_name`.

Os métodos de grupo da classe `SceneTree` dizem respeito à árvore da cena. Se algum dos métodos retorna nodes ou depende de nodes de alguma maneira, estes nodes devem estar na árvore da cena que chamou o método.

- **get_tree().call_group(group_name, method_name, ...):** Chama o método `method_name` em cada node pertencente ao grupo `group_name`. Você pode passar argumentos para o método especificando-os ao final da chamada. Nodes que não podem chamar o método (seja porque o método não existe ou porque os argumentos não correspondem) são ignorados.
- **get_tree().get_nodes_in_group(group_name):** Retorna um array contendo todos os nodes pertencentes ao grupo `group_name`, na ordem da hierarquia da cena.
- **get_tree().get_node_count_in_group(group_name):** Retorna o número de nodes pertencentes ao grupo `group_name`. É equivalente ao comando `get_tree().get_nodes_in_group(group_name).size()`, mas esse último é menos eficiente pois cria uma array e depois faz a contagem.
- **get_tree().has_group(group_name):** Retorna *true* se existe pelo menos um node pertencente ao grupo `group_name` na árvore.
- **get_tree().notify_group(group_name, notification):** Envia uma notificação para todos os nodes que estão no grupo `group_name`. A notificação `notification` deve ser um inteiro.
- **get_tree().set_group(group_name, property, value):** Altera o valor da propriedade `property` para `value` em todos os nodes pertencentes ao grupo `group_name`. Os nodes que não possuem a propriedade são ignorados.

## Aba de grupos globais no Project Settings

Em *Project → Project Settings → Globals → Groups* você consegue ver de uma vez todos os grupos globais do projeto. Ali, você poderá adicionar novos grupos globais ou alterar os nomes e descrições dos grupos existentes.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/4677d510-299d-4295-9b63-27bbef0f2cb6" />
</p>
