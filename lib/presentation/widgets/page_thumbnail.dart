import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snappdf/domain/entities/scan_page.dart';

class PageThumbnail extends StatelessWidget {
  const PageThumbnail({
    super.key,
    required this.page,
    required this.index,
    this.onTap,
    this.onDelete,
    this.selected = false,
  });

  final ScanPage page;
  final int index;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 110,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected ? scheme.primary : scheme.outlineVariant,
                width: selected ? 2 : 1,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.file(File(page.processedImagePath), fit: BoxFit.cover),
          ),
          Positioned(
            left: 6,
            bottom: 6,
            child: CircleAvatar(
              radius: 11,
              backgroundColor: scheme.primary,
              child: Text(
                '${index + 1}',
                style: TextStyle(fontSize: 11, color: scheme.onPrimary, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (onDelete != null)
            Positioned(
              right: 2,
              top: 2,
              child: IconButton(
                iconSize: 18,
                icon: Icon(Icons.cancel, color: scheme.error),
                onPressed: onDelete,
              ),
            ),
        ],
      ),
    );
  }
}
