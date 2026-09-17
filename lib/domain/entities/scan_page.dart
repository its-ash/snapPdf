import 'package:snappdf/core/constants/app_constants.dart';

class ScanPage {
  const ScanPage({
    required this.id,
    required this.originalImagePath,
    required this.processedImagePath,
    this.filter = ScanFilter.original,
    this.rotationDegrees = 0,
    this.ocrText,
  });

  final String id;
  final String originalImagePath;
  final String processedImagePath;
  final ScanFilter filter;
  final int rotationDegrees;
  final String? ocrText;

  ScanPage copyWith({
    String? processedImagePath,
    ScanFilter? filter,
    int? rotationDegrees,
    String? ocrText,
  }) => ScanPage(
    id: id,
    originalImagePath: originalImagePath,
    processedImagePath: processedImagePath ?? this.processedImagePath,
    filter: filter ?? this.filter,
    rotationDegrees: rotationDegrees ?? this.rotationDegrees,
    ocrText: ocrText ?? this.ocrText,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'originalImagePath': originalImagePath,
    'processedImagePath': processedImagePath,
    'filter': filter.name,
    'rotationDegrees': rotationDegrees,
    'ocrText': ocrText,
  };

  factory ScanPage.fromJson(Map<String, dynamic> json) => ScanPage(
    id: json['id'] as String,
    originalImagePath: json['originalImagePath'] as String,
    processedImagePath: json['processedImagePath'] as String,
    filter: ScanFilter.values.byName(json['filter'] as String),
    rotationDegrees: json['rotationDegrees'] as int,
    ocrText: json['ocrText'] as String?,
  );
}
