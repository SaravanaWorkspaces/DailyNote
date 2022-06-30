import 'package:equatable/equatable.dart';

class HomeScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeScreenInitialState extends HomeScreenState {}

class ReceiveWordState extends HomeScreenState {
  String word = '';
  ReceiveWordState(this.word);
}
