import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  late final SpeechToText _speechToText;

  SpeechService() {
    _speechToText = SpeechToText();
    _speechToText.initialize(
        onError: _speechErrorListener, onStatus: _speechStatusListener);
  }

  startListening({required resultCallback}) {
    _speechToText.listen(onResult: (result) {
      if (result.finalResult) {
        resultCallback(result.recognizedWords);
      }
    });
  }

  void stopListening() {
    _speechToText.stop();
  }

  void _speechErrorListener(SpeechRecognitionError error) {
    print('_speechErrorListener: ${error.errorMsg}');
  }

  void _speechStatusListener(String status) {
    print('_speechStatusListener Status: ${status}');
  }
}
