import 'package:equatable/equatable.dart';

class AddWordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeScreenInitialState extends AddWordState {
  HomeScreenInitialState(): super();
}

class UpdateWord extends AddWordState {
  final String? word;
  UpdateWord(this.word);
  @override
  List<Object?> get props => [word];
}

class UpdateMeaning extends AddWordState {
  final String? word;
  UpdateMeaning(this.word);
  @override
  List<Object?> get props => [word];
}

class WordAdded extends AddWordState {}

class WordFailed extends AddWordState {
  final String message;
  WordFailed(this.message);
}

