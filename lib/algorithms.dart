// BUBBLE SORT
bubbleSort(_numbers, _streamController) async {
  for (int i = 0; i < _numbers.length; ++i) {
    for (int j = 0; j < _numbers.length - i - 1; ++j) {
      if (_numbers[j] > _numbers[j + 1]) {
        int temp = _numbers[j];
        _numbers[j] = _numbers[j + 1];
        _numbers[j + 1] = temp;
      }
      await Future.delayed(Duration(microseconds: 1000));
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

// QUICK SORT
quickSort(
    int leftIndex, int rightIndex, _numbers, _streamController, val) async {
  Future<int> _partition(int left, int right) async {
    int p = (left + (right - left) / 2).toInt();

    var temp = _numbers[p];
    _numbers[p] = _numbers[right];
    _numbers[right] = temp;
    await Future.delayed(Duration(microseconds: val), () {});

    _streamController.add(_numbers);

    int cursor = left;

    for (int i = left; i < right; i++) {
      if (cf(_numbers[i], _numbers[right]) <= 0) {
        var temp = _numbers[i];
        _numbers[i] = _numbers[cursor];
        _numbers[cursor] = temp;
        cursor++;
        await Future.delayed(Duration(microseconds: val), () {});
        _streamController.add(_numbers);
      }
    }

    temp = _numbers[right];
    _numbers[right] = _numbers[cursor];
    _numbers[cursor] = temp;
    await Future.delayed(Duration(microseconds: val), () {});
    _streamController.add(_numbers);
    return cursor;
  }

  if (leftIndex < rightIndex) {
    int p = await _partition(leftIndex, rightIndex);

    await quickSort(leftIndex, p - 1, _numbers, _streamController, val);

    await quickSort(p + 1, rightIndex, _numbers, _streamController, val);
  }
}

// INSERTION SORT
insertionSort(_numbers, _streamController, val) async {
  for (int i = 1; i < _numbers.length; i++) {
    int temp = _numbers[i];
    int j = i - 1;
    while (j >= 0 && temp < _numbers[j]) {
      _numbers[j + 1] = _numbers[j];
      --j;
      await Future.delayed(Duration(microseconds: val), () {});

      _streamController.add(_numbers);
    }
    _numbers[j + 1] = temp;
    await Future.delayed(Duration(microseconds: val), () {});

    _streamController.add(_numbers);
  }
}

// MERGE SORT
mergeSort(
    int leftIndex, int rightIndex, _numbers, _streamController, val) async {
  Future<void> merge(int leftIndex, int middleIndex, int rightIndex) async {
    int leftSize = middleIndex - leftIndex + 1;
    int rightSize = rightIndex - middleIndex;

    List leftList = new List(leftSize);
    List rightList = new List(rightSize);

    for (int i = 0; i < leftSize; i++) leftList[i] = _numbers[leftIndex + i];
    for (int j = 0; j < rightSize; j++)
      rightList[j] = _numbers[middleIndex + j + 1];

    int i = 0, j = 0;
    int k = leftIndex;

    while (i < leftSize && j < rightSize) {
      if (leftList[i] <= rightList[j]) {
        _numbers[k] = leftList[i];
        i++;
      } else {
        _numbers[k] = rightList[j];
        j++;
      }

      await Future.delayed(Duration(microseconds: val), () {});
      _streamController.add(_numbers);

      k++;
    }

    while (i < leftSize) {
      _numbers[k] = leftList[i];
      i++;
      k++;

      await Future.delayed(Duration(microseconds: val), () {});
      _streamController.add(_numbers);
    }

    while (j < rightSize) {
      _numbers[k] = rightList[j];
      j++;
      k++;

      await Future.delayed(Duration(microseconds: val), () {});
      _streamController.add(_numbers);
    }
  }

  if (leftIndex < rightIndex) {
    int middleIndex = (rightIndex + leftIndex) ~/ 2;

    await mergeSort(leftIndex, middleIndex, _numbers, _streamController, val);
    await mergeSort(
        middleIndex + 1, rightIndex, _numbers, _streamController, val);

    await Future.delayed(Duration(microseconds: val), () {});

    _streamController.add(_numbers);

    await merge(leftIndex, middleIndex, rightIndex);
  }
}
