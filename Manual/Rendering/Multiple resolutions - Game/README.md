# Multiple resolutions - Game

Decidi fazer este jogo para praticar os conhecimentos sobre `SubViewport` e resolução. Vou aproveitar e utilizar outros conhecimentos bacanas que foram vistos anteriormente. A ideia é fazer um jogo que tenha uma "subtela" capaz de ver o cenário com outra visão, de modo a revelar coisas que não conseguiríamos ver normalmente. Também será possível configurar a resolição do jogo na tela do menu.

## Assets

Depois de obter as spritesheets e tilesheets, montamos um cenário de fazenda contendo diversos animais. O level principal possui `NavigationRegion2D` com o caminho que as ovelhas seguem. O objetivo do jogo é utilizar a subtela/visor para identificar quais ovelhas na verdade são lobos disfarçados.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/bbd4da09-6cdd-4290-a81a-0aa70b3256cd" />
</p>

Cada animal possui sua própria cena, que é um `CharacterBody2D`. O template geral é de um `Node2D` contendo um `Sprite2D` para a sombra e um `AnimatedSprite2D`. Além disso, a cena também contém um `CollisionShape2D`. A necessidade do `Node2D` é para poder efetuar um flip horizontal coerente, uma vez que o sprite não está centralizado perfeitamente na origem. Isso ainda não resolve todo o problem, pois a colisão fica um pouco deslocada após o flip. O ideal seria centralizar tudo, mas percebi isso tarde demais e não quis arrumar.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/1a0595cb-f903-440b-a2d5-cd86614bc72e" />
</p>

