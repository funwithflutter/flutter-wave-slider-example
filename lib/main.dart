import 'package:flutter/material.dart';
import 'package:wave_slider/wave_slider.dart';

void main() => runApp(MaterialApp(
      home: App(),
    ));

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: WaveSlider(),
        ),
      ),
    );
  }
}
