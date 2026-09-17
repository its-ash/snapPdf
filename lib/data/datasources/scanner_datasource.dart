import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:snappdf/core/errors/app_exception.dart';

class ScannerDatasource {
  final _scanner = DocumentScanner(
    options: DocumentScannerOptions(
      documentFormats: const {DocumentFormat.jpeg},
      mode: ScannerMode.full,
      isGalleryImport: true,
      pageLimit: 50,
    ),
  );

  Future<List<String>> scan() async {
    try {
      final result = await _scanner.scanDocument();
      final images = result.images;
      if (images == null || images.isEmpty) throw const ScanCancelledException();
      return images;
    } on ScanCancelledException {
      rethrow;
    } catch (e) {
      throw const ScanCancelledException();
    }
  }

  Future<void> dispose() => _scanner.close();
}
