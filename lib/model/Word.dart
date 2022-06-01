final String tableWord = "word";

class WordFields {
  static const String id = '_id';
  static const String word = 'word';
  static const String meaning = 'meaning';

  static final List<String> values = [id, word, meaning];
}

class Word {
  final int? id;
  final String word;
  final String meaning;

  const Word({this.id, required this.word, required this.meaning});

  Word copy({int? id, String? word, String? meaning}) => Word(
      id: id ?? this.id,
      word: word ?? this.word,
      meaning: meaning ?? this.meaning);

  Map<String, Object?> toJson() =>
      {WordFields.id: id, WordFields.word: word, WordFields.meaning: meaning};

  static Word fromJson(Map<String, Object?> json) => Word(
    id : json[WordFields.id] as int?,
    word : json[WordFields.word] as String,
    meaning : json[WordFields.meaning] as String
  );
}
