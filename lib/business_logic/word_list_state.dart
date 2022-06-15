import 'package:equatable/equatable.dart';

import '../model/Word.dart';

class WordListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WordListEmpty extends WordListState {
  @override
  List<Object?> get props => [];
}

class WordList extends WordListState {
  final List<Word> data;
  WordList({required this.data});
}
