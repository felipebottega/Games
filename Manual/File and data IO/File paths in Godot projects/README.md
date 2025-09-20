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


