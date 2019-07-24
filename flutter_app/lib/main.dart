import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: Center( child: LinkPreview())));
  }
}

class LinkPreview extends StatefulWidget {
  LinkPreview({Key key}) : super(key: key);

  createState() => LinkPreviewState();
}

class LinkPreviewState extends State<LinkPreview> {
  List _links = [];

  bool _loading = false;

  String _text;

  final _controller = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            // decoration: InputDecoration(
            //   border: InputBorder.none,
            //   hintText: 'Enter a search term',
            // ),
          ),
          FlatButton(
            child: Text('Submit'),
            onPressed: _handleSubmit,
          ),
          for (var linkData in _links) ...[
            Text(linkData['title']),
          ]
        ],
      ),
    );
  }

  _handleSubmit() async {
    String url = 'http://localhost:5000/fireship-lessons/us-central1/scraper';


    var response = await http.post(url, body: {'text': _controller.text});

    print(response);

    setState(() {
      _links = json.decode(response.body);
    });
  }
}