> PS: Não coloquei a colisão dentro do `Node2D` para receber o mesmo flip porque não é recomendado mudar escala de [objetos físicos](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20introduction#mudan%C3%A7a-de-escala-e-f%C3%ADsica).

## Navegação

O único animal que possui uma estrutura é a ovelha, pois esta precisa de um sistema de navegação. Sendo assim, ela possui um node `NavigationAgent2D`. O script associado é bem semelhante aos que vimos nos tutoriais de navegação de [agentes](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Using%20NavigationAgents) e [links](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Using%20NavigationLinks). Recomendo dar uma revisada.

<p align="center">
  <img width="190" src="https://github.com/user-attachments/assets/29dc25ba-3149-4229-9fb7-1b991208a686" />
  <img width="310" src="https://github.com/user-attachments/assets/393d2ab2-872e-4e4b-9330-c006a0bd63a2" />
  <img width="500" src="https://github.com/user-attachments/assets/3ec4d4eb-5762-4a32-a0ab-62cd10884bed" />
  <img width="500" src="https://github.com/user-attachments/assets/28f8a4ca-fb83-4b99-834c-0afe7a1c5aaf" />
</p>

## Subviewport

Agora vamos criar o visor que consegue identificar as ovelhas falsas. Vamos seguir o mesmo procedimento feito no terceiro exemplo do [tutorial de subviewport](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Rendering/Using%20Viewports#efeito-raio-x-com-a-c%C3%A2mera). Neste caso o "raio-X" servirá para separar ovelhas verdadeiras de falsas. 

Começamos criando um retângulo no GIMP. Este retângulo tem uma borda e um interior com cor e transparência. Seria possível ter o mesmo efeito usando as ferramentas da engine, mas achei mais prático fazer isso pelo GIMP. Podemos ver na figura abaixo o retângulo no GIMP à esquerda e o efeito desejado em prática na direita.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/11bda2c9-7579-4263-a5fa-5a7e7e5debde" />
  <img width="300" src="https://github.com/user-attachments/assets/784e00c9-70d9-42c3-a11a-e0e009b701bc" />
</p>

O container do subviewport foi colocado ao fim da cena do level. O script segue a mesma ideia do script do tutorial mencionado acima. O desafio foi implementar a lógica de uma ovelha vermelha espelhando o comportamento da ovelha original da cena. Os códigos abaixo contém tudo que foi necessário para atingir este resultado.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/f4ffcea7-4aa6-4aa5-96ce-e0e4662d8ea4" />
  <img width="400" src="https://github.com/user-attachments/assets/8af90b8c-2ce3-4f27-b1d0-3eadb3a26250" />
  <img width="400" src="https://github.com/user-attachments/assets/5f0868f4-9ec4-44bb-826f-78d1443f40d8" />
  <img width="500" src="https://github.com/user-attachments/assets/981e305a-5619-4ada-95d6-4254af2984c4" />
  <img width="500" src="https://github.com/user-attachments/assets/6b7ff079-2ab7-4d8f-9596-fe43033b62bc" />
</p>

> PS: Na Godot, `set_meta`, `get_meta` e `has_meta` são uma forma de você anexar dados arbitrários a qualquer node, sem precisar declarar variáveis no script. Considere como um dicionário escondido dentro do node. No nosso caso, usamos `mirror.set_meta("target_node", instance)`. Isso pode ser lido como "Essa ovelha aqui é um espelho, e o original dela é esse *instance*". Depois, no script, usamos `var target = get_meta("target_node")`. Ou seja, se tem *target_node*, é espelho, caso contrário é uma ovelha normal. Essa lógica poderia ser feita com uma variável booleana, mas aí o trabalho seria muito mais manual e propenso a erros.

⚠️ **Atenção:** Duplicar nodes, como fizemos aqui, não é a maneira mais eficiente de se resolver esta questão da ovelha do subviewport. Isso foi feito pois ficou mais direto o uso de subviewport dessa maneira, e a ideia era usar subviewport como exemplo de aplicação.

## Resolução

Para finalizar, vamos abordar o principal objetivo deste jogo, que é a inclusão de opções de resolução. A configuração inicial do jogo é de $1920 \times 1080$, com tela cheia, modo *canvas_items* e *aspect* como *expand* (veja o [tutorial anterior](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Rendering/Multiple%20resolutions) para saber o que essas propriedades fazem).

<p align="center">
  <img width="750" src="https://github.com/user-attachments/assets/ed23f5eb-580d-4896-97c9-24d557a37b5d" />
</p>

A árvore da cena Main segue a estrutura mostrada abaixo. Para implementar a resolução, devemos criar um `TextureRect`. Logo após isso, vá em *Inspector → Texture → Transform → Size* e coloque o `TextureRect` na resolução base da viewport, $1920 \times 1080$. Feito isso, vá em *Inspector → Texture → ViewportTexture* e selecionar o node `SubViewport`. Este node deve conter todas as texturas que irão sofrer o processo de mudança de resolução. Note que deixamos o HUD de fora disso, mas é opcional.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/6c363a82-0dee-4409-aa12-572a56a6f48d" />
  <img width="300" src="https://github.com/user-attachments/assets/cbaedb03-dc4a-49d1-8832-e45414ed212f" />
  <img width="250" src="https://github.com/user-attachments/assets/9f32604a-1545-4a22-b11b-d88221200fa2" />
</p>

> PS: É importante arrumar o *size* do `TextureRect` antes de tudo, senão você vai ter problemas para entender o que está acontecendo depois. Se adicionar o `SubViewport` ao `TextureRect` sem fazer essa etapa, ele vai apreencher o *size* automaticamente com os valores corretos, mas internamente a engine vai entender que é para diminiuir a imagem em vez de alterar a sua resolução.

O projeto recebeu um script global, chamado *game_state.gd* (primeira imagem abaixo à esquerda). Ele apenas armazena algumas variáveis globais do jogo. Note que o jogo começa com a resolução baixa de $240 \times 135$, isto é apenas para fazer o jogador ter que ir nas configurações e trocar (o que é o propósito de todo este projeto, basicamente). Os dois trechos de script mostrados à direita são da cena Main. Um mostrando a inicialização do jogo com a resolução global. O outro mostrando como as alterações de configuração emitem sinais que alteram a resolução e modo de visualização.  

<p align="center">
  <img width="210" src="https://github.com/user-attachments/assets/688f38fa-2a18-44f3-876a-f4cd8d26a593" />
  <img width="520" src="https://github.com/user-attachments/assets/01d1a3bc-23db-452f-8f61-ebfcabba633d" />
  <img width="540" src="https://github.com/user-attachments/assets/5ac1060e-66e6-44b3-82a9-b9c8b1bffb22" />
</p>

O `SubViewport` deve estar configurado com a resolução máxima e a propriedade *Size 2D Override* ativada e também na resolução máxima. Recomendo dar uma relembrada [nesta propriedade](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Rendering/Using%20Viewports#size-e-stretch) para entender o que ela faz.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/bfe2245b-737f-447a-93bf-cffcd8e02fe7" />
</p>

A função `DisplayServer.window_set_mode()` é geral do projeto, então não importa em qual cena ela é alterada, vai alterar e vai se manter pelo jogo inteiro. O mesmo não vale para a resolução. Precisamos replicar a estrutura de `TextureRect` e `SubViewport` em todas as cenas que são afetadas pela mudança de resolução. Provavelmente deve ser mais interessante rodar o jogo inteiro numa única cena Main com essa estrutura, mas por enquanto estamos no esquema de troca de cenas ainda. Para um jogo pequeno como este, não tem problema.

Acesse [este link](https://felipebottega.github.io/Games/Manual/Rendering/Multiple%20resolutions%20-%20Game/html/) para conferir como ficou o jogo!
