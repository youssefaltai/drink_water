import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'logger.dart';
import 'router.dart';
import 'theme.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [ProviderDebugLogger()],
      child: const MainApp(),
    ),
  );
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ref.watch(themeProvider),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProviderDebugLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) =>
      logger.d('initialized: ${provider.name} with $value');

  @override
  void didDisposeProvider(
          ProviderBase<Object?> provider, ProviderContainer container) =>
      logger.d('disposed: ${provider.name}');

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) =>
      logger.d('updated: ${provider.name} from $previousValue to $newValue');
}
