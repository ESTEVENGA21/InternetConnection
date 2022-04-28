import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class ConnectionStatusModel extends ChangeNotifier {

  final Connectivity _connectivity = Connectivity();
  StreamSubscription _connectionSubscription;
  bool _isOnline = true;

  ConnectionStatusModel() {
    _connectionSubscription = _connectivity.onConnectivityChanged
        .listen((_) => _checkInternetConnection());
    _checkInternetConnection();
  }

  bool get isOnline => _isOnline;

  Future<void> _checkInternetConnection() async {
    try {
      // A veces se llama a la devolución de llamada cuando nos volvemos a conectar a wifi, pero Internet no funciona realmente
      // Este retraso trata de esperar hasta que estemos realmente conectados a internet
      await Future.delayed(const Duration(seconds: 3));
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isOnline = true;
      } else {
        _isOnline = false;
      }
    } on SocketException catch (_) {
      _isOnline = false;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }
}