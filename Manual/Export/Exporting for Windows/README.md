# Exporting for Windows

## Changing the executable icon

Ao gerar o executável do seu jogo no Windows, o ícone utilizado é o ícone da Godot <img width="28" src="https://github.com/user-attachments/assets/0a3c6ed7-5dd2-48ef-9d63-a6492b698d50" /> por default. Para alterar isso quando for exportar, vá em *Options → Application → Icon* e escolha o arquivo do novo ícone. Depois disso, ao exportar o jogo para executável o ícone do arquivo será o que você escolheu. O ícone de  *Console Wrapper Icon* só faz sentido se você exportar com debug, pois isso cria um arquivo de console além do arquivo do jogo.

<p align="center">
  <img width="650" height="684" alt="image" src="https://github.com/user-attachments/assets/eba61d48-641b-493d-926f-cb82e28b86f5" />
</p>

Na imagem acima, podemos notar que, além do ícone, também é possível editar diversos metadados. Essas funcionalidades não vem de graça com a Godot, é necessário baixar o programa *rcedit.exe* do Windows, colocá-lo em algum lugar do seu computador e inserir este caminho em *Editor → General → Export → rcedit*, como mostrado abaixo. Provavelmente você terá reiniciar a Godot após estes passos.

<p align="center">
  <img width="650" src="https://github.com/user-attachments/assets/754ca574-c65f-4735-a75e-d31518e6efdc" />
</p>

## Copiando cenas entre projetos e problemas com uid

Saindo um pouco do tópico, pois esbarrei neste problema enquanto trabalhava no tutorial. É comum que a engine reclame de uid desconhecida quando você copia diretamente uma cena de um projeto para outro. Na Godot, os arquivos *.tscn* e *.gd* têm um sistema de uids para identificar recursos. Eles não são portáveis entre projetos diferentes — cada projeto tem seu próprio mapeamento. Abaixo temos um exemplo simples de arquivo *.tscn*. 

```
[gd_scene load_steps=2 format=3 uid="uid://dqmh2chf8nud5"]

[ext_resource type="Script" uid="uid://bidjtw1utkth7" path="res://label.gd" id="1_wtcfe"]

[node name="Node2D" type="Node2D"]

[node name="Label" type="Label" parent="."]
offset_left = 149.0
offset_top = 277.0
offset_right = 1026.0
offset_bottom = 387.0
theme_override_font_sizes/font_size = 80
text = "Exporting for Windows"
script = ExtResource("1_wtcfe")

[node name="Timer" type="Timer" parent="."]
autostart = true

[connection signal="timeout" from="Timer" to="Label" method="_on_timer_timeout"]
```

Para resolver o problema de incompatibilidade, simplesmente apague as uids do arquivo. Isso força a Godot a buscar as referências e refazer as uids. O arquivo editado deve ficar assim:

```
[gd_scene load_steps=2 format=3]

[ext_resource type="Script" path="res://label.gd" id="1_wtcfe"]

[node name="Node2D" type="Node2D"]

[node name="Label" type="Label" parent="."]
offset_left = 149.0
offset_top = 277.0
offset_right = 1026.0
offset_bottom = 387.0
theme_override_font_sizes/font_size = 80
text = "Exporting for Windows"
script = ExtResource("1_wtcfe")

[node name="Timer" type="Timer" parent="."]
autostart = true

[connection signal="timeout" from="Timer" to="Label" method="_on_timer_timeout"]
```
