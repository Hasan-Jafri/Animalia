import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoaderNotifier extends StateNotifier<bool> {
  LoaderNotifier() : super(false);

  void showLoader() => state = true;

  void hideLoader() => state = false;
}

final loaderProvider = StateNotifierProvider<LoaderNotifier, bool>((ref) {
  return LoaderNotifier();
});
