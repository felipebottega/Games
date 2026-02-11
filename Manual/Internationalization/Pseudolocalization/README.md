# Pseudolocalization

Diferentes línguas têm comprimentos de texto muito diferentes, uma frase em inglês pode caber fácil, mas em alemão ou russo ou português-brasileiro pode ficar bem maior. A pseudolocalização ajuda a simular cenários que normalmente só se descobrem com a tradução. Muitos problemas de internacionalização custam muito mais caro para consertar se forem detectados tardiamente, especialmente quando o jogo já está em múltiples línguas. Em outras palavras: se você não usar pseudolocalização cedo, corre o risco de que, quando for adicionar a língua X, língua Y, língua Z, e ver que o layout quebra, os textos se sobrepõem, ou o jogo parece bugado, aí vai gastar retrabalho. A pseudolocalização serve como "teste de estresse linguístico".

## Habilitando a pseudolocalização

Habilitar a pseudolocalização é fácil, basta ir em *Project → Project Settings → General → Internationalization → Pseudolocalization* e habilitar a opção *Use Pseudolocalization*. No editor, nada vai mudar, mas ao executar o jogo as simulações vão aparecer.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/cbeae154-51a0-46c2-88bf-e3566c1710b2" />
  <img width="800" src="https://github.com/user-attachments/assets/00309119-a36a-45ad-93f9-98ef3ef815bb" />
  <img width="800" src="https://github.com/user-attachments/assets/27e54adb-4598-4397-84db-69654d4912c3" />
</p>

Agora vamos dar uma olhada nas opções de pseudolocalização.

- **Replace With Accents:** Substitui todos os caracteres na string por suas variantes acentuadas. "The quick brown fox jumped over the lazy dog" será convertido para "Ŧh̀é q́üíćḱ ḅŕôŵή f́ôx́ ǰüm̀ṕéd́ ôṽéŕ ŧh̀é łáźý d́ôǵ" quando esta configuração estiver ativada.
- **Double Vowels:** Duplica todas as vogais na string. É uma boa aproximação para simular a expansão do texto durante a localização. Isso pode ser usado para verificar se o texto ultrapassa os limites do contêiner.
- **Fake Bidi:** Texto bidirecional falso (simula texto da direita para a esquerda). Isso é útil para simular sistemas de escrita da direita para a esquerda e verificar possíveis problemas de formatação que ocorreriam em idiomas que usam escrita da direita para a esquerda.
- **Override:** Substitui todos os caracteres da string por um asterisco (*). Isso é útil para encontrar rapidamente textos que não estão sendo localizados (no sentido de atribuir localidade ao texto).
- **Expansion Ratio:** Pode ser usado em casos onde dobrar as vogais não é uma aproximação suficiente. Essa configuração preenche a string com underscore (_) e a expande pela proporção especificada.
- **Prefix, Suffix:** Essas propriedades podem ser usadas para especificar um prefixo e um sufixo para envolver o texto.
- **Skip Placeholders:** Ignora marcadores de posição para formatação de strings, como *%s* e *%f*. Isso é útil para identificar locais onde mais argumentos são necessários para que a string formatada seja exibida corretamente.
