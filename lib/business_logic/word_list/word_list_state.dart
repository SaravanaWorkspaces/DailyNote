import 'package:daily_note/model/Word.dart';
import 'package:equatable/equatable.dart';

class WordListScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WordListInitial extends WordListScreenState {}

class LoadingList extends WordListScreenState {}
class WordListEmpty extends WordListScreenState {
  @override
  List<Object?> get props => [];
}

class LoadWordList extends WordListScreenState {
  final List<Word> list;
  LoadWordList(this.list);
}

class LoadWordFailed extends WordListScreenState {
  final String message;
  LoadWordFailed(this.message);
}
