# 🌍 Flutter Translator App

Um aplicativo de tradução multilíngue desenvolvido com Flutter, oferecendo suporte a entrada por texto e voz, leitura em voz alta, histórico local e tradução offline. Ideal para quem busca praticidade e acessibilidade em múltiplos idiomas.

## ✨ Funcionalidades

### Básicas
- **Entrada de texto**: Campo `TextField` para digitar frases ou palavras.
- **Limpar texto**: Botão para apagar rapidamente o conteúdo digitado (Não a tradução, caso haja).
- **Seleção de idiomas**: `DropdownButton` para escolher idioma de origem e destino.
- **Tradução**: Botão que aciona a API(Package) e exibe o resultado.
- **Copiar tradução**: Permite copiar o texto traduzido para a área de transferência.

### Intermediárias
- **Histórico de traduções**: Armazena localmente as traduções feitas usando `sqflite`.
- **Tela de histórico**: Interface dedicada para visualizar traduções anteriores.
- **Leitura em voz alta**: Utiliza `flutter_tts` para pronunciar o texto traduzido.
- **Entrada por voz**: Com `speech_to_text`, o usuário pode falar em vez de digitar.
- **Interface multilíngue**: Suporte à tradução da interface para diferentes idiomas.
- **Tradução offline**: Compatível com pacotes de idiomas via `google_mlkit_translation`.

## 🛠️ Tecnologias e Pacotes

- **Flutter**: Framework principal.
- **Provider**: Gerenciamento de estado eficiente.
- **google_mlkit_translation**: Tradução online e offline.
- **flutter_tts**: Text-to-Speech para leitura em voz alta.
- **speech_to_text**: Reconhecimento de fala.
- **sqflite**: Armazenamento local do histórico.
- **clipboard**: Copiar texto para a área de transferência.

## 📱 Plataformas Suportadas

- Android

## 📸 Capturas de Tela
Em breve...
//Adicione aqui imagens do app em funcionamento para ilustrar as funcionalidades.

## 🚀 Como Executar

```bash
git clone https://github.com/leopoldokiala/Strong-Translator
cd flutter-translator-app
flutter pub get
flutter run
