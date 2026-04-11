# GDScript warning system

Para acessar as opções do sistema de avisos do editor, vá para *Project → Project Settings → General → Debug → GDScript* (é necessário habilitar o modo avançado das opções). Ali você tem acesso ao modo default da engine de emitir avisos e pode mudar como funciona este sistema para o projeto.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/69bb09c2-d35c-4c64-ad8c-6a399e3d135d" />
</p>

> PS: Depois de alterar algumas destas configurações, pode ser necessário reiniciar o editor para fazer efeito.

## Warning ignore

Caso não seja interessante alterar o sistema de avisos para o projeto inteiro, você pode colocar isso apenas para trechos de código. Abaixo, temos um exemplo de uma situação que ativa um aviso. Temos uma variável declarada que não foi utilizada para nada. 

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/36123ac2-03cf-4724-b2ae-b58ede414563" />
</p>

Se quisermos nos livrar deste aviso, podemos usar a anotação `@warning_ignore()`. Esta anotação precisa de um argumento de entrada para funcionar. Ao escrever os parênteses as opções já vão aparecer na tela. 

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/7f79b3da-19a1-45f0-aef1-35c47dc6c842" />
</p>

O que eu recomendo é que você apenas clique no *[Ignore]* à esquerda do aviso. Com isso a anotação correta será inserida automaticamente.

<p align="center">
  <img width="320" src="https://github.com/user-attachments/assets/6bbb685e-f95d-4622-984b-da4872c44f6b" />
</p>

Também é possível delimitar blocos em que certos avisos não são emitidos, usando as anotações `@warning_ignore_start()` e `@warning_ignore_restore()`, como mostrado no exemplo abaixo. Repare que o editor está reclamando apenas da variável `delta` não utilizada.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/f31345f2-273e-473f-a711-7ccef4dd71fb" />
</p>

Por fim, note que é possível usar estas anotações com múltiplos argumentos e não precisa fechar o `@warning_ignore_start()` (ele terá efeito até o fim do código).

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/a8f0de2c-259f-4e36-a0d4-7d3b9e9d8d83" />
  <img width="600" src="https://github.com/user-attachments/assets/ac9ce927-e6e4-4566-80fb-e3390fd5b5f7" />
</p>

