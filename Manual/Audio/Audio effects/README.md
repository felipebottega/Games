# Audio effects

Quando você clica no *Add Effect* de um audio bus, muitas opções de efeito aparecem. O recomendado é testar na prática e buscar conhecer mais sobre o efeito conforme a necessidade surgir. No entanto, vamos deixar uma descrição geral de cada efeito aqui, apenas para referência. Para cada efeito, é importante sempre se atentar ao *Inspector*, pois lá há vários parâmetros para ajustar.

## Lista dos efeitos áudio

- **Amplify:** Amplifica alterações no volume do sinal.
- **BandLimitFilter e BandPass:** Estes são filtros que bloqueiam frequências em torno do ponto de corte. O *BandPass* pode ser usado para simular o som passando por uma linha telefônica antiga ou um megafone. O *BandPass* pode simular o som de um pedal de guitarra wah-wah, como a guitarra em Voodoo Child (Slight Return), de Jimi Hendrix.
- **Capture:** O efeito *Capture* copia os quadros de áudio audio bus em que se encontra para um buffer interno. Isso pode ser usado para capturar dados do microfone ou transmitir áudio pela rede em tempo real.
- **Chorus:** O efeito *Chorus* faz com que uma única amostra de áudio soe como um coro inteiro. Ele faz isso duplicando um sinal e alterando levemente o tempo e o tom de cada duplicata, variando isso ao longo do tempo. Embora o coro seja tradicionalmente usado para vozes, ele pode ser desejável com quase qualquer tipo de som.
- **Compressor:** O *Compressor* de range dinâmico atenua automaticamente (reduz) o nível do sinal quando sua amplitude excede um determinado limite. O nível de atenuação aplicado é proporcional à distância que o áudio de entrada ultrapassa o limite. O parâmetro *Ratio* do *Compressor* controla o grau de atenuação. Uma das principais utilidades de um compressor é reduzir o range dinâmico de sinais com partes muito barulhentas e quietas. Reduzir o range dinâmico de um sinal pode torná-lo mais adequado à mixagem.

> Dica: Se o seu objetivo é evitar que um sinal exceda completamente uma determinada amplitude, em vez de reduzir o range dinâmico do sinal, o efeito *Limiter* (veremos sobre ele daqui a pouco) é provavelmente uma escolha melhor do que um *Compressor* para esse fim. No entanto, aplicar compressão antes de um limitador ainda é uma boa prática.

- **Delay:** O *Delay* essencialmente duplica um sinal e o repete a uma velocidade especificada, com um nível de volume que decai a cada repetição. O delay é ótimo para simular o espaço acústico de um cânion ou de uma sala grande, onde os reflexos sonoros apresentam um atraso significativo entre suas repetições. Isso contrasta com o *Reverb*, que tem um som mais natural. Usar isso em conjunto com o reverb pode criar ambientes com sonoridade muito natural.
- **Distortion:** Efeitos de distorções genéricas. Os principais modos de distorções são: *Clip, ATan, Lofi, Overdrive, Wave Shape*.
- **EQ:** É o equalizador padrão, que tem em programas de tocar música, rádios, etc. Você manipula o quanto cada faixa de frequência tem peso no conjunto.
- **EQ 6, 10, 21:** É a mesma coisa que o *EQ*, mas mudando o número de faixas de frequência que você quer manipular.
- **Filter:** Não deve ser manipulado diretamente. Por enquanto simplesmente evite esse.
- **HardLimiter:** É semelhante ao *Compressor*, mas é menos flexível e projetado para evitar que a amplitude de um sinal exceda um determinado limite de dB. Adicionar um limitador ao Master é uma boa prática, pois oferece uma proteção fácil contra clipping.
- **HighPassFilter:** Corta frequências abaixo de uma frequência de corte específica. O *HighPassFilter* é usado para reduzir os graves de um sinal. Dá para fazer uns efeitos de música de elevador com isso.
- **HighShelfFilter:** Reduz todas as frequências acima de uma frequência de corte específica.
- **Limiter:** Descontinuado. Use o *HardLimiter * no lugar.
- **LowPassFilter:** Corta frequências acima de uma frequência de corte específica e também pode ressoar (aumentar frequências próximas à frequência de corte). Este filtro pode ser usado ​​para simular sons "abafados". Por exemplo, sons subaquáticos, sons bloqueados por paredes ou sons distantes.
- **LowShelfFilter:** Reduz todas as frequências abaixo de uma frequência de corte específica.
- **NotchFilter:** O oposto do *BandPass*, ele remove uma faixa de som do espectro de frequência em uma determinada frequência de corte.
- **Panner:** O *Panner* permite ajustar o equilíbrio estéreo de um sinal entre os canais esquerdo e direito. Fones de ouvido são recomendados para a configuração deste efeito. Ele é bom para manipular ambientes, com sons vindo pela direita ou esquerda do fone.
- **Phaser:** Este efeito é formado pela defasagem de duas duplicatas do mesmo som, de forma que se cancelem de forma interessante. O Phaser produz um som que se move para frente e para trás pelo espectro de áudio e pode ser uma ótima maneira de criar efeitos de ficção científica.
- **PitchShift:** Este efeito permite o ajuste do tom do sinal independentemente de sua velocidade. O *PitchShift* pode ser útil para criar vozes excepcionalmente altas ou graves.
- **Record:** Este efeito permite ao usuário gravar som de um microfone.
- **Reverb:** O *Reverb* simula salas de diferentes tamanhos. Possui parâmetros ajustáveis ​​que podem ser ajustados para obter o som de uma sala específica.
- **SpectrumAnalyzer:** Este efeito não altera o áudio, você o adiciona canais de áudio dos quais deseja uma análise de espectro. Isso pode ser usado para visualização de áudio. Por exemplo, visualizar vozes pode ser uma ótima maneira de chamar a atenção para elas sem apenas aumentar o volume.
- **StereoEnhance:** Este efeito usa alguns algoritmos para melhorar o som estéreo.

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Audio/Audio%20buses">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Audio/Audio%20streams">Próximo ➡</a>
</p>
