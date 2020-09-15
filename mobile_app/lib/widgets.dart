import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'pages/pages.dart';
import 'themes.dart';

import 'models/post.dart';

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

const locations = const <String>[
  'Irbid',
  'Ajloun',
  'Jerash',
  'Mafraq',
  'Balqa',
  'Amman',
  'Zarqa',
  'Madaba',
  'Karak',
  'Tafilah',
  "Ma'an",
  'Aqaba',
];

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

class SortByLocation extends StatefulWidget {
  final Location location;

  SortByLocation(this.location);

  @override
  _SortByLocationState createState() => _SortByLocationState();
}

class _SortByLocationState extends State<SortByLocation> {
  List<String> locationsWithAll = ['All', ...locations];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        icon: Icon(Icons.location_on),
        hint: Text('All'),
        value: widget.location.governorate,
        items: <DropdownMenuItem<String>>[
          for (int i = 0; i < locationsWithAll.length; i++)
            DropdownMenuItem<String>(
              value: locationsWithAll[i],
              child: Text(
                locationsWithAll[i],
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

class PostWidget extends StatelessWidget {
  final Post _post;

  const PostWidget(this._post);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Chip(
                  label: Text(
                    '${_post.category} - ${_post.subCategory}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Spacer(),
              IconButton(
                tooltip: 'Request phone number',
                icon: const Icon(MdiIcons.phoneOutline),
                onPressed: () {},
              ),
            ],
          ),
          AspectRatio(
            aspectRatio: 1,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _post.urlImages.length,
              itemBuilder: (context, index) {
                return Image.network(
                  _post.urlImages[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 0, bottom: 3),
            child: Text(
              _post.description,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'roboto',
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
