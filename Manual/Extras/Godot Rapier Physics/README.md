# Godot Rapier Physics

No [tutorial de engines físicas](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Physics/Physics%20engines) nós vimos como adicionar uma nova engine física ao seu projeto. Vamos fazer o passo a passo na prática aqui. 

Primeiramente, crie o seu projeto e crie uma pasta chamada *addons* dentro da pasta do projeto. O segundo passo é baixar a engine física que você quer utilizar. É possível fazer isso através da aba *AssetLib* que já faz parte da Godot.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/85690ff7-f923-4a35-880a-92a9d53dba3a" />
</p>

Para este exemplo, prefiro baixar diretamente do repositório oficial, pois assim tenho certeza de que estou com a versão mais atual. Acesse os downloads mais recentes em [https://github.com/appsinacup/godot-rapier-physics/releases](https://github.com/appsinacup/godot-rapier-physics/releases). Para este exemplo, vamos escolher o *godot-rapier-2d-single-simd-parallel.zip*. Copie a pasta *godot-rapier2d* e a cole dentro da pasta *addons* do seu projeto.

<p align="center">
  <img width="750" src="https://github.com/user-attachments/assets/38a85a44-656a-4ddf-b46f-3b8959981002" />
</p>

Feito isso, vá para *Project → Project Settings → General → Physics → 2D (3D) → Physics Engine* e a opção *Rapier 2D* deve estar lá para ser selecionada. É necessário reiniciar a engine após selecionar.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/86ce4f66-0291-4764-b9da-116ed8615566" />
</p>

## Criando uma partícula de fluído com Rapier

Rapier é uma engine física bastante completa, mas o nosso foco aqui será mostrar o que ela faz que a engine física da Godot não faz: simulação de fluídos. Note que nós baixamos o Rapier 2D, que é uma engine apenas para a física 2D. 

Para começar, crie uma cena com o node raíz `Node2D` e adicione o node filho `Fluid2D`. Este node não existe na Godot default, é próprio do Rapier 2D.

<p align="center">
  <img width="600" src="https://github.com/user-attachments/assets/10c5e9d5-a600-4b62-891c-3491acf54ae8" />
</p>

No *Inspector*, marque a opção *Debug Draw*, assim você será capaz de ver a renderização das partículas de fluído enquanto edita. Feito isso, clique em *Points* e depois *Add* para adicionar uma partícula. Apenas com isso você já tem uma cena que pode rodar. Porém, ela não tem muita graça, é apenas uma partícula de fluído caindo a partir da origem.

<p align="center">
  <img width="300" src="https://github.com/user-attachments/assets/c01c2eef-0b6e-4248-85a3-f3ac39ce1b03" />
  <img width="300" src="https://github.com/user-attachments/assets/e0693ec3-57ed-4df4-a7e0-2c4015cb7f41" />
</p>

## Criando várias partículas de fluído com Rapier

A maneira mais óbvia de criar várias partículas é indo no *Add* várias vezes e ir adicionando uma a uma, alterando a coordenada inicial de cada uma delas. Apesar de simples, esse approach não escala bem, fora que é tedioso ficar adicionando uma a uma. Vamos ver como fazer isso com código. 

Comece adicionando um script ao node `Fluid2D`. Depois coloque o node mais no centro da tela, adicione um chão como `StaticBody2D` e teste o código simples mostrado abaixo.

<table align="center">
  <tr>
    <td valign="top">
      <img width="700" src="https://github.com/user-attachments/assets/1416c0c9-d3b2-4620-ada9-61480b866844" />
    </td>
    <td valign="top">
      <img width="350" src="https://github.com/user-attachments/assets/80dc6a08-b050-471d-aa8d-3c1183f4275f" />
    </td>
  </tr>  
</table>

https://github.com/user-attachments/assets/881308e9-9556-46df-a52a-500cb4bd8486

## Tamanho das partículas

Como você deve ter notado, as partículas são grandes. Deixar o raio um pouco maior já estoura o limite da tela e nem tem tantas partículas ainda. É possível diminuir o tamanho delas. Para isso, ative o modo avançado do *Project Settings* e vá em *Project → Project Settings → General → Physics → Rapier → Fluid → Fluid Particle Radius 2D*. Apesar dos efeitos serem melhores com partículas menores, há um alto custo de performance. 

https://github.com/user-attachments/assets/b76e84b3-90f5-4388-8478-a6c4a2272d22

https://github.com/user-attachments/assets/6b89b0fd-1871-4d3c-b889-873370b096fb

## Efeitos

O comportamento do fluído não é único. Há diversos efeitos que você pode configurar. 

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/68d9e991-6d7d-4edb-96e9-82b9709012ad" />
</p>

Para adicionar algum efito, vá em  *Inspector → Effects* e clique para adicionar um elemento. Daí clique onde está escrito *empty* e uma lista enorme de opções vai aparecer. Para este exemplo, selecione a opção *FluidEffect2DSurfaceTensionAKINCI*.

<p align="center">
  <img width="1100" src="https://github.com/user-attachments/assets/fbb8a992-2f45-4295-9033-40d8b22f0d34" />
</p>

Para alterar os parâmetros deste efeito, clique no próprio nome do efeito no *Inspector*, isso vai abrir uma caixa com os parâmetros. Ali você pode editar e testar os valores para este efeito. É possível combinar diversos efeitos ao mesmo tempo, basta adicionar outros e ir editando. Além disso, vale a pena testar outros valores de densidade (logo abaixo do *Debug Draw*) juntamente com os efeitos. Recomendo ler o [tutorial oficial](https://godot.rapier.rs/docs/tutorial/create-a-fluid) para ver os exemplos.  

<p align="center">
  <img width="550" src="https://github.com/user-attachments/assets/7a826805-8443-48c7-8690-88acb0483664" />
</p>
