import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/pages.dart';

import 'themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: defaultTheme,
      routes: <String, WidgetBuilder>{
        'home': (context) => HomePage(),
        'signUp': (context) => SignUpPage(),
        'addPost': (context) => AddPostPage(),
      },
    );
  }
}
