# Audio Server

Este tutorial pode ser visto como uma continuação do tutorial [Audio effects](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Audio/Audio%20effects). Uma coisa que faltou tutorial mencionado foi uma descrição de como acessar e manipular objetos de áudio por código. Tm ocasiões em que a música pode alterar de volume ou velocidade, ou algum efeito pode ser ativado dependendo de algum trigger. O ideal para isso é fazer por código ou uma State Machine do `AnimationTree`, mas não queremos deixar as coisas muito complexas agora.

# Atributos do Audio Server

A lista mostrada abaixo não é completa, mas mostra os principais atributos do `Audio Server`. Suponha que existe um `AudioStreamPlayer` na cena. Então aí faz sentido chamar o `Audio Server` por código. É importante ressaltar que o painel de áudio é o mesmo para todos os nodes `AudioStreamPlayer` na cena. 

  - **AudioServer.bus_count:** Número de canais de áudio na cena.
  - **AudioServer.playback_speed_scale:** Velocidade da execução do áudio (default=1).

## Métodos do Audio Server

  - **AudioServer.get_bus_index(bus_name):** Retorna o índice do canal de áudio de nome {bus_name}. Se não existir, retorna -1.
  - **AudioServer.get_bus_name(bus_idx):** Retorna o nome do canal, dado o seu índice. Se não existir, retorna string vazia.
  - **AudioServer.get_bus_volume_db(bus_idx):** Retorna o volume do canal, em dB.
  - **AudioServer.get_bus_effect_count(bus_idx):** Retorna o número de efeitos em um canal.
  - **AudioServer.get_bus_effect(bus_idx, effect_idx):** Retorna o efeito de áudio (objeto) numa posição de um canal de áudio. Se não existir, retorna nulo.
  - **AudioServer.add_bus_effect(bus_idx, audio_effect, effect_idx):** Adiciona o efeito de áudio (objeto) numa posição de um canal de áudio.
  - **AudioServer.remove_bus_effect(bus_idx, effect_idx):** Remove o efeito de áudio (objeto) numa posição de um canal de áudio.

> Atenção: Quando você remove um efeito de áudio, os índices dos efeitos posteriores se atualizam, reduzindo em uma unidade cada.

