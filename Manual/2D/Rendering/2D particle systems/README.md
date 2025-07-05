# 2D particle systems

Para cirar um node de partículas, utilizamos o `GPUParticles2D`. Começamos a nossa cena criando um node raíz `Node2D` com o `GPUParticles2D` como filho. Depois disso, vá em *Inspector → Process Material* e selecione o *New ParticleProcessMaterial* na aba *Process Material*. Após isso já será possível ver uma animação constante de partículas caindo. Este é o default de Godot. Agora que já temos um sistema de partículas em funcionamento, o resto é apenas customizaçãopara obter algum efeito desejado.

<p align="center">
  <img src="https://github.com/user-attachments/assets/3cb102cd-5169-412c-a524-319f009bc044" width="800">
</p>

> PS: Existe o node `CPUParticles2D`, porém ele é mais lento e está em processo de ser descontinuado. Não o utilize.
