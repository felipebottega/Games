# Logging

Vimos sobre mensagens de output no editor [neste tutorial](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Debug/Output%20panel), mas além disto, a Godot também oferece funcionalidades de log mais avançadas.Veremos as principais neste tutorial.

## Project Settings

Indo em *Project → Project Settings → General → Application → Run* com as configuração avançada, você pode ver algumas opções relacionadas a log. Elas afetam algumas coisas que aparecem nas abas de output do editor.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/9b7638f8-85bb-436a-92cd-5dae8c3bdbe4" />
</p>

- **Disable stdout:** Desativa completamente o log no stdout. 
- **Disable stderr:** Desativa completamente o log no stderr.

Para esclarecer, toda saída do *stdout* (*standard output*) em Godot aparece na aba de output, enquanto que toda saída do *stderr* (*standard error*) aparece na aba de erros dentro da aba de debug.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/7d9cf315-8474-4a0b-8665-0fd9fdd865ce" />
  <img width="900" src="https://github.com/user-attachments/assets/3c5072de-3a31-477e-903e-4a11ff1f699c" />
</p>

Indo em *Project → Project Settings → General → Debug → Settings* com as configuração avançada, você pode ver algumas opções diferentes relacionadas às mensagens de log no editor.

- **Verbose stdout:** Habilita o log detalhado no *stdout*.
- **Print FPS:** Printa os frames por segundo a cada segundo, bem como o status do V-Sync na inicialização (já que ele pode limitar a taxa máxima de frames).
- **Print GPU Profile:** Pinta o log da utilização da GPU a cada segundo, usando a mesma fonte de dados do [Visual Profiler](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Scripting/Core%20features/Debug/Debugger%20panel#visual-profiler).

