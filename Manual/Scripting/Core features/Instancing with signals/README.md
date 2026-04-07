# Instancing with signals

Neste tutorial, iremos aprender a maneira adequada de se usar sinais para instanciar objetos. O maior desafio disso é decidir "quem" vai instanciar os objetos. Por exemplo, se você tiver um personagem que atira pedra quando o usuário clica o mouse, então é o clique do mouse que ativa o sinal de atirar pedra. Este sinal faz alguma função ser executada, e ela deve incluir um `add_child` da pedra. Talvez o primeiro impulso seja o de colocar o sinal e a função sinal no próprio personagem. Isso implicaria que a pedra é um node filho do personagem. Logo, se ele se mover ou rotacionar, a pedra fará o mesmo. Isso não deve acontecer. Assim que a pedra é atirada, ela deve ser independente do personagem.

