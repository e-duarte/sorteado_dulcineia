import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(RandomGenerator(
    key: UniqueKey(),
  ));
}

class RandomGenerator extends StatefulWidget {
  const RandomGenerator({Key? key}) : super(key: key);

  @override
  State<RandomGenerator> createState() => _RandomGeneratorState();
}

class _RandomGeneratorState extends State<RandomGenerator> {
  int sortedNumber = 9999;
  List<int> exclusionNumbers = [];
  List<List<int>> ranges = [];

  int minRange = 1;
  int maxRange = 100;

  int minExclusion = 0;
  int maxExclusion = 0;

  void generateNumber(int min, int max) {
    int number = 0;
    do {
      number = Random().nextInt(max) + min;
    } while (exclusionNumbers.contains(number));

    sortedNumber = number;
  }

  void minRangeHandle(String text) {
    if (text != '') {
      setState(() {
        minRange = int.parse(text);
      });
    }
  }

  void maxRangeHandle(String text) {
    if (text != '') {
      setState(() {
        maxRange = int.parse(text);
      });
    }
  }

  void minExclusionHandle(String text) {
    print(text);
    if (text != '') {
      setState(() {
        minExclusion = int.parse(text);
      });
    }
  }

  void maxExclusionHandle(String text) {
    print(text);
    if (text != '') {
      setState(() {
        maxExclusion = int.parse(text);
      });
    }
  }

  void addExclusionRange() {
    setState(() {
      print('$minExclusion and $maxExclusion');
      List<int> newExclusionNumbers = [];

      for (int i = minExclusion; i <= maxExclusion; i++) {
        newExclusionNumbers.add(i);
      }

      for (var i in newExclusionNumbers) {
        exclusionNumbers.add(i);
      }
      ranges.add([minExclusion, maxExclusion]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sorteador de Números Aleatórios',
      home: Scaffold(
        appBar: AppBar(title: const Text('Sorteador'), actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                sortedNumber = 9999;
                exclusionNumbers = [];
                ranges = [];
                minRange = 1;
                maxRange = 100;
                minExclusion = 0;
                maxExclusion = 0;
              });
            },
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.play_arrow),
          onPressed: () {
            setState(() {
              generateNumber(minRange, maxRange);
            });
          },
        ),
        body: Center(
          child: Container(
            width: 400,
            margin: const EdgeInsets.all(40.0),
            // color: Colors.amber,
            child: ListView(
              children: [
                const Text('Intervalo'),
                Container(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Input(
                      callback: minRangeHandle,
                      placeHold: 'min',
                    ),
                    Container(
                      width: 30,
                    ),
                    Input(
                      callback: maxRangeHandle,
                      placeHold: 'max',
                    ),
                  ],
                ),
                const Text('Lista de exclusão'),
                Container(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Input(
                      callback: minExclusionHandle,
                      placeHold: 'min',
                    ),
                    Container(
                      width: 30,
                    ),
                    Input(
                      callback: maxExclusionHandle,
                      placeHold: 'max',
                    ),
                  ],
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: addExclusionRange,
                    child: const Text('Excluir números'),
                  ),
                ),
                Container(height: 12.0),
                const Text('Número Sorteado'),
                Container(height: 12.0),
                Container(
                  color: Colors.green[600],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        () {
                          var value = sortedNumber != 9999
                              ? sortedNumber.toString()
                              : 'Nenhum número sorteado';
                          print(value);
                          return value;
                        }(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 12.0),
                const Text('Número Excluídos'),
                ...ranges
                    .map<Widget>((e) => ListTile(
                          title: Text('${e[0]} à ${e[1]}'),
                        ))
                    .toList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef TextChangedCallback = void Function(String text);

class Input extends StatelessWidget {
  Input({
    this.width = 120,
    this.height = 80,
    required this.placeHold,
    required this.callback,
    Key? key,
  }) : super(key: key);

  String placeHold;
  final double width;
  final double height;

  final TextChangedCallback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: placeHold,
        ),
        onChanged: callback,
      ),
    );
  }
}
