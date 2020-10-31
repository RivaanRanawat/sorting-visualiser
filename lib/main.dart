import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
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
  int _sampleSize = 500;
  StreamController<List<int>> _streamController;
  Stream<List<int>> _stream;
  int val = 500;
  String currentPage = "Bubble Sort";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _randomise();
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<int>>();
    _stream = _streamController.stream;
  }

  _randomise() {
    _sampleSize = MediaQuery.of(context).size.width.toInt();
    _numbers = [];
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(_sampleSize));
    }
    _streamController.add(_numbers);
  }

  _bubbleSort() async {
    for (int i = 0; i < _numbers.length; ++i) {
      for (int j = 0; j < _numbers.length - i - 1; ++j) {
        if (_numbers[j] > _numbers[j + 1]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[j + 1];
          _numbers[j + 1] = temp;
        }
        await Future.delayed(Duration(microseconds: val));
        _streamController.add(_numbers);
      }
    }
  }

  cf(int a, int b) {
    if (a < b) {
      return -1;
    } else if (a > b) {
      return 1;
    } else {
      return 0;
    }
  }

  _quickSort(int leftIndex, int rightIndex) async {
    Future<int> _partition(int left, int right) async {
      int p = (left + (right - left) / 2).toInt();

      var temp = _numbers[p];
      _numbers[p] = _numbers[right];
      _numbers[right] = temp;
      await Future.delayed(Duration(microseconds: 5000), () {});

      _streamController.add(_numbers);

      int cursor = left;

      for (int i = left; i < right; i++) {
        if (cf(_numbers[i], _numbers[right]) <= 0) {
          var temp = _numbers[i];
          _numbers[i] = _numbers[cursor];
          _numbers[cursor] = temp;
          cursor++;
          await Future.delayed(Duration(microseconds: 5000), () {});
          _streamController.add(_numbers);
        }
      }

      temp = _numbers[right];
      _numbers[right] = _numbers[cursor];
      _numbers[cursor] = temp;
      await Future.delayed(Duration(microseconds: 5000), () {});
      _streamController.add(_numbers);
      return cursor;
    }

    if (leftIndex < rightIndex) {
      int p = await _partition(leftIndex, rightIndex);

      await _quickSort(leftIndex, p - 1);

      await _quickSort(p + 1, rightIndex);
    }
  }

  void handleClick(String value) {
    switch (value) {
      case 'Bubble Sort':
        setState(() {
          currentPage = "Bubble Sort";
        });
        break;
      case 'Quick Sort':
        setState(() {
          currentPage = "Quick Sort";
        });
        break;
      case 'Insertion Sort':
        setState(() {
          currentPage = "Insertion Sort";
        });
        break;
      case 'Merge Sort':
        setState(() {
          currentPage = "Merge Sort";
        });
        break;
      case 'Selection Sort':
        setState(() {
          currentPage = "Selection Sort";
        });
        break;
      case 'Heap Sort':
        setState(() {
          currentPage = "Heap Sort";
        });
        break;
    }
  }

  _generateAlgoAccordingToPage() {
    if (currentPage == "Bubble Sort") {
      _bubbleSort();
    } else if (currentPage == "Quick Sort") {
      _quickSort(0, _sampleSize - 1);
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
      body: Column(
        children: [
          StreamBuilder<Object>(
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
        ],
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
              onPressed: _generateAlgoAccordingToPage,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
