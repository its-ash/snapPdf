import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:snappdf/core/errors/app_exception.dart';

class OcrDatasource {
  final _recognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<String> recognize(String imagePath) async {
    try {
      final input = InputImage.fromFilePath(imagePath);
      final result = await _recognizer.processImage(input);
      return result.text;
    } catch (e) {
      throw OcrException('$e');
    }
  }

  Future<void> dispose() => _recognizer.close();
}
