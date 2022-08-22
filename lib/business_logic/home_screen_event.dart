import 'package:equatable/equatable.dart';

abstract class HomeScreenEvent extends Equatable {}

class ListenWord extends HomeScreenEvent {
  @override
  List<Object?> get props => [];
}

class ListenMeaning extends HomeScreenEvent {
  @override
  List<Object?> get props => [];
}

class UpdateWordEvent extends HomeScreenEvent {
  final String word;
  UpdateWordEvent(this.word);
  @override
  List<Object?> get props => [];
}

class UpdateMeaningEvent extends HomeScreenEvent {
  final String word;
  UpdateMeaningEvent(this.word);
  @override
  List<Object?> get props => [];
}

class AddWord extends HomeScreenEvent {
  final String word;
  final String meaning;

  AddWord(this.word, this.meaning);
  
  @override
  List<Object?> get props => [word, meaning];
}