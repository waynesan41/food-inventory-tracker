//==========

import 'package:flutter/material.dart';

//======================================
class MyHomePage extends StatefulWidget {
  final Function toggleTheme;
  MyHomePage(this.toggleTheme);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//======================================
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onTapOutside: (ctx) {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          autofocus: false,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: "Search",
            suffixIcon: IconButton(
              onPressed: () {
                //Clear textfield
              },
              icon: Icon(Icons.clear),
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 3, top: 3, bottom: 3),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: IconButton(
              onPressed: () {
                widget.toggleTheme();
              },
              icon: const Icon(Icons.filter_alt_outlined),
            ),
          ),
        ],
      ),
      drawer: Drawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
