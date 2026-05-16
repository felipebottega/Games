# Singletons - Autoload

*Autoload* (ou o termo menos usado, *singleton*) é algo que já aplicamos na prática algumas vezes, mas sem explicar o conceito. Recomendo dar uma olhada nos tutoriais de [TileMap](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Tools/Using%20TileMaps%20-%20Game#toques-finais), [Background loading](https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/Background%20loading#m%C3%A9todo-esperto-de-pr%C3%A9-carregamento) e [Saving games](https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/Saving%20games#npcs-e-checkpoints).

Em Godot, o autoload é uma funcionalidade que permite manter um script ou cena sempre carregada durante toda a execução do jogo. Na prática, ele funciona como um ponto global de acesso, onde você pode armazenar dados ou comportamentos que precisam persistir. Considere a situação em que o jogo precisa manter a quantidade de moedas do jogador entre diferentes fases. Se esse valor estiver em uma cena comum, ele será perdido ao trocar de fase. Ao usar um Autoload, esse dado permanece disponível e pode ser acessado de qualquer parte do jogo. Em resumo, Autoload é usado para representar estado ou sistemas globais persistentes.

> ⚠️ **Atenção:** Não carregue cenas autoload nem coloque como cena raíz do projeto. Se você fizer isso, a cena autoload terá duas instâncias repetidas no projeto (pois todo autoload já é carregado automaticamente quando o projeto é executado). Isso pode levar a comportamentos imprevisíveis e bugs.

## Stop antes de reexecução de cenas

Isso foi um detalhe bobo que me pegou durante a elaboração deste tutorial, mas vale a pena deixa aqui registrado. Quando você executa uma cena com F6 ou clicando no botão do painel <img width="150" src="https://github.com/user-attachments/assets/9cfd41f9-92d0-4875-a0e8-41548e14c899" />, é necessário dar stop na execução para poder executar outra cena. Não basta apenas selecionar outra cena no editor e dar F6 novamente, isso vai executar a cena anterior que estava rodando. 

## Criando um autoload

A primeira coisa a se fazer é criar a cena ou script que você quer que seja um autoload. Vamos ver como se faz isso através de exemplo. Criamos um jogo onde a cena Main possui dois botões, cada um gera um sinal que aciona uma mudança de cena com a chamada `get_tree().change_scene_to_file()`. O usuário tem duas escolhas, cada uma levando a uma cena diferente. Nesse jogo o jogador clica para criar uma bolinha no espaço 2D, e o objetivo é que ela caia, ultrapassando os obstáculos. Cada bolinha que sai da tela acrescenta um ponto para o usuário. Queremos que a pontuação seja cumulativa durante o jogo: o jogador pode trocar de cenas à vontade e acumular mais pontos. Por design, cada troca de cena deleta a cena atual, então a contagem de pontos precisa ser feita a nível global, em um autoload.

<p align="center">
  <img width="750" src="https://github.com/user-attachments/assets/b8cab8db-6d6b-40de-8f96-216850ef5093" />
</p>

### Script autoload

Existem várias maneiras de se resolver esse problema. A maneira adotada aqui foi a seguinte: criamos um script global que faz, a cada segundo, uma varredura todos os nodes da cena, registrando os que são do tipo `RigidBody2D` e já saíram da tela. As ocorrências são guardadas em um array, de modo que o tamanho do array é a pontuação do jogador.

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/2d442b89-2299-4b7f-a336-841a24ca3c09" />
</p>

Uma vez que o script está salvo, agora é hora de torná-lo um autoload. Para isso, vá em *Project → Project Settings → Globals* e clique no ícone de pasta para buscar o seu script. Após selecioná-lo, o nome dele vai aparecer no campo *Node Name* (este campo é para nodes e scripts). Você pode editar o nome se quiser. Depois disso clique em *+Add*, e o seu script vai aparecer na lista abaixo de objetos globais.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/2fc161e9-6805-441c-bb3b-fa6dc673bc15" />
  <img width="900" src="https://github.com/user-attachments/assets/eb22c4d3-20cf-4554-8a09-58ee98209687" />
  <img width="900" src="https://github.com/user-attachments/assets/84fc2af2-63e0-491e-a2d5-3e2f465c8ec7" />
</p>

Quando você executar o jogo e for em *Remote*, vai notar que um node associado ao script foi criado. Esse é o comportamento padrão, a Godot sempre vai incluir o script no projeto através de um node. Note também que ele é inserido primeiro na árvore de cenas (apenas abaixo de *root*).

<p align="center">
  <img width="230" src="https://github.com/user-attachments/assets/5e11f88f-5911-41ab-9e2a-3b2cea52bc2b" />
</p>

### Cena autoload

Note que não existe nenhuma indicação da pontuação na tela ainda. É possível adicionar um node `Label` em cada uma das cenas, e nesse node teríamos a pontuação, que é global. Isso não é muito conveniente pois exige criar um label por cena. Para esse exemplo, será mais interessante ter uma label única visível constantemente na tela. Isso é possível através de uma cena autoload.

A cena é um `CanvasLayer` contendo a label que fica no canto da tela, mais nada. 

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/39bf9849-bc2c-457c-ae5c-07be24961cd3" />
</p>

A extração da pontuação se dá através de um script atrelado a essa label.

<p align="center">
  <img width="350" src="https://github.com/user-attachments/assets/eee55688-110e-4c96-ba77-20d1e61323d3" />
</p>

Feito isso, repetimos o processo de ir em *Project → Project Settings → Globals* e registrar o node como global. Não é necessário registrar o script associado à label, ele ficará sendo global automaticamente por estar atrelado a um node global.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/2fdf6c8e-1f49-4c2e-8c08-56e2b872cfcb" />
</p>

Note na figura abaixo a ordem dos nodes na árvore durante a execução do jogo. A ordem dos autoloads segue a ordem listada em *Project → Project Settings → Globals*. Se a ordem for relevante, é só alterar ali.

<p align="center">
  <img width="230" src="https://github.com/user-attachments/assets/d442eeaf-99f5-4758-a1b7-df2d5be2866f" />
</p>

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Resources">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Using%20SceneTree">Próximo ➡</a>
</p>
