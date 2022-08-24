import 'package:daily_note/business_logic/addword/addword_event.dart';
import 'package:daily_note/business_logic/addword/addword_state.dart';
import 'package:daily_note/locator.dart';
import 'package:daily_note/model/Word.dart';
import 'package:daily_note/repo/database-helper.dart';
import 'package:daily_note/service/speech_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddScreenBloc extends Bloc<AddScreenEvent, AddWordState> {
  AddScreenBloc(HomeScreenInitialState initialState) : super(initialState) {
    on<ListenWord>(_onListenWord);
    on<ListenMeaning>(_onListenMeaning);
    on<UpdateWordEvent>(_updateWord);
    on<UpdateMeaningEvent>(_updateMeaning);
    on<AddWord>(_addWord);
  }

  void _onListenWord(ListenWord event, Emitter<AddWordState> emit) async {
    await getItInstance<SpeechService>().startListening(
      resultCallback: (String result) {
        add(UpdateWordEvent(result));
      },
    );
  }

  void _onListenMeaning(
      ListenMeaning event, Emitter<AddWordState> emit) async {
    await getItInstance<SpeechService>().startListening(
      resultCallback: (String result) {
        add(UpdateMeaningEvent(result));
      },
    );
  }

  void _updateWord(UpdateWordEvent event, Emitter<AddWordState> emit) {
    emit(UpdateWord(event.word));
  }

  void _updateMeaning(UpdateMeaningEvent event, Emitter<AddWordState> emit) {
    emit(UpdateMeaning(event.word));
  }

  void _addWord(AddWord event, Emitter<AddWordState> emit) async {
    try {
      await getItInstance<DatabaseHelper>()
          .create(Word(word: event.word, meaning: event.meaning));
      emit(WordAdded());
    } catch (e) {
      emit(WordFailed(e.toString()));
    }
  }
}
