import 'package:daily_note/business_logic/word_list_state.dart';
import 'package:daily_note/locator.dart';
import 'package:daily_note/repo/database-helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordListCubit extends Cubit<WordListState> {
  late final DatabaseHelper _databaseHelper;
  WordListCubit({required DatabaseHelper databaseHelper})
      : super(WordListState()) {
    _databaseHelper = getItInstance<DatabaseHelper>();
  }

  void loadWordList() async {
    final wordList = await _databaseHelper.readAllWords();
    if (wordList.isEmpty) {
      emit(WordListEmpty());
    } else {
      emit(WordList(data: wordList));
    }
  }
}
