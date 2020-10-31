import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sorting_visualiser/algo_navigation.dart';
import 'package:sorting_visualiser/bar_painter.dart';

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
  double _sampleSize = 500;
  StreamController<List<int>> _streamController;
  Stream<List<int>> _stream;
  int val = 5000;
  String currentPage = "Bubble Sort";
  bool isVisualizing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sampleSize = MediaQuery.of(context).size.width / 2;
    _streamController = StreamController<List<int>>();
    _stream = _streamController.stream;
    _randomise();
  }

  _randomise() {
    _sampleSize = MediaQuery.of(context).size.width / 2;
    _numbers = [];
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(500));
    }
    setState(() {
      isVisualizing = false;
    });
    _streamController.add(_numbers);
  }

  void handleClick(String value) {
    switch (value) {
      case 'Bubble Sort':
        setState(() {
          _randomise();
          isVisualizing = false;
          currentPage = "Bubble Sort";
        });
        break;
      case 'Quick Sort':
        setState(() {
          _randomise();
          isVisualizing = false;
          currentPage = "Quick Sort";
        });
        break;
      case 'Insertion Sort':
        setState(() {
          _randomise();
          isVisualizing = false;
          currentPage = "Insertion Sort";
        });
        break;
      case 'Merge Sort':
        setState(() {
          _randomise();
          isVisualizing = false;
          currentPage = "Merge Sort";
        });
        break;
      case 'Selection Sort':
        setState(() {
          _randomise();
          isVisualizing = false;
          currentPage = "Selection Sort";
        });
        break;
      case 'Heap Sort':
        setState(() {
          _randomise();
          isVisualizing = false;
          currentPage = "Heap Sort";
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentPage),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Bubble Sort',
                'Quick Sort',
                'Insertion Sort',
                'Merge Sort',
                'Selection Sort',
                'Heap Sort'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: StreamBuilder<Object>(
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
        },
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: FlatButton(
              child: Text(
                "Generate Random",
              ),
              onPressed: _randomise,
            ),
          ),
          Expanded(
            child: FlatButton(
              child: Text(
                "Visualise",
              ),
              onPressed: isVisualizing == false
                  ? () {
                      generateAlgoAccordingToPage(currentPage, _numbers,
                          _streamController, val, _sampleSize);
                      setState(() {
                        isVisualizing = !isVisualizing;
                      });
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
