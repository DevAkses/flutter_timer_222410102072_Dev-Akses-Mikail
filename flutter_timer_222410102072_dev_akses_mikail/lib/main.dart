import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int detik = 0;
  int inputan = 0;
  bool _timerRunning = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      detik = inputan;
      _timerRunning = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (detik > 0) {
        setState(() {
          detik--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          _timerRunning = false;
          // Menampilkan informasi "waktu habis"
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Waktu Habis!'),
                content: Text('Waktu yang Anda masukkan telah selesai.'),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        });
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _timerRunning = false;
      _timer.cancel();
    });
  }

  void _resetTimer() {
    setState(() {
      detik = 0;
      _timerRunning = false;
      _timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$detik Detik',
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(
              height: 24,
              width: 200,
              child: Text("Masukkan Waktu"),
            ),
            SizedBox(
              height: 24,
              width: 200,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(),
                onChanged: (text) {
                  setState(() {
                    inputan = int.parse(text);
                  });
                },
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _timerRunning ? null : _startTimer,
                  child: Text('Start'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _timerRunning ? _stopTimer : null,
                  child: Text('Stop'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
