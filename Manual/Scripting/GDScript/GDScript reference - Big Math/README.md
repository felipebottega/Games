# Big Math

*Big Math* é o nome de uma classe que implementa as 4 operações básicas (adição, subtração, multiplicação e divisão) para números de tamanhos arbitrários, e com precisão arbitrária. Este projeto é uma aplicação do que vimos de classes no [tutorial de GDScript](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20reference#classes).

## Estrutura

O arquivo começa nomeando a classe, assim ela passa a ser global no projeto. Depois alguns atributos desta classe são definidos, temos uma classe interna `NumberParts` (que não deve ser utilizada diretamente pelo usuário), e por fim temos diversos métodos que foram separados em [regiões de código](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20reference#regi%C3%B5es-de-c%C3%B3digo).

<p align="center">
  <img width="620" src="https://github.com/user-attachments/assets/e82f50ba-1424-4913-a98f-9c714b1c2a6d" />
</p>

Uma vez que a classe está pronta, criamos uma cena para simular uma calculadora. O ponto central desta cena é o trecho de código abaixo. Dados dois números e uma operação, ele cria uma instância da classe e utiliza o método requisitado para obter a resposta da conta. O *setter* é usado para garantir que a conta seja feita apenas quando alguma variável é modificada. Você pode testar a calculadora [neste link](https://felipebottega.github.io/Games/Manual/Scripting/GDScript/GDScript%20reference%20-%20Big%20Math/html/).

<p align="center">
  <img width="520" src="https://github.com/user-attachments/assets/144a24e6-c703-4dfc-a2f0-8f8f3a3afc6a" />
</p>

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20reference">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/GDScript/GDScript%20exported%20properties">Próximo ➡</a>
</p>
