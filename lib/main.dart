import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _numbers = [];
  int _sampleSize = 500;
  StreamController<List<int>> _streamController;
  Stream<List<int>> _stream;

  _randomise() {
    _numbers = [];
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(_sampleSize));
    }
    _streamController.add(_numbers);
  }

  _bubbleSort()async  {
    for (int i = 0; i < _numbers.length; ++i) {
      for (int j = 0; j < _numbers.length - i - 1; ++j) {
        if (_numbers[j] > _numbers[j + 1]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[j + 1];
          _numbers[j + 1] = temp;
        }
        await Future.delayed(Duration(microseconds: 500));
        _streamController.add(_numbers);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<int>>();
    _stream = _streamController.stream;
    _randomise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bubble Sort"),
      ),
      body: Container(
        child: StreamBuilder<Object>(
          stream: _stream,
          builder: (context, snapshot) {
            int counter = 0;
            return Row(
              children: _numbers.map((int number) {
                counter++;
                return CustomPaint(
                  painter: BarPainter(
                    width: 2.0,
                    value: number,
                    index: counter,
                  ),
                );
              }).toList(),
            );
          }
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: FlatButton(
              child: Text("Randomise",),
              onPressed: _randomise,
            ),
          ),
          Expanded(
            child: FlatButton(
              child: Text("Sort",),
              onPressed: _bubbleSort,
            ),
          ),
        ],
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  final double width;
  final int value;
  final int index;

  BarPainter({this.width, this.value, this.index});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    if (this.value < 500 * 0) {
      paint.color = Color.fromRGBO(0, 0, 66, 0.75);
    } else if (this.value < 500 * .50) {
      paint.color = Color.fromRGBO(17, 104, 217, 0.75);
    } else if (this.value < 500 * .75) {
      paint.color = Color.fromRGBO(0, 217, 159, 0.75);
    } else if (this.value < 500 * .90) {
      paint.color = Color.fromRGBO(0, 190, 218, 0.75);
    }
    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(index * width, 0),
        Offset(index * width, value.ceilToDouble()), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
