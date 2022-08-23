import 'package:daily_note/business_logic/word_list/word_list_event.dart';
import 'package:daily_note/business_logic/word_list/word_list_state.dart';
import 'package:daily_note/locator.dart';
import 'package:daily_note/repo/database-helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordListScreenBloc
    extends Bloc<WordListScreenEvent, WordListScreenState> {
  WordListScreenBloc(WordListInitial initialState) : super(initialState) {
    on<GetWordList>(_loadWordList);
  }

  void _loadWordList(
      GetWordList event, Emitter<WordListScreenState> emit) async {
    emit(LoadingList());
    try {
      final db = getItInstance<DatabaseHelper>();
      final list = await db.readAllWords();
      if (list.isEmpty) {
        emit(WordListEmpty());
      } else {
        emit(LoadWordList(list));
      }
    } catch (e) {
      emit(LoadWordFailed("Loading list failed"));
    }
  }
}
