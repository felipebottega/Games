# File paths in Godot projects

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
  - - **DirAccess.open().get_files():** Análogo ao anterior, mas retorna os arquivos dentro de uma pasta.
