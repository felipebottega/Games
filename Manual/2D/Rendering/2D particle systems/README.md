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
- **Lifetime:** Tempo de vida de cada partícula emitida. No fim das contas, a Godot vai emitir $\frac{\text{Amount} \times \text{Amount Ratio}}{\text{Lifetime}}$ partículas por segundo.
- **Speed Scale:** Velocidade do sistema como um todo. Note que isso não aumenta apenas a taxa de emissão das partículas, mas também a velocidade da animação delas.
- **Explosiveness:** É um parâmetro que varia entre 0 e 1. Seu default de 0 significa que as partículas são emitidas a uma taxa constante no tempo. O valor 1 significa que todas são emitidas de uma vez.
- **Randomness:** É um parâmetro que varia entre 0 e 1 também. Controla o momento em que cada partícula é emitida. O default de 0 significa que elas são emitidas deterministicamente em momentos equidistantes, enquanto 1 significa que elas são emitidas em momentos totalmente aleatórios dentro do tempo do ciclo.

### Propriedades avançadas do GPUParticles2D

O que chamamos de "propriedades avançadas" aqui são as propriedades do *Proccess Material*. Para acessá-las, clique no *New ParticleProcessMaterial* que você criou alguns passos atrás. Uma aba com mais propriedades irá se abrir.

<p align="center">
  <img src="https://github.com/user-attachments/assets/404897c4-2899-4dc2-92fd-89ac1dd9d691" width="300">
</p>

- **Lifetime Randomness:** É um parâmetro que varia entre 0 e 1. Controla o tempo de vida de cada partícula. O default de 0 significa que ela vive durante todo o seu tempo de vida, enquanto que o valor de 1 significa que ele pode desaparecer assim que é emitida. Valores mais altas limitam o tempo de vida de modo aleatório.
- **Emission Shape Offset:** Muda a posição da origem da emissão de partículas, em relação as coordenadas locais. Note na figura abaixo que a origem do node está no $(0, 0)$ mas a origem da emissão foi shiftada para $(-10, -20)$ em relação ao node.

  <p align="center">
  <img src="https://github.com/user-attachments/assets/eb6b6d22-85e7-4392-b393-dc5fb056c7fb" width="700">
</p>

