##### Strong Translator

Um aplicativo de tradução desenvolvido em Flutter, com suporte a múltiplos idiomas, histórico de traduções e conversão de texto em fala (Text-to-Speech).
O app utiliza o Google ML Kit Translation para traduções offline e armazena o histórico no SQLite usando sqflite.

##### Funcionalidades

- Tradução offline entre vários idiomas (Português, Inglês, Francês, Espanhol, Alemão, Italiano, Chinês e Japonês).
- Entrada de texto personalizada com opções de limpar, copiar e ouvir o texto digitado.
- Conversão de texto em fala (TTS) para idiomas suportados.
- Histórico de traduções salvo localmente, com opção de excluir itens.
- Interface moderna com design responsivo e uso de Provider para gerenciamento de estado.

##### Intermediárias
- **Histórico de traduções**: Armazena localmente as traduções feitas usando `sqflite`.
- **Tela de histórico**: Interface dedicada para visualizar traduções anteriores.
- **Leitura em voz alta**: Utiliza `flutter_tts` para pronunciar o texto traduzido.
- **Interface multilíngue**: Suporte à tradução da interface para diferentes idiomas.
- **Tradução offline**: Compatível com pacotes de idiomas via `google_mlkit_translation`.

###### Tecnologias e Pacotes

- Flutter (Dart)
- Provider (gerenciamento de estado)
- Google ML Kit Translation (tradução offline)
- Text-to-Speech
- Sqflite (banco de dados local SQLite)

##### Plataformas Suportadas
- Android

#####
lib/
├── helpers/
│   └── languages_helper.dart   # Suporte a idiomas e mapeamento TTS
├── models/
│   ├── page_manager.dart       # Gerencia páginas e estado do TextField
│   └── translation.dart        # Modelo de tradução
├── screens/
│   ├── base_screen.dart        # Tela principal com BottomNavigationBar
│   ├── traduction/             # Tela de tradução
│   │   └── traduction_screen.dart
│   └── historic/               # Tela de histórico
│       └── historic_screen.dart
├── services/
│   ├── i_services.dart         # Serviços extras (TTS e copiar texto)
│   ├── offline_translator_service.dart # Lógica de tradução offline
│   └── translation_data_base_service.dart # Persistência SQLite
├── widgets/
│   ├── my_app_bar.dart
│   ├── my_button.dart
│   └── my_dropdown_button.dart
└── main.dart                   # Ponto de entrada do app


## 📸 Capturas de Tela

https://github.com/user-attachments/assets/56603b8a-d4b5-4771-8cfd-b1a04e0db4fa

![Screenshot_20250914_000414](https://github.com/user-attachments/assets/ee6e2649-a833-46be-8a23-b674bcf0da96)


##### Como rodar o projeto
# 1. Clone o repositório
- git clone https://github.com/seu-usuario/strong_translator.git
- cd strong_translator
# 2. Instale as dependências
- flutter pub get
# 3. Rode o app
- flutter run


