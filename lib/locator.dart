import 'package:daily_note/business_logic/add_word_cubit.dart';
import 'package:daily_note/repo/database-helper.dart';
import 'package:get_it/get_it.dart';

final getItInstance = GetIt.I;

Future<dynamic> init() async {
  getItInstance.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  getItInstance.registerFactory<AddWordCubit>(
      () => AddWordCubit(databaseHelper: getItInstance()));
}
