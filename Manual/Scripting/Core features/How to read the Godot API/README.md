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

E outros scripts começarem a usar `MathUtils.somar(2, 3)`, agora vocÊ criou uma API, mesmo sendo simples. 

Para finalizar, vale lembrar que API não é apenas composta de funções, mas também classes, atributos, etc.
