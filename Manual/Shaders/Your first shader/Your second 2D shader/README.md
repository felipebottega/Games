# Your second 2D shader

Neste projeto, diversos efeitos de shaders foram testados e colocados num jogo interativo onde você pode alterar os parâmetros e ver em tempo real o que acontece. Diversos conhecimentos adquiridos nos tutoriais anteriores foram utilizados. Iremos dar uma relembrada nestes conhecimentos e discutir como foi feita a implementação dos efeitos no shader.

## Visão geral

Vamos começar pelo fim, já mostrando o jogo pronto. Como podemos ver, ele é constituído de um background, um dropdown dos efeitos (que começa como "Normal", isto é, sem shader aplicado), uma série de parâmetros para serem alterados, e lá embaixo alguns botões para trocar a figura de background.

https://github.com/user-attachments/assets/20034047-c894-4f30-b766-dd53ccc31f87

A árvore de cena em si é simples, um `Node2D` contendo as imagens, o fundo do HUD e o HUD. Como todas as imagens vão interagir com o mesmo shader, basta escrever o código de um arquivo de shader. Para isso, replicamos os passos vistos no tutorial [Your first 2D shader](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Shaders/Your%20first%20shader/Your%20first%202D%20shader#primeiros-passos) para a primeira imagem. Podemos fazer tudo relativo à primeira imagem apenas, e só no fim entramos com as outras.

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/f57fa25f-8168-4712-ade2-58db3077fe3d" />
</p>

## Estrutura geral do shader

Abaixo temos um pseudocódigo com os principais blocos do shader. Basicamente são esses:

-  Declaração do tipo de shader.
-  Declaração de variáveis uniform. A `effect` é um `int` para identificar qual efeito deve ser utilizado. As variáveis `param` são os parâmetros que podem ser modificados para ver como cada efeito se comporta. Todas as variáveis uniform são alteradas no jogo e repassadas para o shader, que atualiza em tempo real.
-  Função de processamento `fragment()`:
    - Declaração de variáveis comuns a vários efeitos.
    - Inicialização de um `switch`, em que cada caso é a escolha de um efeito (determinado pela variável `effect`). Assim que cai um algum dos casos, a função é executada.
    - O último caso do `switch` é o estado "normal", onde nenhum efeito de shader é aplicado.

```glsl
shader_type canvas_item;


uniform int effect;
uniform float param_1 = value_1;
...
uniform float param_m = value_m;


vec4 effect_1(inputs) {
	...
	return output
}

...

vec4 effect_n(inputs) {
	...
	return output
}


void fragment() {
	vec2 uv = UV;
	vec2 center = vec2(0.5, 0.5);
	vec2 diff = uv - center;
	float dist = length(diff);
	vec4 color;
		
	switch(effect) {
		case 0:
			COLOR = effect_1(inputs);
			break;
		...
		case m:
			COLOR = effect_m(inputs);
			break;
		case m+1:
			break;
	}
	
}
```

## Efeitos 

Vamos explicar apenas o primeiro efeito dos que foram utilizados neste projeto. A ideia é entrar em detalhes neste efeito e esperar que isso seja uma porta de entrada para poder entender os outros por conta própria depois.

### Waves

```glsl
vec4 waves(sampler2D tex, vec2 uv) {
	float wave = sin(uv.x * frequency + TIME * speed);
	uv.y += wave * amplitude;
	return texture(tex, uv);
}
```

Note que esta função atualiza apenas a componente $y$ de cada pixel. Portanto, esperamos ver movimentos para cima e para baixo apenas. A fórmula exata da atualização está mostrada abaixo.

$$uv.y = \sin(uv.x \cdot \texttt{frequency} + \texttt{TIME} \cdot \texttt{speed}) \cdot \texttt{amplitude}$$

Supondo que o jogador não mexa nos parâmetros `frequency`, `speed` e `amplitude`, eles podem ser considerados são constantes na fórmula. Deste modo, só o que varia é o tempo e a coordenada $x$. Note que, em um instante `TIME`, a linha horizontal associada a um $y$ fixo só varia com $x$. Em outras palavras, existe variação horizontal dependete de $x$. Por outro lado, se for $x$ fixo e $y$ variando em um mesmo instante `TIME`, temos que todos os valores `uv.y` são iguais. Em outras palavras, todos os pixels de uma coluna sobem ou descem iguais. 

Cada quadrado da figura abaixo representa um pixel. Essa figura ilustra a movimento esperado por essa fórmula.

<p align="center">
	<img width="350" src="https://github.com/user-attachments/assets/67f2a1af-493b-4e2c-acd4-74fcbd2c08ee" />
</p>

Uma vez que o ponto `uv` foi atualizado, isso deve ser repassado para o pixel, em vetor de um `vec4` para atualizar o `COLOR`. A função `texture()` deve receber a textura original (variável `tex`) e o novo ponto `uv`. Essa função retorna o RGB do `uv` da textura. Como a coordenada $y$ foi alterada, isso significa que o retorno `texture(tex, uv)` da função vai retonar um ponto mais acima ou mais abaixo do original. Isso é o comportamento que queremos.

