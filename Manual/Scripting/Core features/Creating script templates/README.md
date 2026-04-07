# Creating script templates

Quando você vai criar um script para um node, a janela de configuração inicial costuma mostrar algumas escolhas de templates de script. Geralmente as escolhas serão apenas *Node* e *Object*. Alguns nodes como o `CharacterBody2D` possuem um template de script mais personalizado.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/8cfb8c4b-de67-4a54-8bb8-f0b6cb8fc9ed" />
</p>

O template *Node* vem com o básico: o `extends` a partir do node associado ao script e as funções nativas `_ready` e `_process`. O template *Object* contém apenas o `extends`. Caso o node tenha um script mais personalizado, será algo específico.

<p align="center">
  <img width="720" src="https://github.com/user-attachments/assets/b79b9cc3-1964-4eba-b1bd-52270ea75350" />
</p>

Pode ocorrer de, num jogo seu, você querer inicializar todos os seus `CharacterBody2D` com outro script em vez de ficar inicializando com esse default e depois ter que ficar alterando. É possível criar seus próprios scripts template. Vamos ver aqui como fazer isso.

## Localização dos scripts template

Na pasta do seu projeto, crie uma pasta chamada *script_templates*. Se você for criar um script template para o `CharacterBody2D`, ele deverá ser um arquivo *.gd* dentro da pasta *CharacterBody2D*. Se for um script template, deverá estar dentro da pasta *Sprite2D*, e assim por diante. É possível ter múltiplos scripts templates dentro de cada pasta.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/37ef936f-94ab-486b-bc61-2fb5e39b4a82" />
</p>

> Dica: Crie o arquivo vazio *.gdignore* dentro da pasta. Isso vai garantir que a Godot não importe estes scripts, o que é desnecessário para este caso.

## Configurando o script template

O seu script template não precisa de nada especial, apenas o `extends` deve estar de acordo com o node. Se você colocou um script na pasta `Sprite2D`, ele deve usar `extends Sprite2D`. Você também pode incluir comentários começando com as keywords `meta-name:` e `meta-description:`. A primeira é o nome que vai aparecer na lista de escolhas de scripts e a segunda é a descrição que vai aparecer. A figura abaixo mostram como funciona.

<p align="center">
  <img width="440" src="https://github.com/user-attachments/assets/3a16319d-b7a0-4d48-8028-d89ce8cf595c" />
  <img width="500" src="https://github.com/user-attachments/assets/05f71181-f812-4f14-a810-4821d7883734" />
</p>

Agora é só escolher o seu script template e começar a trabalhar a partir dele, não tem mistério!
