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
  <img width="250" src="https://github.com/user-attachments/assets/c15ed063-60ad-44ed-be04-5daf1bb7ee42" />
</p>
