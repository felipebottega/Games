# Using the ObjectDB profiler

O *ObjectDB* é o sistema interno da Godot que mantém um registro global de todos os objetos vivos na memória durante a execução. O *ObjectDB Profiler* da Godot serve para tirar "snapshots" do ObjectDB da Godot e comparar esses estados para investigar uso de memória, vazamentos e crescimento de objetos durante a execução.

<p align="center">
  <img width="900" src="https://github.com/user-attachments/assets/8b435d38-5c07-4268-aeee-196ac4fc629b" />
</p>

## Como usar

Uma vez que o jogo está sendo executado, vá em *Debugger → ObjectDB Profiler* e clique em *Take ObjectDB Snapshot*. Feito isso, ele já deve aparecer na sua lista. Recomendo renomear, mas evite usar hífen (comigo isso deu bug de um snapshot copiar snapshots prévios).

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/541ceb42-4de0-4257-8f7b-dd6eca8a9a12" />
</p>

A cada execução você pode salvar um novo snapshot. A ideia desta aba é salvar o snapshot quando houver mudanças que você quer comparar, pois esta aba permite fazer diff do projeto em momentos distintos.

## 
