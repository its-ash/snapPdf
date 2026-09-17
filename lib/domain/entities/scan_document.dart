import 'package:snappdf/domain/entities/scan_page.dart';

class ScanDocument {
  const ScanDocument({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.pages,
    this.pdfPath,
    this.isPasswordProtected = false,
  });

  final String id;
  final String title;
  final DateTime createdAt;
  final List<ScanPage> pages;
  final String? pdfPath;
  final bool isPasswordProtected;

  ScanDocument copyWith({
    String? title,
    List<ScanPage>? pages,
    String? pdfPath,
    bool? isPasswordProtected,
  }) => ScanDocument(
    id: id,
    title: title ?? this.title,
    createdAt: createdAt,
    pages: pages ?? this.pages,
    pdfPath: pdfPath ?? this.pdfPath,
    isPasswordProtected: isPasswordProtected ?? this.isPasswordProtected,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'createdAt': createdAt.toIso8601String(),
    'pages': pages.map((p) => p.toJson()).toList(),
    'pdfPath': pdfPath,
    'isPasswordProtected': isPasswordProtected,
  };

  factory ScanDocument.fromJson(Map<String, dynamic> json) => ScanDocument(
    id: json['id'] as String,
    title: json['title'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    pages: (json['pages'] as List<dynamic>)
        .map((p) => ScanPage.fromJson(p as Map<String, dynamic>))
        .toList(),
    pdfPath: json['pdfPath'] as String?,
    isPasswordProtected: json['isPasswordProtected'] as bool? ?? false,
  );
}
