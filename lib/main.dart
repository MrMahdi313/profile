import 'package:flutter_web/material.dart';
import 'dart:html' as html;

import 'package:profile/profile_screen.dart';

void main() async {
  final String username =
      html.window.document.getElementById("username").innerHtml;
  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final String username;
  const MyApp({Key key, this.username}): super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO wth is title
    final String title =
        html.document.title;

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Vollkorn',
      ),
      title: title,
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(username: username,),
    );
  }
}
