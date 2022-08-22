import 'package:equatable/equatable.dart';

class HomeScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeScreenInitialState extends HomeScreenState {
  HomeScreenInitialState(): super();
}

class UpdateWord extends HomeScreenState {
  final String? word;
  UpdateWord(this.word);
  @override
  List<Object?> get props => [word];
}

class UpdateMeaning extends HomeScreenState {
  final String? word;
  UpdateMeaning(this.word);
  @override
  List<Object?> get props => [word];
}

class WordAdded extends HomeScreenState {}

class WordFailed extends HomeScreenState {
  final String message;
  WordFailed(this.message);
}

