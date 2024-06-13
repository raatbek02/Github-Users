import 'package:flutter/material.dart';

class NoInternetPageWidget extends StatelessWidget {
  const NoInternetPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 24,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Нет подключения',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 50),
                ],
              ),
            ),
            const Expanded(
              child: Center(
                child: Icon(
                  Icons.signal_wifi_off,
                  size: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
