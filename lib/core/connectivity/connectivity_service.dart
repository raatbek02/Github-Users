import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityAwareWidget extends StatefulWidget {
  final Widget child;

  const ConnectivityAwareWidget({required this.child, super.key});

  @override
  _ConnectivityAwareWidgetState createState() =>
      _ConnectivityAwareWidgetState();
}

class _ConnectivityAwareWidgetState extends State<ConnectivityAwareWidget> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        _showNoInternetSnackBar();
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _showNoInternetSnackBar() {
    final scaffoldMessengerState = ScaffoldMessenger.of(context);
    scaffoldMessengerState.hideCurrentSnackBar();
    scaffoldMessengerState.showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.wifi_off, color: Colors.white),
            SizedBox(width: 10),
            Text('Нет подключения к интернету',
                style: TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
        margin: EdgeInsets.only(left: 10, right: 10),
        elevation: 10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
