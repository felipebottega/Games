# Resources

O conceito de "recurso" ("resource" em inglês) já foi abordado diversas vezes em tutoriais anteriores. Vou deixar abaixo a lista das vezes em que ele foi tratado anteriormente, para termos uma referência geral.

- **Onde entram os recursos na estrutura do projeto:** [Organização de um projeto](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Tools/Using%20TileMaps%20-%20Game#organiza%C3%A7%C3%A3o-de-um-projeto)
- **Recursos aplicados na linguagem do jogo:** [Assets associados a linguagens](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Internationalization/Internationalizing%20games#assets-associados-a-linguagens)
- **Recursos e RIDs:** [RIDs](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Performance/Common/Optimization%20using%20Servers#rids)
- **Recursos e @export:** [Resources](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20exported%20properties#resources)

*Recursos* em Godot são containers de dados. Eles não fazem nada por si só, em vez disso, os nodes usam os dados contidos nos recursos. Tudo o que a Godot salva ou carrega do disco é um recurso. Pode ser uma cena (um arquivo *.tscn* ou *.scn*), uma imagem, um script, etc.

Quando a engine carrega um recurso do disco, ele é carregado apenas uma vez. Se uma cópia desse recurso já estiver na memória, tentar carregá-lo novamente retornará a mesma cópia todas as vezes. Como os recursos contêm apenas dados, não há necessidade de duplicá-los.

Todo objeto em Godot, seja um node ou um recurso, pode exportar propriedades (usar o `@export`). Existem muitos tipos de propriedades, como String, inteiro, Vector2, etc., e qualquer um desses tipos pode se tornar um recurso. Isso significa que tanto nodes quanto recursos podem conter recursos como propriedades. A figura abaixo vem da [documentação oficial](https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html), ela mostra como nodes podem conter recursos e como recursos podem conter outros recursos.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/231f9a0f-ef29-473a-a7fa-0a625788e782" />
</p>

## Carregando recursos

Vamos pegar o exemplo do sprite na figura acima. Pelo que podemos ver, o node `Sprite2D` contém um recurso de textura. Ao criar um node `Sprite2D`, podemos ver que a propriedade *Texture* de fato existe no *Inspector*. Geralmente o que fazemos é escolher um arquivo de imagem e inserir neste campo vazio, tudo pelo próprio editor. Em outras palavras, estamos adicionando um recurso de textura ao node `Sprite2D`.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/9d7b3276-7ce8-4871-826f-2f327e12aeee" />
</p>

Também podemos adicionar recursos aos nodes através de código. Neste caso, o comando `var my_resource = load("res://my_texture.png")` e em seguida `$Sprite2D.texture = my_resource` (os nomes de variáveis e arquivos são fictícios) fazem o serviço. Na maioria dos exemplos, usamos o `load` ou `preload` para importar cenas, mas na verdade essas funções podem ser usadas para importar qualquer recurso.

## Local to Scene e Make Unique

Para explicar essas duas funcionalidades, vamos considerar o exemplo de uma cena onde temos um `StaticBody2D` chamado *Blocks*. A ideia é que isso será inserido em uma cena de jogo depois. O corpo possui um `Sprite2D` e um `CollisionShape2D` retangular, algo comum.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/a1bcbd4f-57db-4379-bec2-8a8060219bfb" />
</p>

Colocamos dois destes objetos na cena, como você pode ver na figura abaixo.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/c227b5bb-3f6e-48ce-bbf5-b2ce61c624da" />
</p>

Se você voltar para a cena *Blocks* e clicar no campo *Shape* do `CollisionShape2D` no *Inspector*, os campos abaixo vão aparecer. O fato de ter um campo *Resource* associado ao `CollisionShape2D` significa que este node possui um recurso, que é o shape de colisão retangular. Você pode até clicar no campo *Resources* para ver algumas propriedades associadas ao recurso.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/cbc33964-7ac3-4ae7-b6ae-07e8a2bcd603" />
</p>

Em geral, vamos evitar alterar o *Path*. A propriedade *Name* é puramente estética, não faz mal alterar mas também não importa muito. A propriedade *Local to Scene* é a única que nos importa de verdade. Como comentamos antes, a engine carrega um recurso uma única vez, não faz duplicatas. Isso significa que os dois *Blocks* instanciados na cena principal estão referenciando o mesmo recurso. Como consequência disso, alterar qualquer um altera todos os outros imediatamente, seja alterar algum instanciado ou alterar o original.

https://github.com/user-attachments/assets/dd43b99a-077a-4d52-8011-1240c90e7c7e

### Local to Scene

Se a opção *Local to Scene* não estiver habilitada, vimos acima como é o comportamento. O compartilhamento dos recursos é absoluto. Agora vamos supor que a opção está habilitada. Você vai notar uma diferença sutil de comportamento no editor: o recurso da cena instanciada não atualiza automaticamente quando o recurso é alterado pelo objeto original, mas assim que você salva a cena do original aí os recursos de todas as instâncias atualizam junto. A princípio, parece que o *Local to Scene* só adiou o inevitável. A diferença real é notada quando você habilita o [*Editable Children*](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Nodes%20and%20scene%20instances#editable-children-e-make-local) nas instâncias.

> PS: Apesar da instância com o *Editable Children* ter recurso independente, ela ainda é filha do objeto original e compartilha algumas propriedades com ele, como transformações, cores, visibilidade, entre outros. Tenha sempre atenção para não fazer confusão com isso.

Abaixo, temos a cena original do bloco à esquerda e os blocos A e B instanciados em outra cena. O original está com *Local to Scene* habilitado e apenas o bloco B está com o *Editable Children* habilitado. Ao alterar o shape de colisão do bloco original e salvar a cena, apenas o bloco A reage à mudança. No entanto, apesar do shape de colisão do bloco B não ter alterado de forma, ele alterou de posição. Isso foi porque o centro do shape de colisão do original mudou de posição, e essa propriedade o bloco B ainda depende do original (como já comentamos em outras ocasiões, para ter total independência tem que habilitar a opção *Make Local*).

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/db0bfd07-acc7-489b-9323-a80e53679f8c" />
</p>

> PS: Esse comportamento da instância copiar as propriedades do original apenas vale quando você não alterou a propriedade do objeto instanciado. Caso esta propriedade tenha sido alterada na instância, aparecerá o símbolo <img width="20" src="https://github.com/user-attachments/assets/1df980bb-e48e-4daf-b6aa-7eba4d4e2e8d" /> ao lado da propriedade
 no *Inspector*, e isso sinaliza que ela foi alterada. Neste caso, a propriedade não responde mais às alterações do original.

A opção *Local to Scene* brilha mesmo quando você cria instâncias por código. Nesse caso, é como se elas fossem *Editable Children* por default, então todas tem recursos independentes. Ocultamos os dois blocos A e B comentados acima e agoras criamos outros dois, por código, na Main. O bloco original ainda é o mesmo, com a opção *Local to Scene* habilitada. Apenas manipulamos a posição e escala dos blocos. Note que ambos os shapes de colisão se alteraram como pedimos. 

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/cf9fdb47-c333-4d7f-a8dc-5c19d226c350" />
</p>

Se tivéssemos executado este mesmo script sem *Local to Scene*, o primeiro comando `a.get_node("CollisionShape2D").shape.size = Vector2(64, 32)` de fato iria funcionar, alterando o shape para todos os blocos, pois o recurso está sendo compartilhado. Logo depois, o comando `b.get_node("CollisionShape2D").shape.size = Vector2(128, 20)` iria sobrescrever o comando anterior, e o shape de colisão de todos seria esse último.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/2eaf0a17-2e57-456e-8bea-963973016d20" />
</p>

### Make Unique

A opção *Make Unique* é mais simples, mais pontual e mais "radical". Esta opção você não habilita no node original, mas sim na instância. Ao habilitá-la, a engine cria uma cópia do recurso para a instância. Essa cópia é totalmente independente da original. Note que para acessar essa propriedade, você precisa primeiro ativar a *Editable Children* ou *Make Local*. A mesma observação sobre transformações e outras coisas continuam valendo. O node ainda é filho do original e reage à certas alterações dele.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/f2e365ce-f9fe-419c-9dd0-f5cd71d37b7a" />
</p>

É possível implementar o *Make Unique* por código. Para o caso do `CollisionShape2D` (exemplo), o comando `$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()` replica o *Make Unique*. De maneira geral, `recurso = recurso.duplicate()` funciona para qualquer recurso, em que `recurso` é o nome do recurso. Se o recurso tiver sub-recursos dentro, use `recurso = recurso.duplicate(true)`. 

## Detectando recursos compartilhados

Se você estiver em dúvida se um recurso de um node está sendo compartilhado com o de um outro node, olhe para a propriedade *Path* do recurso. Se esta propriedade for igual para o recurso em dois nodes diferentes, então é o mesmo recurso, está sendo compartilhado. Caso seja diferente, são recursos independentes.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/d779ee0a-a641-4155-a557-cab6b3fe747b" />
</p>

## Criando recursos

Para criar o seu próprio recurso, a primeira coisa que deve fazer é criar um arquivo *.gd*. Este arquivo vai conter a classe que representa o recurso a ser criado. 

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/b7c13dbf-0273-4268-89d6-4a68cf3330aa" />
  <img width="400" src="https://github.com/user-attachments/assets/782cf3a4-9a9c-4642-a81f-1661f1d95228" />
</p>

No que diz respeito à escrita de código, a única diferença entre uma classe normal e uma classe representando um recurso é que a segunda usa o `extends Resource`. Mas essa diferença faz toda a diferença. A partir desta classe, você pode criar instâncias em formato de arquivo *.tres*. Vamos ver como funciona na prática.

Começamos criando o nosso arquivo *stats.gd*. Ele possui a declaração das variáveis da instância e o `_init` para criar instâncias com parâmetros. 

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/6b55a08f-720d-4ee9-ad64-bd3accf58273" />
</p>

Uma vez que o arquivo da classe já existe, o próximo passo é ir no *FileSystem* novamente e criar um arquivo do tipo *Resource*. Na janela que abriu, busque o nome da classe que acabou de criar e clique em *Create*. Após isso você pode salvar o arquivo com o nome que quiser.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/72b096b9-101a-467d-af91-750f92484dc1" />
  <img width="650" src="https://github.com/user-attachments/assets/f6a93306-d322-4b17-aa44-da91ccf168d2" />
  <img width="700" src="https://github.com/user-attachments/assets/b2bd05ea-b42d-487b-aff8-ab98897f89a6" />
</p>

No *FileSystem*, clique duas vezes no arquivo que acabou de criar para abri-lo no *Inspector*. Você irá notar que está tudo como no default do `_init`. É aqui que a coisa começa a ficar interessante. Você pode alterar os valores do *Inspector* e mandar salvar o arquivo. Com isso, você terá salvo em um arquivo uma instância da classe. Geralmente, instâncias de classes são criadas dentro do código, durante a execução. Neste caso você possui um arquivo com esta instância, ele pode ser carregado em diversos lugares diferentes do projeto e inclusive pode ser usado em outros projetos.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/610ccd74-6696-4610-b0a2-c12fd07b6ab1" />
</p>

Alteramos alguns campos deste arquivo no *Inspector* e salvamos (ctrl+S). 

<p align="center">
  <img width="340" src="https://github.com/user-attachments/assets/d8ea7902-2c0e-40b6-8eb4-ef4979420af3" />
</p>

Agora vamos ver como usar isso. Ao usar o comando `@export var stats: Stats`, o campo de fato aparece no *Inspector*, mas aparece vazio pois você só declarou a variável com o tipo da classe de recurso. 

<p align="center">
  <img width="1000" src="https://github.com/user-attachments/assets/7dd40659-8a91-41ae-83f4-385c53c0d3ea" />
</p>

Arraste o arquivo de recurso criado para o campo. Com isso, você está definindo um valor para esta variável, que é uma instância da classe.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/a1af6266-67eb-471c-a56a-704d5a4de6e4" />
</p>

Apenas para testar as coisas, printamos os atributos `health` e `strings`, e inserimos a textura em um `Sprite2D` que fica logo acima do personagem. 

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/d308bb36-478e-436e-b77a-9a259b1435f8" />
  <img width="400" src="https://github.com/user-attachments/assets/5c546b3b-9dcf-47f7-9440-add610b5be23" />
</p>

Se quiser, você pode ir no *Inspector* e clicar no item do recurso para abri-lo e ver as suas propriedades. Todas elas são editáveis. Para este exemplo, achei interessante alterar todas. 

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/a9713889-06db-4827-893d-ae9e87c5875d" />
  <img width="400" src="https://github.com/user-attachments/assets/94d62108-a711-42a3-8e7c-89686ef7469f" />
</p>

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/a42ca346-7082-4942-bfa8-52f19fb9da5b" />
  <img width="400" src="https://github.com/user-attachments/assets/f11a962d-5997-4a92-8f29-96c5c9e97e9d" />
</p>

⚠️ **Atenção:** É bom ter em mente que isso altera o recurso original (recursos não criam duplicatas por padrão). Caso queira manter o original, em vez de arrastar o arquivo de recurso do *FileSystem*, vá direto na propriedade exportada no *Inspector* e clique nela. Você verá que tem a opção da própria classe ali. Clique nela e isso irá criar uma instância zerada para você trabalhar.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/1f71988e-598c-4e0d-b9e4-606d45642822" />
  <img width="400" src="https://github.com/user-attachments/assets/ce94feaf-2bda-454a-8464-a7de75d2b5d3" />
</p>

Em vez de usar o arquivo de recurso, você também pode criar uma instância da maneira tradicional.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/beb30139-09bb-4f8c-9d32-ca219df65035" />
  <img width="600" src="https://github.com/user-attachments/assets/04172b13-97c7-4343-a711-a4d6ec423c57" />
</p>

