import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:snappdf/core/constants/app_constants.dart';
import 'package:snappdf/core/errors/app_exception.dart';
import 'package:uuid/uuid.dart';

class ImageProcessingDatasource {
  const ImageProcessingDatasource();

  Future<String> applyFilter(String imagePath, ScanFilter filter) async {
    final bytes = await File(imagePath).readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) throw const StorageException('unreadable image');

    final processed = switch (filter) {
      ScanFilter.original => decoded,
      ScanFilter.magicColor => img.adjustColor(
        decoded,
        contrast: 1.15,
        saturation: 1.2,
        brightness: 1.05,
      ),
      ScanFilter.blackAndWhite => img.contrast(img.grayscale(decoded), contrast: 160),
      ScanFilter.grayscale => img.grayscale(decoded),
      ScanFilter.strongContrast => img.adjustColor(decoded, contrast: 1.5, saturation: 1.1),
    };

    return _writeJpg(processed);
  }

  Future<String> rotate(String imagePath, int degrees) async {
    final bytes = await File(imagePath).readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) throw const StorageException('unreadable image');
    final rotated = img.copyRotate(decoded, angle: degrees);
    return _writeJpg(rotated);
  }

  Future<Uint8List> readBytes(String imagePath) => File(imagePath).readAsBytes();

  Future<String> _writeJpg(img.Image image) async {
    final dir = await getApplicationDocumentsDirectory();
    final workDir = Directory(p.join(dir.path, AppConstants.documentsDirName));
    if (!await workDir.exists()) await workDir.create(recursive: true);
    final outPath = p.join(workDir.path, '${const Uuid().v4()}.jpg');
    final jpg = img.encodeJpg(image, quality: AppConstants.jpegQuality.toInt());
    await File(outPath).writeAsBytes(jpg);
    return outPath;
  }
}
