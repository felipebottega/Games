# Using NavigationLinks

O node `NavigationLink2D` é bem simples, você define um ponto inicial em uma região de navegação e um ponto final em outra região, daí o agente é capaz de transitar entre regiões a partir destes links. O servidor de fato usa o link para conectar as duas regiões e calcular um caminho único que considera as duas regiões. Repare no exemplo abaixo. Temos duas regiões separadas, o agente (ícone da Godot), o target (ícone escuro da Godot) e o `NavigationLink2D` (linha parcial rosa).  

<p align=center">
  <img width="800" src="https://github.com/user-attachments/assets/e6d91ac1-4ef2-41c3-978b-ece79dfcdf08" />
</p>

O agente foi programado para ir atrás do target. Com o link desativado, ele vai até o ponto mais próximo dentro da primeira região. Ele não é capaz de ir além disso. Ao habilitar o link, o caminho total é calculado levando em consideração o link entre as regiões.

<p align=center">
  <img width="800" src="https://github.com/user-attachments/assets/4c9ca7cd-e397-4043-9ee5-46ef96730530" />
  <img width="800" src="https://github.com/user-attachments/assets/1d31c88b-e028-4c77-82ad-158595987464" />
</p>


## Configurando o NavigationLink

Para criar um `NavigationLink2D` funcional, primeiro coloque este node da cena e posicione o seu ponto inicial e final nas regiões. É importante que a propriedade *Enabled* esteja ativada. 

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/86d4eae0-a714-40e6-856c-03b20a1bd0ff" />
  <img width="300" src="https://github.com/user-attachments/assets/5c209abf-74e9-4766-b3c3-8026a695457b" />
</p>

> PS: A propriedade *Bidirectional* determina se é possível o agente atravessar o link nas duas direções ou apenas em uma.

Isso ainda não será o suficiente para o agente percorrer o caminho do link. É necessário definir como ele vai percorrer esse caminho, e isso deve ser feito pelo desenvolvedor. A Godot não tem rotinas prontas para percorrer estes links. 

Primeiramente, é necessário que o servidor saiba que o ponto inicial do link foi atingido. Isto é feito através de um sinal emitido pelo agente. A partir deste sinal, decidimos no código o que o agente irá fazer. Existem várias possibilidades e cada uma pode ser implementada de diversas maneiras diferentes. Vou apresentar uma possibilidade simples aqui. Neste exemplo, a função do sinal extrai as posições inicial e final do link e altera uma flag que comunica ao programa que o agente deve começar a travessia pelo link agora.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/51f34bc8-fa04-47ad-98eb-99fa86bbd16b" />
  <img width="650" src="https://github.com/user-attachments/assets/173d270e-b2ca-4177-854b-695338b032a8" />
</p>

O trecho no final da função abaixo é a função normal do agente (já a vimos anteriormente). Quando a flag de travessia está ativada, implementamos um movimento normal de `CharacterBody2D` indo até o ponto final do link. Ou seja, o agente vai se mover em linha reta até o ponto final.

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/6b055f36-79cc-416a-b69e-586a27b7f229" />
</p>

⚠️ Atenção: É preciso ter uma certa atenção com a propriedade *Path Desired Distance*. Para relembrar, esta propriedade define a distância (em pixels) para a engine considerar que o agente já atingiu o próximo ponto da sequência. Caso ele esteja se movendo muito rápido e esta propriedade tenha um valor muito baixo, o agente pode ultrapassar o ponto inicial do link. Se isso acontecer, o agente pode ficar oscilando entre este ponto e o anterior, sem conseguir avançar e sem conseguir ativar o sinal. Assim, ele ficará preso. 
