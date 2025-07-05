# 2D particle systems

Para cirar um node de partículas, utilizamos o `GPUParticles2D`. Começamos a nossa cena criando um node raíz `Node2D` com o `GPUParticles2D` como filho. Depois disso, vá em *Inspector → Process Material* e selecione o *New ParticleProcessMaterial* na aba *Process Material*. Após isso já será possível ver uma animação constante de partículas caindo. Este é o default de Godot. Agora que já temos um sistema de partículas em funcionamento, o resto é apenas customizaçãopara obter algum efeito desejado.

<p align="center">
  <img src="https://github.com/user-attachments/assets/3cb102cd-5169-412c-a524-319f009bc044" width="800">
</p>

> PS: Existe o node `CPUParticles2D`, porém ele é mais lento e está em processo de ser descontinuado. Não o utilize.

## Propriedades do GPUParticles2D

Essa lista não é completa, mas cobre as principais propriedades de partíclas.

### Propriedades básicas do GPUParticles2D

- **Amount:** Número base de partículas por ciclo. 
- **Amount Ratio:** Multiplicador do número base de partículas por ciclo, de modo que em cada ciclo teremos $\text{Amount} \times \text{Amount Ratio}$ partículas.
- **Texture:** Arquivo de imagem para ser a aparência das partículas. Veremos mais sobre isso adiante.
- **Time/Lifetime:** Tempo de vida de cada partícula emitida. No fim das contas, a Godot vai emitir $\frac{\text{Amount} \times \text{Amount Ratio}}{\text{Lifetime}}$ partículas por segundo.
- **Time/Speed Scale:** Velocidade do sistema como um todo. Note que isso não aumenta apenas a taxa de emissão das partículas, mas também a velocidade da animação delas.
- **Time/Explosiveness:** É um parâmetro que varia entre 0 e 1. Seu default de 0 significa que as partículas são emitidas a uma taxa constante no tempo. O valor 1 significa que todas são emitidas de uma vez.
- **Time/Randomness:** É um parâmetro que varia entre 0 e 1 também. Controla o momento em que cada partícula é emitida. O default de 0 significa que elas são emitidas deterministicamente em momentos equidistantes, enquanto 1 significa que elas são emitidas em momentos totalmente aleatórios dentro do tempo do ciclo.

### Propriedades avançadas do GPUParticles2D

O que chamamos de "propriedades avançadas" aqui são as propriedades do *Proccess Material*. Para acessá-las, clique no *New ParticleProcessMaterial* que você criou alguns passos atrás. Uma aba com mais propriedades irá se abrir.

<p align="center">
  <img src="https://github.com/user-attachments/assets/404897c4-2899-4dc2-92fd-89ac1dd9d691" width="300">
</p>

- **Lifetime Randomness:** É um parâmetro que varia entre 0 e 1. Controla o tempo de vida de cada partícula. O default de 0 significa que ela vive durante todo o seu tempo de vida, enquanto que o valor de 1 significa que ele pode desaparecer assim que é emitida. Valores mais altas limitam o tempo de vida de modo aleatório.
- **Spawn/Position/Emission Shape Offset:** Muda a posição da origem da emissão de partículas, em relação as coordenadas locais. Note na figura abaixo que a origem do node está no $(0, 0)$ mas a origem da emissão foi shiftada para $(-10, -20)$ em relação ao node.

<p align="center">
  <img src="https://github.com/user-attachments/assets/eb6b6d22-85e7-4392-b393-dc5fb056c7fb" width="700">
</p>

- **Spawn/Position/Emission Shape Scale e Spawn/Position/Emission Shape:** Primeiro você deve escolher e configurar uma opção para o *Emission Shape* e depois definir o ajuste de escala com o *Emission Shape Scale*. O *Emission Shape* define os pontos de ondeas partículas serão emitidas. Por default elas são emitidas a partir de um único ponto, mas podem ser emitidas a partir de pontos dentro de uma esfera, retângulo, anel, entre outros. Vale a pela explorar as possibilidades.

<p align="center">
  <img src="https://github.com/user-attachments/assets/b2c71453-7726-499a-9ee8-cde425502f02" width="800">
</p>

- **Spawn/Velocity/Direction e Spawn/Velocity/Spread e Spawn/Velocity/Flatness e Spawn/Velocity/Initial Velocity:** Primeiro você deve escolher e configurar o *Initial Velocity*. Isso define o range da velocidade inicial com que a partícula é emitida. Por default é 0, o que significa que apenas a gravidade está agindo sobre a partícula. Após definir este range, o *Direction* define o vetor de direção da partícula, *Spread* define uma abertura de ângulo que a partícula pode desviar do vetor de direção, e *Flatness* aplica um fator de encurtamento para o *Spread* (no meu entendimento isso é equivalente a diminuir o *Spread*).

<p align="center">
  <img src="https://github.com/user-attachments/assets/bd4fcea9-8801-4deb-9955-a2a338d961fc" width="700">
</p>

- **Accelerations/Gravity:** A gravidade pode ser manipulada não apenas verticalmente, mas horizontalmente também.
- **Display/Scale:** Controla o tamanho das partículas. Se o mínimo e o máximo forem diferentes, a variação de escala é aleatória. Você pode selecionar a opção *CurveTexture* no parâmetro *Scale Curve*. Com isso você pode determinar como a escala varia com o tempo para cada partícula. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/36a6bfe8-4ad6-41ae-aa97-92424614804d" width="750">
</p>

- **Display/Color Curves/Color:** Altera a cor das partículas.
- **Display/Color Curves/Color Ramp:** Define uma variação de uma cor para outra durante o tempo de vida da partícula. Vale ressaltar que as cores da partícula variam de acordo com a cor do gradiente multiplicado pela cor definda por *Color*. Se quiser que a variação seja exatamente a do gradiente que aparece, deixe *Color* como branco. Abaixo temos um exemplo de aplicação.

<p align="center">
  <img src="https://github.com/user-attachments/assets/9e7da29b-00d5-4015-838a-00e070c1a06c" width="600">
</p>

- **Alpha Curve:** Define a variação de transparência da partícula ao longo do seu tempo de vida. Abaixo temos um exemplo de aplicação.

<p align="center">
  <img src="https://github.com/user-attachments/assets/b43130c7-cfb7-496a-855f-49eac873116f" width="600">
</p>

- **Turbulence/Noise Strength:** Nível da turbulência. Quanto maior, mais turbulento é o sistema das partículas.

  > PS: Para utilizar as opções de turbulência, é necessário selecionar a opção *Enabled* primeiro.

- **Turbulence/Noise Scale:** Valores muito altos fazem com que o sistema como um todo seja afetado pelas mesmas forças, enquanto que valores mais baixos fazem com que as forças aplicadas em cada pequeno espaço sejam apenas locais. Isso é útil quando você quer aplicar um efeito de vento, por exemplo, e as partículas devem reagir em conjunto.
- **Turbulence/Influence:** O nível em que as partículas afetam umas as outras. O valor 0 significa que elas se movem de maneira totalmente independente, enquanto que o valor 1 faz elas basicamente ficarem à espera do que as outras vão fazer.
- **Collision/Mode:** Define como a partícula se comportará ao colidir com algum outro objeto.
- **Collision/Friction:** Nível de fricção da partícula ao colidir com algum outro objeto.
- **Collision/Friction:** Nível do quanto a partícula vai quicar ao colidir com algum outro objeto.

  > PS: 
