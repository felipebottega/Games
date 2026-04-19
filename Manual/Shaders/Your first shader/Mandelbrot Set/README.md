# Mandelbrot Set

Este é o projeto final para solidificar o conhecimento básico (ou intermediário) de shaders. Depois disso o foco volta a ser as funcionalidades da Godot. Implementar o conjunto de Mandelbrot é importante para confirmar o entendimento da manipulação do sistema UV.

A estrutura da árvore á análoga a utilizada no [Game of Life](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Game%20of%20Life), um `SubViewportContainer` contendo um `SubViewport` contendo um `ColorRect`. O `CanvasLayer` é apenas para mostrar UI. Uma diferença relevante é que aqui não teremos `Camera2D`. No tutorial do Game of Life, bastou renderizar tudo até um pixel de detalhe, pois se tratava de um objeto discretizado por pixel. Aqui temos um objeto que varia continuamente eque requer muito mais detalhe além de um pixel. A renderização total do objeto não é possível em uma única passagem, ela deve ser refeita a cada zoom aplicado. 

> PS: Dar zoom com a câmera e mandar renderizar novamente não funcionaria, pois o zoom da câmera é apenas uma amplicação da imagem, então há perda de resolução. O zoom mencionado é de outra natureza. O importante é que não há perda de resolução neste outro zoom. Veremos isso a seguir.

## 
