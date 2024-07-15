import 'package:logger/logger.dart';

final logger = Logger(printer: CustomLogPrinter());

class CustomLogPrinter extends LogPrinter {
  CustomLogPrinter();

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.defaultLevelColors[event.level];
    final emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    final message = event.message;
    final error = event.error;
    final stackTrace = event.stackTrace;

    final errorString = error != null ? 'Error: $error' : '';
    final stackTraceString =
        stackTrace != null ? 'Stack Trace: $stackTrace' : '';

    return [
      color!('$emoji $message'),
      if (errorString.isNotEmpty) color(errorString),
      if (stackTraceString.isNotEmpty) color(stackTraceString),
    ];
  }
}
