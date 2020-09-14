import 'package:flutter/material.dart';

import 'pages/pages.dart';

import 'themes.dart';

void showSnackBar(
  GlobalKey<ScaffoldState> scaffoldKey, {
  String content = '',
  Color color,
}) {
  scaffoldKey.currentState
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: color,
      ),
    );
}

class LemonFloatingButton extends StatelessWidget {
  const LemonFloatingButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddPostPage()),
        );
      },
      backgroundColor: grey,
      tooltip: 'Add new post',
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 35,
      ),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
      ),
    );
  }
}
