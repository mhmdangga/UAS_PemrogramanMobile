import 'package:flutter/material.dart';

class MountainPages extends StatefulWidget {
  const MountainPages({Key? key}) : super(key: key);

  @override
  _MountainPages createState() => _MountainPages();
}

class _MountainPages extends State<MountainPages> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Empty Flutter Page'),
        ),
        body: Center(
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
