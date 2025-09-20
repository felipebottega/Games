# File paths in Godot projects

## Principais métodos de caminhos

Godot possui diversos métodos semelhantes a Python para trabalhar com strings e caminhos. Abaixo, temos uma lista dos mais básicos. Em todos os itens, considere que *x* e *y* são strings de caminhos.

  - **path_join:** Faz o join de caminhos. Análogo ao `os.path.join` de Python. Exemplo de uso: `x.path_join(y)`.
  - **get_file:** Extrai o nome do arquivo no caminho. Exemplo de uso: `y.get_file()`.
  - **get_base_dir:** Extrai a primeira pasta no caminho. Exemplo de uso: `y.get_base_dir()`.
  - **get_basename:** Extrai o caminho completo até a última pasta antes do arquivo. Exemplo de uso: `y.get_basename()`.
  - **similarity:** Simlariadde de strings (0 = nenhuma, 1 = idênticas). Exemplo de uso: `x.similarity(y)`.
  - **split:** Faz split por uma substring. Exemplo de uso: `y.split("scenes")`.
  - **replace:** Replace de substring. Exemplo de uso: `y.replace("res", "abc")`.
  - **to_float:** Converte string para float. Também tem conversões análogas para outros tipos de variável. Exemplo de uso: `"123.45".to_float()`.
  - **ProjectSettings.globalize_path:** Extrai o caminho absoluto em relação ao sistema operacional. Exemplo de uso: `ProjectSettings.globalize_path(y)`.
  - **DirAccess.open().get_directories():** Extrai todas as pastas dentro de uma pasta. Primeiro o `DirAccess.open(x)` retorna um objeto de Godot próprio para lidar com pastas. Depois o método `get_directories()` retorna todas as pastas dentro de *x*. Exemplo de uso: `DirAccess.open(x).get_directories()`.
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

## res:// e user://

De maneira simples e direta, `res://` é a raíz dos arquivos do projeto e `user://` é a raíz dos arquivos dos jogador em relação ao projeto. Esperamos que em `user://` sejam armazenadas coisas como saves, configuração do jogo, entre outros. Em desktop, o `user://` se encontra em uma pasta específica, a depender do sistema operacional.

<p align="center">
  <img width="700" src="https://github.com/user-attachments/assets/3d629e09-4432-446f-92fe-09dd9085ffab" />
</p>

> PS: No Windows, você pode colocar *%APPDATA%* diretamente na barra de busca do Windows Explorer e ele te levará para o local esperado.

Além da pasta do jogador em relação a um jogo, também há um local onde dados do editor são armazenados. Ali você terá coisas como a configurações do editor, cache de shaders, entre outros. Abaixo, mostramos onde este local se encontra.

<p align="center">
  <img width="480" src="https://github.com/user-attachments/assets/e18213b4-a673-4d22-8de3-d3bb048734ee" />
</p>
