# Internationalizing games

Vimos um pouco sobre linguagens no tutorial [Importing translations](https://github.com/felipebottega/Games/tree/gh-pages/Manual/Assets%20pipeline/Importing%20translations). Agora chegou a hora de aprofundar neste tópico. Faremos isso através de um exemplo prático que pode ser encontrado [neste link](https://godotengine.org/asset-library/asset/2776).

## Assets 

A ideia deste projeto é fazer uma tela interativa para selecionar linguagens e ouvir áudios da mesma frase em três línguas. Começamos colocando todos os assets na mesma pasta. Teremos as bandeiras dos respectivos países, os arquivos de áudio e o csv explicado no tutorial mencionado anteriormente.

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/9e060bfe-9e22-4056-923e-0e8aadaa5645" />
  <img width="600" src="https://github.com/user-attachments/assets/0b1f0e97-dc3f-452d-9abc-5d50ce57dd83" />
</p>

Ao import o arquivo csv com as traduções, a engine deve criar automaticamente os arquivo de extensão *translation*. Cada um corresponde a uma coluna do csv, que é uma das linguagens. Se certifique de que isso ocorreu antes de prosseguir.

<p align="center">
  <img width="200" src="https://github.com/user-attachments/assets/1cc49f8c-c2fe-4a8e-964d-6bd5c2a3a182" />
</p>

Depois do import do csv ter sido efetuado, vá em *Project Settings → Localization → Translations* e importe todos os arquivos de extensão *translation*. 

<p align="center">
  <img width="850" src="https://github.com/user-attachments/assets/0d3d306e-d925-450d-ac7b-3af008a2678f" />
</p>

## Nodes da cena

A maioria dos nodes da cena já são conhecidos: `Button`, `Label` e `AudioStreamPlayer`. As novidades são o uso do `HSeparator` e o `TextureRect`. O primeiro é simples, é apenas uma linha horizontal na cena, como podemos ver abaixo. 

<p align="center">
  <img width="800" src="https://github.com/user-attachments/assets/5d174913-2a02-4fc8-8193-e7d0a3b8f61f" />
</p>

Note que adicionamos um ícone ao node de áudio, que é um `Button`. 

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/1c3839f1-de13-4e60-a7d3-5f86efcb9bc7" />
  <img width="180" src="https://github.com/user-attachments/assets/ffe3f4fa-d7f2-4f81-8b25-de9e3f97dc6a" />
</p>

## Script inicial


