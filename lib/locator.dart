import 'package:daily_note/business_logic/homescreen/home_screen_bloc.dart';
import 'package:daily_note/business_logic/homescreen/home_screen_state.dart';
import 'package:daily_note/business_logic/word_list/word_list_screen_bloc.dart';
import 'package:daily_note/business_logic/word_list/word_list_state.dart';
import 'package:daily_note/repo/database-helper.dart';
import 'package:daily_note/service/speech_service.dart';
import 'package:get_it/get_it.dart';

final getItInstance = GetIt.I;

Future<dynamic> init() async {
  getItInstance.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  getItInstance.registerFactory<HomeScreenBloc>(
      () => HomeScreenBloc(HomeScreenInitialState()));

  getItInstance.registerFactory<WordListScreenBloc>(
      () => WordListScreenBloc(WordListInitial()));

  getItInstance.registerFactory(() => SpeechService());
}
