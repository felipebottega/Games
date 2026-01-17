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

<p align=center">
  <img width="200" src="https://github.com/user-attachments/assets/86d4eae0-a714-40e6-856c-03b20a1bd0ff" />
  <img width="300" src="https://github.com/user-attachments/assets/5c209abf-74e9-4766-b3c3-8026a695457b" />
</p>

> PS: A propriedade *Bidirectional* determina se é possível o agente atravessar o link nas duas direções ou apenas em uma.

