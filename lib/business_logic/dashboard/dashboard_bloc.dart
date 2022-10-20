import 'package:daily_note/business_logic/dashboard/dashboard_event.dart';
import 'package:daily_note/business_logic/dashboard/dashboard_state.dart';
import 'package:daily_note/locator.dart';
import 'package:daily_note/repo/database-helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(DashboardInitial initialState) : super(initialState) {
    on<DashboardLoaded>(_onDashboardLoaded);
  }

  _onDashboardLoaded(DashboardLoaded event, Emitter<DashboardState> emit) async {
    final count = await getItInstance<DatabaseHelper>().getTodayTotalCount();
    emit(TodayCount(count));
  }
}