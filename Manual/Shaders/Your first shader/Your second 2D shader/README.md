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




