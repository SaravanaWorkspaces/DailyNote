import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  late final SpeechToText _speechToText;

  SpeechService() {
    _speechToText = SpeechToText();
    _speechToText.initialize(
        onError: _speechErrorListener, onStatus: _speechStatusListner);
  }

  startListening({required onResult}) async {
    await _speechToText.listen(
        onResult: (result) => {onResult(result.recognizedWords)});
  }

  void stopListening() {
    _speechToText.stop();
  }

  void _speechErrorListener(SpeechRecognitionError error) {
    print('_speechErrorListener: ${error.errorMsg}');
  }

  void _speechStatusListner(String status) {
    print('_speechStatusListner Status: ${status}');
  }

  void _speechResult(SpeechRecognitionResult result) {
    print(result);
  }
}
