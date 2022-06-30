import 'package:daily_note/business_logic/home_screen_state.dart';
import 'package:daily_note/locator.dart';
import 'package:daily_note/service/speech-service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitialState());

  void clickedListenWord() {
    getItInstance<SpeechService>().startListening(onResult: _speechToTextWord);
  }

  void clickedListenMeaning() {
    getItInstance<SpeechService>()
        .startListening(onResult: _speechToTextMeaning);
  }

  void _speechToTextWord(String result) {
    print(result);
    emit(ReceiveWordState(result));
  }

  void _speechToTextMeaning(String result) {
    print(result);
    emit(ReceiveWordState(result));
  }
}
