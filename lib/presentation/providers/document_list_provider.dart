import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snappdf/domain/entities/scan_document.dart';
import 'package:snappdf/presentation/providers/repository_providers.dart';

class DocumentListNotifier extends AsyncNotifier<List<ScanDocument>> {
  @override
  Future<List<ScanDocument>> build() {
    return ref.watch(documentRepositoryProvider).loadAll();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(documentRepositoryProvider).loadAll());
  }

  Future<void> saveDocument(ScanDocument document) async {
    await ref.read(documentRepositoryProvider).save(document);
    await refresh();
  }

  Future<void> deleteDocument(String documentId) async {
    await ref.read(documentRepositoryProvider).delete(documentId);
    await refresh();
  }
}

final documentListProvider = AsyncNotifierProvider<DocumentListNotifier, List<ScanDocument>>(
  DocumentListNotifier.new,
);
