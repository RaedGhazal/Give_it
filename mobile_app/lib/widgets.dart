import 'package:flutter/material.dart';

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
  const LemonFloatingButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, 'addPost');
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
        hint: Text('Location'),
        value: widget.location.governorate,
        items: <DropdownMenuItem<String>>[
          for (int i = 0; i < locations.length; i++)
            DropdownMenuItem<String>(
              value: locations[i],
              child: Text(locations[i]),
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
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}
