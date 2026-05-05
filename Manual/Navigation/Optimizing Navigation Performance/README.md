# Optimizing Navigation Performance

## Lista de dicas para otimização de performance da navegação

Listamos abaixo algumas dicas para otimizar a performance da navegação no jogo. Seguindo estas dicas você já evita os gargalos mais comuns e impactantes de navegação.

1. Prefira usar shapes simples e retas em vez de shapes complexas (muitas arestas) e arredondadas.
2. Fazer bake é bastante custoso, então prefira fazer isso em thread de background. Vimos como fazer isso [nesse tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/File%20and%20data%20IO/Background%20loading).
3. Nunca altere a escala de regiões de navegação, pois isso pode introduzir erros de ponto flutuante e problemas de performance.
4. Evite atualizar ou resetar o caminho de navegação de um agente em todo frame. Você pode criar um trigger para realizar o cálculo novamente ou pode só calcular periodicamente.
5. Se tiver muitos agentes, evite calcular o caminhos de todos no mesmo frame. Separe em grupos e atualize um grupo diferente por frame para evitar sobrecarga.
6. Não crie regiões com um número excessivo de polígonos.

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Connecting%20navigation%20meshes">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Networking/Using%20WebSockets">Próximo ➡</a>
</p>
