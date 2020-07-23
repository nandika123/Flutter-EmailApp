import 'package:flutter/material.dart';

class ReadMail extends StatelessWidget {
  String heading;
  ReadMail(this.heading);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(heading),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Text('Here comes the content of the opened email..'),
        ],
      ),
    );
  }
}
