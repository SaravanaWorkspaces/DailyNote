import 'package:daily_note/business_logic/add_word_cubit.dart';
import 'package:daily_note/business_logic/home_screen_bloc.dart';
import 'package:daily_note/business_logic/home_screen_cubit.dart';
import 'package:daily_note/business_logic/home_screen_state.dart';
import 'package:daily_note/business_logic/word_list_cubit.dart';
import 'package:daily_note/repo/database-helper.dart';
import 'package:daily_note/service/speech-service.dart';
import 'package:get_it/get_it.dart';

final getItInstance = GetIt.I;

Future<dynamic> init() async {
  
  getItInstance.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  getItInstance.registerFactory<AddWordCubit>(
      () => AddWordCubit(databaseHelper: getItInstance()));

  getItInstance.registerFactory<HomeScreenCubit>(() => HomeScreenCubit());

  getItInstance.registerFactory<HomeScreenBloc>(() => HomeScreenBloc(HomeScreenInitialState()));

  getItInstance.registerFactory<WordListCubit>(
      () => WordListCubit(databaseHelper: getItInstance()));

  getItInstance.registerFactory(() => SpeechService());
}
