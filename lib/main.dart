import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgets Básicos',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ejemplo Widgets Flutter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Texto con Widget Text'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.blue),
                  Text('Fila con Row')
                ],
              ),
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.amber,
                child: Text('Container con Padding'),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    color: Colors.red,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.green,
                  ),
                  Text('Stack de Widgets'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
