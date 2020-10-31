import 'package:sorting_visualiser/algorithms.dart';

generateAlgoAccordingToPage(
    currentPage, _numbers, _streamController, val, _sampleSize) {
  if (currentPage == "Bubble Sort") {
    bubbleSort(_numbers, _streamController);
  } else if (currentPage == "Quick Sort") {
    quickSort(0, _sampleSize.toInt() - 1, _numbers, _streamController, val);
  } else if (currentPage == "Insertion Sort") {
    insertionSort(_numbers, _streamController, val);
  } else if (currentPage == "Merge Sort") {
    mergeSort(0, _sampleSize.toInt() - 1, _numbers, _streamController, val);
  } else if (currentPage == "Selection Sort") {
    selectionSort(_numbers, _streamController, val);
  }
}
