# File paths in Godot projects

## Principais métodos de caminhos

Godot possui diversos métodos semelhantes a Python para trabalhar com strings e caminhos. Abaixo, temos uma lista dos mais básicos. Em todos os itens, considere que $x$ e $y$ são strings de caminhos.

  - **path_join:** Faz o join de caminhos. Análogo ao `os.path.join` de Python. Exemplo de uso: `x.path_join(y)`.
  - **get_file:** Extrai o nome do arquivo no caminho. Exemplo de uso: `y.get_file()`.
  - **get_base_dir:** Extrai a primeira pasta no caminho. Exemplo de uso: `y.get_base_dir()`.
  - **get_basename:** Extrai o caminho completo até a última pasta antes do arquivo. Exemplo de uso: `y.get_basename()`.
  - **similarity:** Simlariadde de strings (0 = nenhuma, 1 = idênticas). Exemplo de uso: `x.similarity(y)`.
  - **split:** Faz split por uma substring. Exemplo de uso: `y.split("scenes")`.
  - **replace:** Replace de substring. Exemplo de uso: `y.replace("res", "abc")`.
  - **to_float:** Converte string para float. Também tem conversões análogas para outros tipos de variável. Exemplo de uso: `"123.45".to_float()`.
  - **ProjectSettings.globalize_path:** Extrai o caminho absoluto em relação ao sistema operacional. Exemplo de uso: `ProjectSettings.globalize_path(y)`.
  - **DirAccess.open().get_directories():** Extrai todas as pastas dentro de uma pasta. Primeiro o `DirAccess.open(x)` retorna um objeto de Godot próprio para lidar com pastas. Depois o método `get_directories()` retorna todas as pastas dentro de $x$. Exemplo de uso: `DirAccess.open(x).get_directories()`.
  - **DirAccess.open().get_files():** Análogo ao anterior, mas retorna os arquivos dentro de uma pasta.

## Strings contendo variáveis

Há duas maneiras principais de gerar strings contendo variáveis. A primeira é fazer soma de string, se atentando a converter váriaveis de diferentes tipos para string. O exemplo abaixo ilustra uma situação destas.

```
var name = "Integral"
var health = 1234

print(name + ' health is ' + str(health))

---------------------------------------
Output: Integral health is 1234
```

Outra maneira é utilizar o método `format`. Coloque `{i}` no lugar da sua variável dentro da string, em que *i* é o *i*-ésimo elemento, começando do zero. Depois da string, coloque um `.format([x_0, x_1, ..., x_n])`. A lista deve ter o mesmo número de variáveis que você inseriu na string, e na mesma ordem. Um exemplo deixará mais claro como funciona. 

```
var name = "Integral"
var health = 1234

print("{0} health is {1}".format([name, health]))

---------------------------------------
Output: Integral health is 1234
```

Também é possível fazer isso através de um dicionário, como mostrado abaixo.

```
var name = "Integral"
var health = 1234

print("{player_name} health is {player_health}".format({player_name=name, player_health=health}))

---------------------------------------
Output: Integral health is 1234
```

## res:// e user://

De maneira simples e direta, `res://` é a raíz dos arquivos do projeto e `user://` é a raíz dos arquivos dos jogador em relação ao projeto. Esperamos que em `user://` sejam armazenadas coisas como saves, configuração do jogo, entre outros. Em desktop, o `user://` se encontra em uma pasta específica, a depender do sistema operacional.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/3d629e09-4432-446f-92fe-09dd9085ffab" />
</p>

> PS: No Windows, você pode colocar *%APPDATA%* diretamente na barra de busca do Windows Explorer e ele te levará para o local esperado.

Além da pasta do jogador (uma para cada jogo), também há um local onde dados do editor são armazenados. Ali você terá 3 tipos de dados: 

1. **Editor data:** Contêm modelos de exportação e dados específicos do projeto.
2. **Editor settings:** Contêm o arquivo principal de configuração do editor, bem como diversas outras personalizações específicas do usuário (layouts do editor, perfis de recursos, modelos de script, etc.).
3. **Cache:** Contém dados gerados pelo editor ou armazenados temporariamente. Ele pode ser removido com segurança quando o Godot for fechado.

<p align="center">
  <img width="450" src="https://github.com/user-attachments/assets/88b41546-57d9-4584-907e-cddcf5df5cdf" />
</p>

## Varredura pelos arquivos

Associado a este tutorial, temos um jogo de exemplo, mostrando todas as funcionalidades discutidas aqui. Além disso, foi incluída uma função de varredura. A partir de uma pasta raíz, ela faz uma busca recursiva por todas as pastas e arquivos, imprimindo eles na tela de maneira estrutura (a pasta `.godot` e arquivos com extensão `.import` e `.uid` são omitidos). 

<p align="center">
  <img width="250" height="117" alt="image" src="https://github.com/user-attachments/assets/f6f27317-cddc-4ed0-b2b9-6425e3533b0d" />
  <img width="400" src="https://github.com/user-attachments/assets/a2d2e053-ee58-49f3-b7c1-2ff7d4f9d437" />
  <img width="350" src="https://github.com/user-attachments/assets/91cdc358-3995-45c1-b612-31802b7167ef" />
</p>

O output é mostrado abaixo. À esquerda temos a varredura sobre `res://` e à direita a varredura sobre `user://`. Neste caso, o jogo foi executado na wev, por [este link](https://felipebottega.github.io/Games/Manual/File%20and%20data%20IO/File%20paths%20in%20Godot%20projects/html/). Neste caso, o `user://` em Godot HTML5 não tem acesso ao sistema de arquivos real do usuário. Ele usa *IndexedDB* (um banco de dados local do navegador, ou seja, os dados ficam armazenados no computador do usuário) para simular esse armazenamento local. Ou seja, tudo que você salva em `user://` vai para o *IndexedDB* do navegador. Isso permite que o jogo leia e escreva arquivos localmente no navegador como se fosse um disco, mas na verdade é tudo armazenado nesse banco do navegador. É persistente, então mesmo fechando a aba ou o navegador, os dados continuam lá, até serem apagados manualmente ou pelo navegador.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/df3559c0-42ee-4856-8542-fefbc0d93513" />
</p>
