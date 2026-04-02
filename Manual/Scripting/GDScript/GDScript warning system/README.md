# GDScript warning system

Para as opções do sistema de alertas do editor, vá para *Project → Project Settings → General → Debug → GDScript* (é necessário habilitar o modo avançado das opções). Ali você tem acesso ao modo default da engine de emitir alertas. Nessa tela você pode mudar como funciona o sistema de alerta, mas isso valerá para o projeto todo.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/69bb09c2-d35c-4c64-ad8c-6a399e3d135d" />
</p>

## Warning ignore

Caso não seja interessante alterar o sistema de alertas para o projeto inteiro, você ainda pode colocar por trechos de código.

Abaxo temos um exemplo de uma situação que ativa um alerta. Temos uma variável declarada que não foi utilizada para nada. 

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/36123ac2-03cf-4724-b2ae-b58ede414563" />
</p>

Se quisermos nos livrar deste alerta (pois alerta/warning não significa que a execução vai quebrar), podemos usar a anotação `@warning_ignore()`. Esta anotação precisa de um argumento de entrada para funcionar. Ao escrever os parênteses as opções já vão aparecer na tela. 

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/7f79b3da-19a1-45f0-aef1-35c47dc6c842" />
</p>

Porém, o que eu é que você apenas clique no *Ignore* à esquerda do alerta. Com isso a anotação será inserida já com a opção correta.

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/6bbb685e-f95d-4622-984b-da4872c44f6b" />
</p>
