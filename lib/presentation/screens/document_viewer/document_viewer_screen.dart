import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import 'package:snappdf/domain/entities/scan_document.dart';
import 'package:snappdf/presentation/providers/repository_providers.dart';

class DocumentViewerScreen extends ConsumerWidget {
  const DocumentViewerScreen({super.key, required this.document});

  final ScanDocument document;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdfPath = document.pdfPath;

    return Scaffold(
      appBar: AppBar(
        title: Text(document.title),
        actions: [
          if (pdfPath != null)
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () => ref.read(documentRepositoryProvider).shareFile(pdfPath),
            ),
        ],
      ),
      body: pdfPath == null
          ? const Center(child: Text('No PDF generated for this document.'))
          : PdfPreview(
              build: (format) => File(pdfPath).readAsBytes(),
              allowSharing: true,
              allowPrinting: true,
              canChangeOrientation: false,
              canChangePageFormat: false,
            ),
    );
  }
}
