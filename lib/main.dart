import 'package:flutter/material.dart';
import 'package:flutterfab_flare/flare_demo.dart';

void main() => runApp(FlutterFabFlare());

class FlutterFabFlare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Flare FAB',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: FlareDemo(),
    );
  }
}
