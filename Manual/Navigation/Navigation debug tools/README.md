# Navigation debug tools

Neste tutorial nós vamos apenas passar rapidamente por algumas ferramentas para ajudar no debug de navegação.

## Habilitando debug de navegação

A coisa mais óbvia que você pode fazer é ir na aba *Debug* e selecionar *Visible Navigation*. Com isso é possível visualizar as regiões de navegação enquanto se está editando o jogo.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/033f1415-d276-4ff9-97ec-093f4bbdd510" />
</p>

## Navigation debug settings

No *Project Settings*, habilite o modo avançado e vá em *Debug → Shapes*. Ali você tem diversas opções para customizar a visulização enquanto está debugando. Vale a pena conferir.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/843a6df3-f8cc-4202-bd88-d9a7e7f22ea2" />
</p>

## Debug performance

Você pode monitorar em tempo real o custo computacional dos processos de navegação. Esse monitoramento leva muita coisa em consideração, mas não leva em consideração o cálculo dos caminhos. Isso quer dizer que um pico de custo causado por muitas consultas de caminho não vai aparecer naquele monitor. O tempo gasto com essas consultas pode impactar seu jogo, mas não vai aparecer na seção *Navigation Process* do profiler.

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/fe0eb177-2d56-4e28-908e-5a8be8892ed8" />
</p>

Apesar do cálculo de caminhos não aparecer no profiler, existem algumas estatísticas que podem ajudar a encontrar gargalos nestes cálculos, ainda que indiretamente. Por exemplo, se a quantidade de polígonos for muito alta, isto será custoso para o cálculo de caminhos. 

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/490f0f6d-e5fd-4dd7-9005-3694268b6483" />
</p>
