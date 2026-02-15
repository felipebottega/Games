# CharacterBody

Um corpo que realiza detecção de colisões, mas não implementa física. Todos os movimentos e respostas a colisões devem ser implementados em código.

O node `CharacterBody2D` (`CharacterBody3D`) Um corpo que realiza detecção de colisões, mas não implementa física. Todos os movimentos e respostas a colisões devem ser implementados em código. Um `CharacterBody2D` pode ser afetado pela gravidade e outras forças, mas você precisa calcular o movimento no código. Embora isso signifique que você precisa escrever algum código para criar o comportamento deles, também significa que você tem um controle mais preciso sobre como eles se movem e reagem.

Os dois prinicpais métodos do `CharacterBody2D` são o `move_and_collide` e o `move_and_slide`. O segundo já foi utilizado diversas vezes em outros tutoriais e, de fato, ele é o mais prático para implementar a dinâmica de personagens nos jogos. O primeira método, apesar de ser mais genérico, é menos prático e acaba que sua utilidade é mais específica. Por conta disso, a maioria das propriedades e métodos descritas aqui só servem para o `move_and_slide`. Vale a pena lembrar também que estamos descrevendo apenas as principais propriedades e métodos, mas há outras na [documentação oficial](https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html#class-characterbody2d).

## Propriedades

