# Groups

Na Godot, grupos funcionam como tags. Você pode adicionar um node a quantos grupos quiser. Em seguida, no código, você pode usar a SceneTree para
- Obter uma lista de nodes em um grupo.
- Chamar um método em todos os nodes de um grupo.
- Enviar uma notificação para todos os nodes de um grupo.

⚠️ Atenção: Esta série de tutoriais começou na Godot 4.4 e agora já está na 4.6. O painel à direta foi ligeiramente alterado. Anteriormente, para acessar os grupos, deveríamos ir na aba *Node* e depois *Groups*. Agora a aba *Groups* já está disponível diretamente.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/c6696d94-ab46-4abf-af1d-2231ccde8f5f" />
</p>

## Adicionando nodes a um grupo

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

