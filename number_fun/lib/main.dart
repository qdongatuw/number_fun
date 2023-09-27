import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _sliderValue = 1;
  int _numItems = 1;
  List<int> factors = [];
  int _numOfFactors = 1; 
  double sqrtNum = 1;

  void _updateSliderValue(double value) {
    setState(() {
      _numItems = value.toInt();
      factors.clear();
      sqrtNum = sqrt(_numItems);
      int sqrtNumber = sqrtNum.toInt();
      for (int i = 1; i <= sqrtNumber; i++) {
        if (_numItems % i == 0) {
          factors.add(i);  // i is a factor of number
          if (i != _numItems ~/ i) {  // Avoid duplicates if number is a perfect square
            factors.add(_numItems ~/ i);  // number / i is also a factor of number
          }
        }
      }
      _sliderValue = value;
      _numOfFactors = factors.length;
    });
  }

  List<Widget> _buildGridItems(int count) {
    List<Widget> items = [];
    for (int i = 1; i <= count; i++) {
      Color backgroundColor;
      if (factors.contains(i)){
        if (i < sqrtNum) {  // Check if i is less than the square root of count
          backgroundColor = Colors.red;
        } else if (i > sqrtNum) {  // Check if i is greater than the square root of count
          backgroundColor = Colors.blue;
        } else {  // i is equal to the square root of count
          backgroundColor = Colors.yellow;
        }
      }
      else {
        backgroundColor = Colors.grey;
      }
      items.add(
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
          width: 5,
          height: 5,
          alignment: Alignment.center,
          child: Text(i.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      );
    }

    return items;
}



  @override
  Widget build(BuildContext context) {
    int numClm;
    if (_numItems < 150){
      numClm = 20;
    }
    else{
      numClm = 40;
    }
    return MaterialApp(
      theme: ThemeData.dark(),  // Applying dark theme
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Numbers are fun!'),
        // ),
        body: Column(
          children: [
            Slider(
              value: _sliderValue,
              min: 1,
              max: 700,
              divisions: 699,
              onChanged: _updateSliderValue,
            ),
            Text('${_sliderValue.toInt()} has $_numOfFactors factors.', style: const TextStyle(color: Colors.amberAccent, fontSize: 18), ),
            const SizedBox(height: 10,),
            Expanded(
              child: GridView.count(
                crossAxisCount: numClm,
                children: _buildGridItems(_numItems),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
