import 'package:equatable/equatable.dart';
class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class TodayCount extends DashboardState {
  final count;
  TodayCount(this.count);
  @override
  List<Object?> get props => [count];
}

class TodayScore extends DashboardState {
  final testScore;
  TodayScore(this.testScore);
}