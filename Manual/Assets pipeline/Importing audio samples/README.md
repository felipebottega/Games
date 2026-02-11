# Importing audio samples

## Formatos de áudio suportados
A Godot oferece 3 opções para importar seus dados de áudio: WAV, Ogg Vorbis e MP3. 

- **WAV:** Usam dados brutos ou compactação leve. Atualmente, só podem ser importados em formato bruto, mas a Godot permite a compactação após a importação. Eles são leves para reprodução na CPU (centenas de vozes simultâneas neste formato são suficientes). A desvantagem é que ocupam muito espaço em disco.
- **Ogg Vorbis:** Usam uma compactação mais forte, o que resulta em um tamanho de arquivo muito menor, mas exigem significativamente mais poder de processamento para reprodução.
- **MP3:** Usam melhor compactação do que WAV, mas pior do que Ogg Vorbis. Isso significa que um arquivo MP3 com qualidade aproximadamente igual à do Ogg Vorbis será significativamente maior. O lado positivo é que o MP3 requer menos uso da CPU para ser reproduzido em comparação com o Ogg Vorbis.

> Dica: Considere usar WAV para efeitos sonoros curtos e repetitivos, e Ogg Vorbis para música, fala e efeitos sonoros longos. MP3 é útil para projetos mobile e web onde os recursos da CPU são limitados, especialmente ao reproduzir vários sons compactados ao mesmo tempo (como sons ambientes longos).

## Opções de import do WAV

### Force

- **8 bits:** Se habilitado, força o áudio importado a usar a quantização de 8 bits se o arquivo de origem for de 16 bits ou superior. Ativar essa opção geralmente não é recomendado, pois a quantização de 8 bits reduz significativamente a qualidade do áudio. Se precisar de arquivos menores, considere usar áudio Ogg Vorbis ou MP3.
- **Mono:** Se ativado, força o áudio importado a ser mono se o arquivo de origem for estéreo. Isso reduz o tamanho do arquivo em 50%, unindo os dois canais em um.
- **Max Rate:** Se definido com um valor maior que 0, força a redução da taxa de amostragem do áudio para um valor menor ou igual ao valor especificado aqui. Isso pode reduzir significativamente o tamanho do arquivo em determinados sons, sem afetar a qualidade, dependendo do conteúdo do som.

### Edit

- **Trim:** O arquivo de áudio de origem pode conter longos silêncios no início e/ou no final. Ativar o Trim cortará automaticamente o início e o fim do áudio se estiver abaixo de -50 dB após a normalização (veja Editar > Normalizar abaixo). Um período de fade-in/fade-out também é usado durante o corte para evitar estalos audíveis.
- **Normalize:** Se ativado, o volume do áudio será normalizado para que seu pico seja igual a 0 dB. Quando ativado, a normalização tornará o áudio mais alto, dependendo do seu pico de volume original.
- **Loop Mode:** Ao contrário do Ogg Vorbis e do MP3, os arquivos WAV podem conter metadados para indicar se estão em loop (além dos pontos de loop). Por padrão, o Godot seguirá esses metadados, mas você pode optar por aplicar um modo de loop específico:
  - **Disabled:** Não reproduz o áudio em loop, mesmo que os metadados indiquem que o arquivo deve ser reproduzido em loop.
  - **Forward:** Loop de áudio padrão.
  - **Ping-Pong:** Reproduz o áudio para frente até terminar de tocar, depois reproduz para trás e repete. Isso é semelhante à repetição de textura espelhada, mas para áudio.
  - **Backward:** Reproduz o áudio ao contrário e retorna ao final ao terminar de tocar.
   
### Compress/Mode 

- **Disabled/Uncompressed:** Não reduz nada.
- **IMA-ADPC:** Reduz um pouco o tamanho do arquivo e o uso de memória, mas reduz a qualidade de forma audível.
- **QOA (Quite OK Audio):** Reduz o tamanho do arquivo um pouco mais do que a RAM (IMA-ADPCM), e a redução na qualidade é muito menos perceptível, mas aumenta o uso da CPU (ainda muito menor do que o MP3).

<p align="center">
  <img width="220" src="https://github.com/user-attachments/assets/c15ed063-60ad-44ed-be04-5daf1bb7ee42" />
</p>

## Opções de import do Ogg Vorbis e MP3

- **Loop:** Se ativado, o áudio começará a ser reproduzido do início após o término da reprodução. No `AudioStreamPlayer`, o sinal finalizado não será emitido para o áudio em loop quando atingir o final do arquivo de áudio, pois o áudio continuará sendo reproduzido indefinidamente.
- **Loop Offset:** O deslocamento de loop determina onde o áudio começará a ser repetido após a reprodução atingir o final. Isso pode ser usado para repetir apenas uma parte do arquivo de áudio, o que é útil para alguns sons ambientes ou músicas. O valor é determinado em segundos em relação ao início do áudio, portanto, $0$ repetirá todo o arquivo de áudio. Só tem efeito se o *Loop* estiver habilitado. 
- **BPM:** Batidas por minuto da faixa de áudio. Deve corresponder à medida de BPM usada para compor a faixa. Isso é relevante apenas para músicas que desejam usar a funcionalidade musical interativa, não efeitos sonoros.
- **Beat Count:** A contagem de batidas da faixa de áudio. Isso é relevante apenas para músicas que desejam usar a funcionalidade musical interativa, não efeitos sonoros.
- **Bar Beats:** O número de compassos dentro de uma única batida na faixa de áudio. Isso é relevante apenas para músicas que desejam usar a funcionalidade musical interativa, não efeitos sonoros.

<p align="center">
  <img width="220" src="https://github.com/user-attachments/assets/16f47828-5c58-4684-8a23-c810fe171367" />
</p>

## Configurações avançadas de importação (WAV)

Se você clicar duas em um arquivo de áudio WAV pelo *FileSystem*, vão aparecer algumas opções de edição no *Inspector*. É limitado, mas permite aditar algumas coisas sem a necessidade de ter que reimportar o arquivo. Além disso, você pode ouvir o áudio antes de utilizá-lo.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/fbe27703-4b50-4bc9-b9d7-fb8ad5f755e8" />
</p>

## Configurações avançadas de importação (Ogg Vorbis ou MP3)

Se você clicar duas em um arquivo de áudio Ogg Vorbis ou MP3 pelo *FileSystem*, a janela com configurações avançadas de áudio vai abrir. Esta janela permite editar o ponto de loop do áudio com uma prévia em tempo real, além do BPM, da contagem de batidas e dos compassos. Essas três configurações não são utilizadas no momento, mas serão usadas no futuro para suporte a música interativa (o que permite transições suaves entre diferentes faixas de música). Note que várias das opções de import mostradas acima podem ser editadas diretamente nesta janela, sem a necessidade de reimportar o áudio.

<p align="center">
  <img width="380" src="https://github.com/user-attachments/assets/0ef793f4-6dd3-4369-af95-338e2c127b91" />
</p>


