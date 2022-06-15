import 'package:daily_note/business_logic/add_word_state.dart';
import 'package:daily_note/locator.dart';
import 'package:daily_note/repo/database-helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/Word.dart';

class AddWordCubit extends Cubit<AddWordState> {
  late final DatabaseHelper _databaseHelper;

  AddWordCubit({required DatabaseHelper databaseHelper})
      : super(AddWordState()) {
    _databaseHelper = getItInstance<DatabaseHelper>();
  }

  void addWord(String word, String meaning) async {
    await _databaseHelper.create(Word(word: word, meaning: meaning));
    emit(AddWordSuccess());
  }
}
