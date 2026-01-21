# Optimization using Servers

Godot é uma engine ótima para rápido e fácil desenvolvimento, com o seu sistema de nodes e cenas. Porém, toda essa facilidade possui os seus trade-offs: mais camadas de complexidade, mais uso de memória, menos performance, não tem como paralelizar com threads, entre outros. Isso por si só não é um grande problema, pois a Godot é otimizada e funcionará bem na maioria dos casos. Ainda assim, em situações extremas o approach normal da engine pode sofrer.

## Servidores

Todo o sistema de nodes e cenas da Godot na verdade é opcional, pois por trás dos panos, tudo é feito através de servidores internos da engine. Estes servidores são APIs de baixo nível que servem para controlar a renderização, física, sons, navegação, etc, basicamente tudo que a Godot faz. A dinâmica é a mesma que foi explicada no [tutorial de servidores de navegação](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Navigation/Using%20NavigationServer), o sistema de nodes e cenas é uma interface/frontend para o que acontece nos servidores/backend. 

Iremos ver neste tutorial como interagir diretamente com os servidores, pulando totalmente qualquer necessidade de criar nodes ou cenas. Começamos listando os servidores que a Godot possui.

  - [**RenderingServer:**](https://docs.godotengine.org/en/stable/classes/class_renderingserver.html) API de baixo nível para tudo que é visível (criacao de meshes, cenas de render, etc.). Útil para contornar o sistema de Nodes quando você precisa de muito desempenho.
  - **DisplayServer:** Gerencia janelas, monitores e tudo relacionado à apresentação/gestão de display (separado do OS).
  - **PhysicsServer3D:** física 3D de baixo nível: espaços, corpos, formas, juntas, consultas de colisão.
  - **PhysicsServer2D:** equivalente 2D da PhysicsServer3D (espaços 2D, shapes, corpos, queries).
  - **AudioServer:** servidor de áudio de baixo nível: criação e reprodução de samples/voices, roteamento básico.
  - **NavigationServer3D:** navegação/pathfinding 3D: mapas, regiões, agentes, cálculo de rotas/evitação.
  - **NavigationServer2D:** navegação/pathfinding 2D (mesma ideia do 3D, adaptado a 2D).
  - **XRServer:** servidor central para AR/VR (descoberta de interfaces, trackers, HMD/controllers etc.).
  - **TranslationServer:** gerenciamento central de traduções/localização.
  - **TextServer:** backend para fontes e renderização/medição de texto (HarfBuzz/ICU implementations).
  - **CameraServer:** gerencia câmeras físicas/feeds (webcams / câmeras do dispositivo), usado por módulos XR.
