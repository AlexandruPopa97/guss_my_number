import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Guess my number',
      home: Content(),
    );
  }
}

class Content extends StatefulWidget {
  const Content({Key key}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  String hint = '';
  final TextEditingController txtController = TextEditingController();
  Random random = Random();
  int numberToBeGuessed;
  int numberGuessed;
  bool textEnable = true;

  @override
  // ignore: must_call_super
  void initState() {
    numberToBeGuessed = random.nextInt(100) + 1;
    print(numberToBeGuessed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Guess my number')),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              child: const Text(
                "I'm thinking of a number between 1 and 100",
                style: TextStyle(
                  fontSize: 23.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "It's your turn to guess my number!",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                hint,
                style: TextStyle(fontSize: 45.0, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Try a number!',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      enabled: textEnable,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: txtController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      // ignore: void_checks
                      onPressed: () {
                        if (textEnable) {
                          //Does this when button is Guess
                          numberGuessed = int.parse(txtController.text);
                          if (numberGuessed == numberToBeGuessed) {
                            setState(() {
                              hint =
                                  'You tried $numberGuessed\nYou guessed right';
                            });
                            return showDialog<String>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('You guessed right!'),
                                    content: Text('It was $numberToBeGuessed'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Try again!'),
                                        onPressed: () {
                                          setState(() {
                                            hint = '';
                                            numberToBeGuessed =
                                                random.nextInt(100) + 1;
                                            print(numberToBeGuessed);
                                            txtController.clear();
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          setState(() {
                                            textEnable = false;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          } else if (numberGuessed < numberToBeGuessed) {
                            setState(() {
                              hint = 'You tried $numberGuessed\nTry higher';
                              txtController.clear();
                            });
                          } else {
                            setState(() {
                              hint = 'You tried $numberGuessed\nTry lower';
                              txtController.clear();
                            });
                          }
                        } else {
                          //Does this when button is Reset
                          setState(() {
                            textEnable = true;
                            numberToBeGuessed = random.nextInt(100) + 1;
                            print(numberToBeGuessed);
                            hint = '';
                            txtController.clear();
                          });
                        }
                      },
                      color: Colors.grey[300],
                      child: Text(
                        textEnable ? 'Guess' : 'Reset',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
