# CharacterBody

Um corpo que realiza detecção de colisões, mas não implementa física. Todos os movimentos e respostas a colisões devem ser implementados em código.

O node `CharacterBody2D` (`CharacterBody3D`) Um corpo que realiza detecção de colisões, mas não implementa física. Todos os movimentos e respostas a colisões devem ser implementados em código. Um `CharacterBody2D` pode ser afetado pela gravidade e outras forças, mas você precisa calcular o movimento no código. Embora isso signifique que você precisa escrever algum código para criar o comportamento deles, também significa que você tem um controle mais preciso sobre como eles se movem e reagem.

Os dois prinicpais métodos do `CharacterBody2D` são o `move_and_collide` e o `move_and_slide`. O segundo já foi utilizado diversas vezes em outros tutoriais e, de fato, ele é o mais prático para implementar a dinâmica de personagens nos jogos. O primeira método, apesar de ser mais genérico, é menos prático e acaba que sua utilidade é mais específica. Por conta disso, a maioria das propriedades e métodos descritas aqui só servem para o `move_and_slide`. Vale a pena lembrar também que estamos descrevendo apenas as principais propriedades e métodos, mas há outras na [documentação oficial](https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html#class-characterbody2d).

## Propriedades

- **Motion Mode:** Define o modo de movimentação para o `move_and_slide`. Os modos são *Grounded* e *Floating*. O modo *Grounded* é para jogos do tipo *side-scrolling* (jogos onde você anda para a direita ou esquerda, como jogos de plataforma). Neste modo as noções de chão, parede e teto existem. Você pode usar os métodos `is_on_floor`, `is_on_wall()` e `is_on_ceiling()` para detectar se o corpo está em contato com algum destes. O modo "Floating" é para jogos *top-down* (jogos com visão de cima para baixo, como os RPGs clássicos). Neste modo tudo é "parede" e os métodos mostrados anteriormente não se aplicam. O método que você pode usar para detectar colisão com paredes é o `on_wall`.
- **Up Direction:** Vetor que define o que é "para cima" para o `move_and_slide` no modo *Grounded*. É a partir deste vetor que os métodos `is_on_floor`, `is_on_wall()` e `is_on_ceiling()` são capazes de reportar onde o corpo se encontra.
- **Slide on Ceiling:** Se estiver habilitada, o corpo desliza pela teto quando o corpo pula e colide no teto. Caso contrário, o corpo para assim que colide com o teto e cai na vertical. Essa propriedade é apenas para o `move_and_slide`. Nos meus testes não fez nenhuma diferença esta propriedade estar habilitada ou não.
- **Floor/Stop on Slope:** 
