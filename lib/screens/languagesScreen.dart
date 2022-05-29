import 'package:flutter/material.dart';

import '../helper/widgets.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Languages'),
        backgroundColor: Colors.red,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7.0),
            child: Catlogo(context),
          ),
        ],
      ),
    );
  }
}
