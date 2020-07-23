import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter_email_sender/flutter_email_sender.dart';

class ComposeMail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComposeForm();
  }
}

class ComposeForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ComposeFormState();
  }
}

class _ComposeFormState extends State<ComposeForm> {
  final _recipientController = TextEditingController(
    text: 'example@example.com',
  );

  final _subjectController = TextEditingController(text: 'The subject');

  final _bodyController = TextEditingController(
    text: 'Mail body',
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Compose Mail'),
        backgroundColor: Colors.blue,
        brightness: Brightness.dark,
        actions: <Widget>[
          IconButton(onPressed: send, icon: Icon(Icons.send)),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _recipientController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Recipient',
                        hintText: 'Enter recipient',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _subjectController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Subject',
                        hintText: 'Enter Subject',
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _bodyController,
                        maxLines: 10,
                        decoration: InputDecoration(
                          labelText: 'body',
                          border: OutlineInputBorder(),
                          hintText: 'Enter body',
                        ),
                      ))
                ],
              )),
        ),
      ),
    );
  }
}
