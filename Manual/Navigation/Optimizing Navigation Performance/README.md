# Optimizing Navigation Performance

Listamos abaixo algumas para otimizar a performance da navegação no jogo.

1. Prefira usar shapes simples e retas em vez de shapes complexas (muitas arestas) e arredondadas.
2. Fazer bake é bastante custoso, então prefira fazer isso em thread de background. Vimos como fazer isso [nesse tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/Background%20loading).
3. Nunca altere a escala de regiões de navegação, pois isso pode introduzir erros de ponto flutuante e problemas de performance.
4. Evite atualizar ou resetar o caminho de navegação de um agente em todo frame. Você pode ter trigger para realizar ou cálculo novamente ou só calcular periodicamente.
5. Evite calcular o caminhos de todos os agentes no mesmo frame. Separe em grupos e atualize um grupo diferente por frame para evitar sobrecarga.
6. Não crie regiões com um número excessivo de polígonos.
