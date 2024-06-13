import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectivityStatus { online, offline }

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final connectivityController = StreamController<ConnectivityStatus>();

  ConnectivityService() {
    try {
      _connectivity.onConnectivityChanged
          .listen((List<ConnectivityResult> results) {
        // Обрабатываем только последний результат в списке
        var lastResult = results.last;
        connectivityController.add(_getStatusFromResult(lastResult));
      });
    } catch (e) {
      print('Ошибка при обработке изменений состояния подключения: $e');
    }
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return ConnectivityStatus.online;
      case ConnectivityResult.none:
        return ConnectivityStatus.offline;
      default:
        return ConnectivityStatus.offline;
    }
  }

  void dispose() {
    connectivityController.close();
  }
}
