import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:week4/features/dosen/data/models/dosen_model.dart';
import 'package:week4/features/dosen/data/repositories/dosen_repositories.dart';

// repository provider
final dosenRepositoryProvider = Provider<DosenRepositories>((ref) {
  return DosenRepositories();
}); // provider

// statenotifier provider untuk mengelola state dosen
class DosenNotifier extends StateNotifier<AsyncValue<List<DosenModel>>> {
  final DosenRepositories _repository;

  DosenNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadDosenList();
  }

  // load data dosen dalam bentuk list
  Future<void> loadDosenList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getDosenList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // refresh data dosen dalam bentuk list
  Future<void> refresh() async {
    await loadDosenList();
  }
}

// dosen notifier provider
final dosenNotifierProvider =
    StateNotifierProvider.autoDispose<DosenNotifier, AsyncValue<List<DosenModel>>>((ref) {
      final repository = ref.watch(dosenRepositoryProvider);
      return DosenNotifier(repository);
    });