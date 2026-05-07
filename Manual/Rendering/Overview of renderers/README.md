# Overview of renderers

Em qualquer engine de jogos, a "renderização" é o ato de se desenhar algo na tela. O método como o desenho é feito depende do  "renderizador" ("renderer" em inglês) utilizado. Na Godot, temos 3 principais renderers: *Forward+*, *Mobile* e *Compatibility*. Já esbarramos com este tópico [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Manual/2D/Rendering/2D%20antialiasing#antialiasing-no-projeto) e [aqui](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Export/Exporting%20for%20the%20Web#lista-de-dicas-para-exportar-jogos-para-a-web).

## Escolhendo o renderizador

Assim que você cria um projeto novo, tem que escolher um renderizador. A escolha do renderizador depende muito do hardware target da sua aplicação.

<p align="center">
  <img width="400" src="https://github.com/user-attachments/assets/ec1cd989-239a-4b01-998e-3d80e2270e97" />
</p>

Escolha *Forward+* se:
  - Você estiver desenvolvendo para desktop.
  - Você tiver hardware relativamente novo.
  - Você estiver desenvolvendo um jogo 3D.
  - Você quiser usar os recursos de renderização mais avançados.

Escolha *Mobile* se:
  - Você estiver desenvolvendo para dispositivos móveis mais recentes, XR para desktop ou desktop.
  - Você estiver desenvolvendo um jogo 3D.
  - Você quiser usar recursos de renderização avançados, sujeitos às limitações do hardware móvel.

Escolha *Compatibility* se:
  - Você estiver desenvolvendo para dispositivos móveis mais antigos, dispositivos desktop mais antigos ou XR independente. O renderizador *Compatibility* oferece suporte à maior variedade de hardware.
  - Você estiver desenvolvendo para a web. Nesse caso, *Compatibility* é a única opção.
  - Você possui hardware antigo. Nesse caso, a opção *Compatibility* é a única escolha.
  - Você está desenvolvendo um jogo 2D ou um jogo 3D que não precisa de recursos avançados de renderização.
  - Você deseja o melhor desempenho possível em todos os dispositivos e não precisa de recursos avançados de renderização.
  
Lembre-se de que cada jogo é único e este é apenas um ponto de partida. Por exemplo, você pode optar por usar o renderizador *Compatibility* mesmo tendo a GPU mais recente, para poder oferecer suporte à maior variedade possível de hardware. Ou pode preferir usar o renderizador *Forward+* para um jogo 2D, para poder usar recursos avançados como shaders de computação.

## Trocando de renderizador 

A escolha do renderizador na criação do projeto não é definitiva, você pode alternar entre renderizadores quando quiser. Para isso, basta ir no canto superior direito da engine e selecionar o outro renderizador. A troca entre renderizadores pode exigir alguns ajustes manuais na sua cena, iluminação e ambiente, já que cada renderizador é diferente. Em geral, a troca entre os renderizadores *Mobile* e *Forward+* exigirá menos ajustes do que a troca entre *Compatibility* e *Forward+* ou *Mobile*.

<p align="center">
  <img width="500" src="https://github.com/user-attachments/assets/c3fe3eb4-b5db-47ee-9bab-ca43b8dbd9d7" />
</p>

## Tabelas comparativas

As tabelas mostradas aqui tem o intuito de fornecer um comparativo rápido e simples entre os renderizadores. Vale ressaltar que existem muitas outras diferenças não explicitadas nestas tabelas. 

### Comparação geral

| Recurso | Compatibilidade | Mobile (Móvel) | Forward+ |
|---|---:|---:|---:|
| Hardware requerido | Hardware mais antigo ou de baixo desempenho. | Hardware mais novo ou de alto desempenho. | Hardware mais novo ou de alto desempenho. |
| Funciona em hardware novo | ✔️ Sim. | ✔️ Sim. | ✔️ Sim. |
| Funciona em hardware antigo e de baixo desempenho | ✔️ Sim. | ✔️ Sim, mas mais lento que Compatibility. | ✔️ Sim, mas o mais lento de todos. |
| Funciona em hardware sem suporte a RenderingDevice | ✔️ Sim. | ❌ Não. | ❌ Não. |
| Plataformas alvo - Desktop | ✔️ Sim. | ✔️ Sim. | ✔️ Sim. |
| Plataformas alvo - Mobile | ✔️ Sim (baixo desempenho). | ✔️ Sim (alto desempenho). | ⚠️ Suportado, mas mal otimizado. Use Mobile ou Compatibility. |
| Plataformas alvo - XR | ✔️ Sim. Recomendado para headsets standalone. | ✔️ Sim. Recomendado para headsets desktop. | ⚠️ Suportado, mas mal otimizado. Use Mobile ou Compatibility. |
| Plataformas alvo - Web | ✔️ Sim. | ❌ Não. | ❌ Não. |
| Jogos 2D | ✔️ Sim. | ✔️ Sim, mas Compatibility geralmente é suficiente para 2D. | ✔️ Sim, mas Compatibility geralmente é suficiente para 2D. |
| Jogos 3D | ✔️ Sim. | ✔️ Sim. | ✔️ Sim. |
| Conjunto de recursos | Recursos 2D e 3D básicos. | A maioria dos recursos de renderização. | Todos os recursos de renderização. |
| Recursos de renderização 2D | ✔️ Sim. | ✔️ Sim. | ✔️ Sim. |
| Recursos 3D básicos | ✔️ Sim. | ✔️ Sim. | ✔️ Sim. |
| Recursos avançados de renderização | ❌ Não. | ⚠️ Sim, limitado pelo hardware móvel. | ✔️ Sim. Todos os recursos suportados. |
| Novos recursos | ⚠️ Alguns novos recursos são adicionados ao Compatibility depois. | ✔️ A maioria dos novos recursos também chega ao Mobile (seguindo o Forward+). | ✔️ Todos os novos recursos chegam primeiro ao Forward+. |
| Custo de renderização | Custo base baixo, mas alto custo ao escalar. | Custo base médio e custo de escalonamento médio. | Maior custo base, e baixo custo ao escalar. |

---

### Luzes e sombras

| Recurso | Compatibilidade | Mobile (Móvel) | Forward+ |
|---|---:|---:|---:|
| Abordagem de iluminação | Forward | Forward | Clustered Forward |
| Máximo de OmniLights | 8 por malha. Pode ser aumentado. | 8 por malha, 256 por view. | 512 por cluster. Pode ser aumentado. |
| Máximo de SpotLights | 8 por malha. Pode ser aumentado. | 8 por malha, 256 por view. | 512 por cluster. Pode ser aumentado. |
| Máximo de DirectionalLights | 8 | 8 | 8 |
| PCSS para OmniLight e SpotLight | ❌ Não suportado. | ✔️ Suportado. | ✔️ Suportado. |
| PCSS para DirectionalLight | ❌ Não suportado. | ❌ Não suportado. | ✔️ Suportado. |
| Texturas projetoras de luz | ❌ Não suportado. | ✔️ Suportado. | ✔️ Suportado. |

---

### Iluminação global

| Recurso | Compatibilidade | Mobile (Móvel) | Forward+ |
|---|---:|---:|---:|
| ReflectionProbe | ✔️ Suportado, 2 por malha. | ✔️ Suportado, 8 por malha. | ✔️ Suportado, ilimitado. |
| LightmapGI | ⚠️ Renderização de lightmaps baked é suportada. Bake exige hardware com suporte a RenderingDevice. | ✔️ Suportado. | ✔️ Suportado. |
| VoxelGI | ❌ Não suportado. | ❌ Não suportado. | ✔️ Suportado. |
| Iluminação indireta em tela (SSIL) | ❌ Não suportado. | ❌ Não suportado. | ✔️ Suportado. |
| SDFGI (Signed Distance Field GI) | ❌ Não suportado. | ❌ Não suportado. | ✔️ Suportado. |

---

### Ambiente e pós-processamento

| Recurso | Compatibilidade | Mobile (Móvel) | Forward+ |
|---|---:|---:|---:|
| Névoa (depth e height) | ✔️ Suportado. | ✔️ Suportado. | ✔️ Suportado. |
| Névoa volumétrica | ❌ Não suportado. | ❌ Não suportado. | ✔️ Suportado. |
| Tonemapping | ✔️ Suportado. | ✔️ Suportado. | ✔️ Suportado. |
| Reflexões em tela (Screen-Space Reflections) | ❌ Não suportado. | ❌ Não suportado. | ✔️ Suportado. |
| Oclusão ambiente em tela (SSAO) | ✔️ Suportado. | ❌ Não suportado. | ✔️ Suportado. |
| Iluminação indireta em tela (SSIL) | ❌ Não suportado. | ❌ Não suportado. | ✔️ Suportado. |
| SDFGI | ❌ Não suportado. | ❌ Não suportado. | ✔️ Suportado. |
| Glow | ✔️ Suportado. | ✔️ Suportado. | ✔️ Suportado. |
| Ajustes (cor/exposição etc.) | ✔️ Suportado. | ✔️ Suportado. | ✔️ Suportado. |
| Pós-processamento customizado com fullscreen quad | ✔️ Suportado. | ✔️ Suportado. | ✔️ Suportado. |
| Pós-processamento customizado com CompositorEffects | ❌ Não suportado. | ✔️ Suportado. | ✔️ Suportado. |

---

### Anti-aliasing

| Recurso | Compatibility | Mobile (Móvel) | Forward+ |
|---|---:|---:|---:|
| MSAA 3D | ✔️ Suportado. | ✔️ Suportado. | ✔️ Suportado. |
| MSAA 2D | ❌ Não suportado. | ✔️ Suportado. | ✔️ Suportado. |
| TAA | ❌ Não suportado. | ❌ Não suportado. | ✔️ Suportado. |
| FSR2 | ❌ Não suportado. | ❌ Não suportado. | ✔️ Suportado. |
| FXAA | ❌ Não suportado. | ✔️ Suportado. | ✔️ Suportado. |
| SSAA | ✔️ Suportado. | ✔️ Suportado. | ✔️ Suportado. |
| Limitador de roughness em tela | ❌ Não suportado. | ✔️ Suportado. | ✔️ Suportado. |

---

### Recursos do StandardMaterial

| Recurso | Compatibility | Mobile (Móvel) | Forward+ |
|---|---:|---:|---:|
| Sub-surface scattering | ❌ Não suportado. | ❌ Não suportado. | ✔️ Suportado. |

---

### Recursos de shader

| Recurso | Compatibility | Mobile (Móvel) | Forward+ |
|---|---:|---:|---:|
| Screen texture | ✔️ Suportado. | ✔️ Suportado. | ✔️ Suportado. |
| Depth texture | ✔️ Suportado. | ✔️ Suportado. | ✔️ Suportado. |
| Buffer Normal/Roughness | ❌ Não suportado. | ❌ Não suportado. | ✔️ Suportado. |
| Compute shaders | ❌ Não suportado. | ⚠️ Suportado, mas com penalidade de performance em dispositivos mais antigos. | ✔️ Suportado. |

---

### Outros recursos

| Recurso | Compatibility | Mobile (Móvel) | Forward+ |
|---|---:|---:|---:|
| Variable rate shading | ❌ Não suportado. | ✔️ Suportado. | ✔️ Suportado. |
| Decals | ❌ Não suportado. | ✔️ Suportado. | ✔️ Suportado. |
| Trilhas de partículas | ❌ Não suportado. | ✔️ Suportado. | ✔️ Suportado. |
| Colisão SDF em partículas | ❌ Não suportado. | ✔️ Suportado. | ✔️ Suportado. |
| Desfoque de profundidade de campo | ❌ Não suportado. | ✔️ Suportado. | ✔️ Suportado. |
| Modos de VSync Adaptive e Mailbox | ❌ Não suportado. | ✔️ Suportado. | ✔️ Suportado. |
| Viewport 2D HDR | ❌ Não suportado. | ✔️ Suportado. | ✔️ Suportado. |
| Acesso ao RenderingDevice | ❌ Não suportado. | ✔️ Suportado. | ✔️ Suportado. |

<p align="center">
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Plugins/Running%20code%20in%20the%20editor">⬅ Anterior</a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://github.com/felipebottega/Games/tree/gh-pages/Manual/Rendering/Using%20Viewports">Próximo ➡</a>
</p>
