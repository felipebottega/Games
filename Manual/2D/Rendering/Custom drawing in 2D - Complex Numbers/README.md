# Complex Numbers

Uma coisa que eu sempre tive vontade de ter foi um aplicativo para visualizar de maneira interativa (e em tempo real) as raízes dos [polinômios de Littlewood](https://en.wikipedia.org/wiki/Littlewood_polynomial). Agora com o que sei de Godot isso é possível. O intuito deste texto não é detalhar todo o processo, mas apenas os aprendizados novos que adquiri com este projeto.

## Boot Splash 

Boot Splash (ou Boot Splash Screen) é uma tela de carregamento exibida durante a inicialização de um sistema operacional ou de um programa, geralmente antes da interface gráfica principal ser carregada. Na Godot o default é aparecer o logo da Godot e o nome "Godot Engine". É possível customizar isso e colocar o que você quiser, basta ir em *Project Settings → Application → Boot Splash*. Ativando as opções avançadas você consegue controlar o tempo mínimo de exibição. Para este projeto, eu gerei um logo baseado no símbolo da integral de uma função, $\int f(x)\ dx$ e deixei para ficar na tela por pelo menos 1 segundo ($1000$ ms).

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/f72916be-d551-401b-8bf7-1ce61501a358" />
  <img width="400" src="https://github.com/user-attachments/assets/44bc8d7c-83ab-4c1c-ad3d-72c1d04f4830" />
</p>
