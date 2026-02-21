# 📚 Desafio: App Flutter – Auxiliar de Alfabetização Infantil

Tipo: Educacional
Público-alvo: Crianças em fase de alfabetização (4–7 anos)
Sem autenticação

## 🎯 Objetivo do App

### Criar um aplicativo simples, visual e interativo para ajudar crianças a aprender:

🔤 Letras (alfabeto)
🔊 Sons das letras
🐶 Associação letra → imagem
✍️ Formação de sílabas
📖 Primeiras palavras
🧩 Estrutura do App
🏠 Tela Inicial

Botões grandes e coloridos

Ícones ilustrados

Navegação simples (ideal para crianças)

## Exemplo de opções:

🔤 Aprender Letras
🔊 Sons das Letras
🧩 Formar Sílabas
📖 Primeiras Palavras
🎮 Joguinhos

# 🔤 Módulo 1 – Aprender Letras

## Funcionalidades:
Mostrar letra grande (A, B, C...)
Imagem associada (A de Abelha 🐝)
Botão para ouvir o som da letra
Animação simples ao tocar

# 🔊 Módulo 2 – Sons das Letras 

## Funcionalidades:
Ao tocar na letra → reproduz áudio
Pode usar:
audioplayers (Flutter)
Feedback visual quando tocar 

# 🧩 Módulo 3 – Formação de Sílabas

## Exemplo:

BA + LA = BALA
Arrastar letras
Botão para ouvir a palavra formada

# Estrutura do App
alfabetizacao_app/
 ├── assets/
 |    ├── audios/
 |    │     ├── dissilabas/
 |    │     ├── letras/
 |    |     |     ├─ A.mp3
 │    |     |     ├─ B.mp3
 │    |     |     └─ ... até Z.mp3
 |    │     ├── monossilabas/
 |    │     ├── polissilabas/
 |    │     └── trissilabas
 |    ├── data/
 |    |     ├── letras.json
 |    |     └── silabas.json
 |    └── images/ 
 |           └──a.png ... até Z.png
 ├── bin/
 │    └── generate_audios.dart   <-- script Dart para TTS
 ├── lib/
 |   ├── models
 |   |      ├── letra_model.dart
 |   |      └── silabas_model.dart
 |   ├── screens/
 |   │     ├── home_screen.dart
 |   │     ├── letras_screen.dart
 |   │     ├── palavras_screen.dart
 |   │     ├── silabas_screen.dart
 |   │     └── jogos_screen.dart
 |   ├── services/
 |   |      ├── letra_service.dart
 |   |      └── silabas_service.dart
 |   ├── widgets/
 |   |      ├── controle_inferiores.dart
 |   └── main.dart
 └─ pubspec.yaml

# Pacotes
audioplayers: ^5.0.0
google_fonts: ^6.0.0
flutter_tts: ^3.8.0