# 2D antialiasing

"Antialiasing" é qualquer técnica utilizada para remover o efeito de serrilhado em curvas, seja em 2D ou 3D. Vamos ver aqui o que a Godot tem para oferecer nesse sentido.

## Antialiasing no projeto

A primeira maneira (e mais geral) para aplicar o antialiasing é indo em *Project → Project Settings → General → Rendering → Anti Aliasing*. Daí é só configurar. É bom ressaltar que isso só funcionará nos modos *Forward+* e *Mobile*, não funciona no *Compatibility*. Para entender em mais detalhes como funciona, você pode ler a explicação ao passar o mouse na própria opção do editor ou pode ver [aqui](https://docs.godotengine.org/en/stable/tutorials/2d/2d_antialiasing.html#multisample-antialiasing-msaa).

<p align="center">
  <img src="https://github.com/user-attachments/assets/e41e0368-b76d-4ef2-a662-75fed06e8984" width="900">
</p>

## Antialiasing como propriedade de nodes

Alguns nodes possuem a propriedade configurável do antialiasing. A lista abaixo não é completa, mas tem os principais nodes que possuem antialiasing configurável como propriedade:

- `Line2D`
- `Polygon2D`
- `Font`
- `Style_Box`
- `Text_Server`
- Diversos tipos de métodos *draw* do `CanvasItem`

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Rendering/ParticleProcessMaterial%202D%20Usage">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Rendering/Custom%20drawing%20in%202D#_draw-vs-_queue_draw">Próximo ➡</a>
</p>
