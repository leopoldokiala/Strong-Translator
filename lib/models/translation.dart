// Constantes de nomes de colunas
String idColumn = 'idColumn';
String sourceTextColumn = 'sourceTextColumn';
String translatedTextColumn = 'translatedTextColumn';
String sourceLangColumn = 'sourceLangColumn';
String targetLangColumn = 'targetLangColumn';

class Translation {
  final int? id;
  final String sourceText;
  final String translatedText;
  final String sourceLang;
  final String targetLang;

  // Construtor padrão
  Translation({
    this.id,
    required this.sourceText,
    required this.translatedText,
    required this.sourceLang,
    required this.targetLang,
  });

  // Construtor a partir de Map
  factory Translation.fromMap(Map<String, dynamic> map) {
    return Translation(
      id: map[idColumn] as int?,
      sourceText: map[sourceTextColumn] as String,
      translatedText: map[translatedTextColumn] as String,
      sourceLang: map[sourceLangColumn] as String,
      targetLang: map[targetLangColumn] as String,
    );
  }

  // Método para converter em Map
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      sourceTextColumn: sourceText,
      translatedTextColumn: translatedText,
      sourceLangColumn: sourceLang,
      targetLangColumn: targetLang,
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  // Método útil para copiar com alterações
  Translation copyWith({
    int? id,
    String? sourceText,
    String? translatedText,
    String? sourceLang,
    String? targetLang,
  }) {
    return Translation(
      id: id ?? this.id,
      sourceText: sourceText ?? this.sourceText,
      translatedText: translatedText ?? this.translatedText,
      sourceLang: sourceLang ?? this.sourceLang,
      targetLang: targetLang ?? this.targetLang,
    );
  }

  @override
  String toString() {
    return 'Translation(id: $id, sourceText: "$sourceText", translatedText: "$translatedText", sourceLang: "$sourceLang", targetLang: "$targetLang")';
  }
}
