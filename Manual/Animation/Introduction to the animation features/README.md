# Introduction to the animation features

O node `AnimationPlayer` pode gerar animações sobre qualquer outro noe, então não é preciso se preocupar se ele é filho ou pai de algum node em específico. Começamos com uma simples cena de um `Node2D` contendo um `AnimationPlayer` e um `Sprite2D` que será animado. Ressaltamos que a animação de agora não é animação como um `AnimatedSprite2D`, mas sim animação das transformações 2D sobre o sprite.

No painel de animação, clique para adicionar uma nova animação e escolha um nome para ela.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/79981d3e-47ed-4c3d-b1df-fc9a1954c98b" />
</p>

O painel de animação possui 4 partes principais: 
 - Tracks: Cada track corresponde a algum tipo de animação sobre algum objeto em específico. Todas as tracks ocorrem simultaneamente, podendo ser cada uma sobre objetos distintos.
 - Timeline: Linha do tempo da animação. Ali você verá marcadores indicando quando algum evento de animação vai acontecer.
 - Animation Controls: Principais ferramentas para gerenciar e editar as animações.
 - Timeline Controls: Configurações sobre a visualização do Timeline. Essas configurações não tem efeito nenhum sobre nas animações em si.  

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/85166f4b-d008-4074-83e4-993831ca7800" />
</p>

> PS: Como mostrado na figura abaixo, algumas opções aparecem no editor quando você está no node `AnimationPlayer`. Nós iremos ignorar estes botões em favor da edição mais precisa pelo Inspector. Portanto, pode simplesmente fingir que eles não existem.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/7621a87f-9e9e-4b42-b031-c5411b7e6cd6" />
</p>

## Animando propriedades

Clique em *+ Add Track* e selecione *Property Track*. Uma janela com a árvore de nodes vai se abrir. Escolhe o node que quer animar. Depois disso vai se abrir uma outra janela, agora com as propriedades deste node (as dele mesmo e as herdadas). Você pode editar qualquer propriedade que quiser. Isso já evidencia o quão poderosa é esta ferramenta, pois ela não é simplesmente uma ferramenta de animação, mas sim uma ferramenta de controle de estados dos nodes.

<p align="center">
  <img width="150" src="https://github.com/user-attachments/assets/8e2b564b-6c7b-473a-812c-f782eb135bd7" />
  <img width="220" src="https://github.com/user-attachments/assets/35f7b458-75f7-413b-bce9-c9f7f0bafe85" />
  <img width="630" src="https://github.com/user-attachments/assets/b6073fb1-efa8-4a5d-9d3c-71affe3df3b5" />
</p>

Dê o segundo clique do mouse sobre a linha vertical azul no track (essa linha marca o ponto da animação que o editor está no momento) e selecione a opção *Insert Key*.

<img width="576" height="257" alt="image" src="https://github.com/user-attachments/assets/ae30d732-0bab-43ac-ae9e-3531e7874224" />
<img width="445" height="244" alt="image" src="https://github.com/user-attachments/assets/c7ce6f08-fb89-4716-8a54-d02ae3ddb4a5" />

