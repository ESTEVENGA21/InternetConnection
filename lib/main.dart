import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'connection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProviderExample.create()
    );
  }
}


class ProviderExample extends StatelessWidget {
  
  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => ConnectionStatusModel(),
      child: ProviderExample(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('The device has access to the Internet:'),
            Consumer<ConnectionStatusModel>(
              builder: (_, model, __) {
                return Text(
                  model.isOnline ? 'Conexion Exitosa!!' : 'Sin Conexion!!',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
    );}
}
