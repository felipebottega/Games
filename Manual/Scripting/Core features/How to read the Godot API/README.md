# How to read the Godot API

O propósito deste tutorial é ensinar como navegar na documentação de classes da Godot. Para quem já tem experiência lendo documentações, este tutorial não oferece nenhuma novidade.

## O que é API?

Antes mesmo de começar a explicar sobre a documentação, precisamos do entendimento básico. Vamos começar entendendo o que é uma API. 

De maneira simplificada, API é a interface que permite um código conversar com outro código. Quando você chama a função `move_and_slide()`, por exemplo, isso é API. No seu código, você usou uma função sem saber como foi ela implementada. Foi o seu código de GDScript conversando com outro código interno (a implementação de `move_and_slide()`). A "interface" é a própria função neste caso. 

É importante ressaltar que não é qualquer função escrita em código que faz parte de uma API automaticamente. O que define é se ela foi feita só para uso interno ou se foi feita para ser usado por outros códigos. Se a função está só no seu script e não foi pensada para ser usada por outros sistemas, então é só uma função comum, não uma API. Por exemplo, a função solta abaixo não é uma API.

```python
func somar(a, b):
    return a + b
```

Por outro lado, se você fizer isso:

```python
# math_utils.gd
func somar(a, b):
    return a + b
```

E outros scripts começarem a usar `MathUtils.somar(2, 3)`, agora você criou uma API, mesmo sendo simples. 

Para finalizar, vale lembrar que API não é apenas composta de funções, mas também classes, atributos, etc.

## Como ler a API da Godot

O que eles chamam de "API da Godot" neste contexto é a documentação da API, não a API em si. Você pode acessar essa documentação indo em *class reference* na [documentação oficial](https://docs.godotengine.org/en/stable/index.html) ou no *search help* do editor. 

<p align="center">
    <img width="400" src="https://github.com/user-attachments/assets/fb3b95b0-57cd-4ddd-91a0-3cc2023fae8e" />
</p>

Segue abaixo a estrutura geral da documentação de uma classe.

> # NomeDaClasse
>
> **Inherits:** ClassePai < ClassePaiDoPai < ClassePaiDoPaiDoPai < ...
>
> **Inherited By:** ClasseFilha1, ClasseFilha2, ClasseFilha3, ...
>
> > Breve descrição da classe em uma linha.
>
> ---
>
> ## Description
>
> Descrição detalhada da classe.
>
> Explique:
> - O que a classe representa
> - Como ela funciona
> - Quando usar
> - Relação com outras classes
>
> ---
>
> ## Tutorials
>
> - Tutorial ou guia relacionado
> - Exemplo de uso
>
> ---
>
> ## Properties
>
> | Tipo | Nome | Default |
> |------|------|---------|
> | int  | `propriedade_1` | `0` |
> | bool | `propriedade_2` | `false` |
>
> ---
>
> ## Methods
>
> | Retorno | Método |
> |--------|--------|
> | void   | `metodo_1()` |
> | int    | `metodo_2(param)` |
>
> ---
>
> ## Signals
>
> | Sinal |
> |------|
> | `sinal_1()` |
> | `sinal_2(valor)` |
>
> ---
>
> ## Property Descriptions
>
> ### `propriedade_1: int`
>
> Descrição detalhada.
>
> **Setter:**
> - `set_propriedade_1(valor: int)`
>
> **Getter:**
> - `get_propriedade_1() -> int`
>
> ---
>
> ### `propriedade_2: bool`
>
> Descrição detalhada.
>
> ---
>
> ## Method Descriptions
>
> ### `metodo_1() -> void`
>
> Descrição detalhada do método.
>
> ---
>
> ### `metodo_2(param: int) -> int`
>
> Descrição detalhada do método.
>
> **Parâmetros:**
> - `param` (int): descrição
>
> **Retorno:**
> - int: descrição
>
> ---
>
> ## Signal Descriptions
>
> ### `sinal_1()`
>
> Descrição detalhada do sinal.
>
> ---
>
> ### `sinal_2(valor: int)`
>
> Descrição detalhada do sinal.
>
> ---
>
> ## Notes
>
> - Observações importantes
> - Comportamentos específicos
> - Limitações
>
> ---
>
> ## Examples
>
> ```gdscript
> var obj = NomeDaClasse.new()
> obj.metodo_1()
> ```

- **NomeDaClasse:** Este é o nome da classe (ex: `Node2D`, `Sprite2D`, `CanvasItem`, etc.). É o que você usa no código para criar ou referenciar essa classe.

- **Inherits:** Mostra de qual classe ela herda, incluindo toda a cadeia (ex: `ClassePai < ClassePaiDoPai < ...`). Isso indica quais funcionalidades ela já possui por herança.

- **Inherited By:** Lista as classes que herdam desta. Ou seja, classes mais específicas que usam essa como base.

- **Breve descrição:** Um resumo curto (geralmente uma frase) explicando rapidamente o que a classe faz.

- **Description:** Uma explicação mais completa da classe. Aqui você entende o propósito, como ela funciona e quando usar.

- **Tutorials:** Links ou referências para guias práticos que mostram como usar a classe na prática.

- **Properties:** Lista das variáveis/propriedades da classe. São os valores que você pode ler ou modificar (ex: posição, velocidade, visibilidade).

- **Methods:** Lista das funções disponíveis na classe. São as ações que você pode executar (ex: mover, calcular, atualizar).

- **Signals:** Lista dos sinais (eventos) que a classe pode emitir. Você pode conectar funções a eles para reagir a acontecimentos.

- **Property Descriptions:** Explicações detalhadas de cada propriedade. Inclui comportamento, valores padrão e, às vezes, getter/setter.

- **Method Descriptions:** Explicações detalhadas de cada método. Inclui parâmetros, retorno e o que exatamente o método faz.

- **Signal Descriptions:** Explicações detalhadas de cada sinal. Mostra quando ele é emitido e o que significa.

- **Notes:** Observações importantes, limitações ou comportamentos que não são óbvios.

- **Examples:** Exemplos de código mostrando como usar a classe na prática.
