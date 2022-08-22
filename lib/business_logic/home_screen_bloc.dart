import 'package:daily_note/business_logic/home_screen_event.dart';
import 'package:daily_note/business_logic/home_screen_state.dart';
import 'package:daily_note/locator.dart';
import 'package:daily_note/model/Word.dart';
import 'package:daily_note/service/speech-service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/database-helper.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc(HomeScreenInitialState initialState) : super(initialState) {
    on<ListenWord>(_onListenWord);
    on<ListenMeaning>(_onListenMeaning);
    on<UpdateWordEvent>(_updateWord);
    on<UpdateMeaningEvent>(_updateMeaning);
    on<AddWord>(_addWord);
  }

  void _onListenWord(ListenWord event, Emitter<HomeScreenState> emit) async {
    await getItInstance<SpeechService>().startListening(
      resultCallback: (String result) {
        add(UpdateWordEvent(result));
      },
    );
  }

  void _onListenMeaning(
      ListenMeaning event, Emitter<HomeScreenState> emit) async {
    await getItInstance<SpeechService>().startListening(
      resultCallback: (String result) {
        add(UpdateMeaningEvent(result));
      },
    );
  }

  void _updateWord(UpdateWordEvent event, Emitter<HomeScreenState> emit) {
    emit(UpdateWord(event.word));
  }

  void _updateMeaning(UpdateMeaningEvent event, Emitter<HomeScreenState> emit) {
    emit(UpdateMeaning(event.word));
  }

  void _addWord(AddWord event, Emitter<HomeScreenState> emit) async {
    try {
      await getItInstance<DatabaseHelper>()
          .create(Word(word: event.word, meaning: event.meaning));
      emit(WordAdded());
    } catch (e) {
      emit(WordFailed(e.toString()));
    }
  }
}
