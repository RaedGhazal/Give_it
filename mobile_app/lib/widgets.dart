import 'package:flutter/material.dart';

import 'pages/pages.dart';

import 'pages/pages.dart';
import 'themes.dart';

void showSnackBar(
  GlobalKey<ScaffoldState> scaffoldKey, {
  String content = '',
  Color color = Colors.red,
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
  final GlobalKey<ScaffoldState> homeScaffoldKey;

  const LemonFloatingButton(this.homeScaffoldKey);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddPostPage(homeScaffoldKey)));
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

///Used for [PickLocation].
class Location {
  String governorate;

  Location({this.governorate});
}

class RoundedDropDownButton<T> extends StatelessWidget {
  final DropdownButton<T> dropdownButton;

  const RoundedDropDownButton(this.dropdownButton);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            style: BorderStyle.solid,
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
      ),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: DropdownButtonHideUnderline(
        child: dropdownButton,
      ),
    );
  }
}

class PickLocation extends StatefulWidget {
  final Location location;

  PickLocation(this.location);

  @override
  _PickLocationState createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  @override
  Widget build(BuildContext context) {
    return RoundedDropDownButton(
      DropdownButton<String>(
        icon: Icon(Icons.location_on),
        hint: Text(
          'Location',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        value: widget.location.governorate,
        items: <DropdownMenuItem<String>>[
          for (int i = 0; i < locations.length; i++)
            DropdownMenuItem<String>(
              value: locations[i],
              child: Text(
                locations[i],
                style: Theme.of(context).textTheme.bodyText1,
              ),
            )
        ],
        onChanged: (value) {
          setState(() {
            widget.location.governorate = value;
          });
        },
      ),
    );
  }
}

typedef String Validator(String value);

class MyForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final Validator validator;
  final String labelText;

  const MyForm({
    @required this.formKey,
    @required this.controller,
    @required this.validator,
    @required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: controller,
        validator: validator,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final String asset;
  final String label;

  const CategoryWidget({
    @required this.asset,
    @required this.label,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostPage(category: label),
            ),
          );
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              asset,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Chip(
                label: Text(label),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
