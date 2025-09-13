# Exporting for Windows

## Changing the executable icon

Ao gerar o executável do seu jogo no Windows, o ícone utilizado é o símbolo da Godot <img width="28" src="https://github.com/user-attachments/assets/0a3c6ed7-5dd2-48ef-9d63-a6492b698d50" /> por default. Para alterar issdo, vá em *Project Settings → Application → Config → Icon* e escolha o arquivo do novo ícone. Depois disso, ao exportar o jogo para executável o ícone do arquivo será o que você escolheu.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/5cb1c8d7-7ed1-41c6-9aaa-096e22fa062c" />
  <img width="891" height="684" alt="image" src="https://github.com/user-attachments/assets/eba61d48-641b-493d-926f-cb82e28b86f5" />
</p>

## Copiando cenas entre projetos e problemas com uid

Saindo um pouco do tópico, pois esbarrei nesse problema enquanto trabalhava nesse tutorial. É comum que a engine reclame de uid desconhecida quando você copia diretamente uma cena de um projeto para outro. Na Godot, os arquivos `.tscn` e `.gd` têm um sistema de uids para identificar recursos. Eles não são portáveis entre projetos diferentes — cada projeto tem seu próprio mapeamento. Abaixo temos um exemplo simples de arquivo `.tscn`. 

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
