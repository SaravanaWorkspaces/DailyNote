import 'package:equatable/equatable.dart';

abstract class AddScreenEvent extends Equatable {}

class ListenWord extends AddScreenEvent {
  @override
  List<Object?> get props => [];
}

class ListenMeaning extends AddScreenEvent {
  @override
  List<Object?> get props => [];
}

class UpdateWordEvent extends AddScreenEvent {
  final String word;
  UpdateWordEvent(this.word);
  @override
  List<Object?> get props => [];
}

class UpdateMeaningEvent extends AddScreenEvent {
  final String word;
  UpdateMeaningEvent(this.word);
  @override
  List<Object?> get props => [];
}

class AddWord extends AddScreenEvent {
  final String word;
  final String meaning;

  AddWord(this.word, this.meaning);
  
  @override
  List<Object?> get props => [word, meaning];
}