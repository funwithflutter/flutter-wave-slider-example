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
  int _age = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Select your age',
                style: TextStyle(
                  fontSize: 45,
                  fontFamily: 'Exo',
                ),
              ),
              WaveSlider(
                onChanged: (double val) {
                  setState(() {
                    _age = (val * 100).round();
                  });
                },
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  SizedBox(width: 20.0),
                  Text(
                    _age.toString(),
                    style: TextStyle(fontSize: 45.0),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    'YEARS',
                    style: TextStyle(fontFamily: 'TextMeOne', fontSize: 20.0),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
