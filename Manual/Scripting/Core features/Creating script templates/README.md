# Creating script templates

Quando você vai criar um script para um node, a janela de configuração inicial costuma mostrar algumas escolhas de templates de script. Geralmente as escolhas serão apenas *Node* e *Object*. Alguns nodes como o `CharacterBody2D` possuem um template de script mais personalizado.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/8cfb8c4b-de67-4a54-8bb8-f0b6cb8fc9ed" />
</p>

O template *Node* vem com o básico: o `extends` a partir do node associado ao script e as funções nativas `_ready` e `_process`. O template *Object* contém apenas o `extends`. Caso o node tenha um script mais personalizado, será algo específico.

<p align="center">
  <img width="720" src="https://github.com/user-attachments/assets/b79b9cc3-1964-4eba-b1bd-52270ea75350" />
</p>
