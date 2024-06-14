import 'package:flutter/foundation.dart';
import 'package:logger/web.dart';

class NoopPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    return <String>[];
  }
}

Logger logger = kReleaseMode
    ? Logger(printer: NoopPrinter())
    : Logger(
        printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 5,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          excludePaths: [""],
        ),
        output: ConsoleOutput(),
        filter: ProductionFilter(),
      );
