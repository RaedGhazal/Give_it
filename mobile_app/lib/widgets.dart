import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/account.dart';
import 'pages/pages.dart';
import 'pages/pages.dart';
import 'themes.dart';

import 'models/post.dart';
import 'models/category.dart';

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
  final Category category;
  final Location location;

  const CategoryWidget(this.category, this.location);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostPage(
                category: category,
                location: location,
              ),
            ),
          );
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              category.asset,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Chip(
                label: Text(category.name),
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
    // return Material(
    //   child: Card(
    //     margin: EdgeInsets.all(10),
    //     child: Material(
    //       color: Colors.white,
    //       elevation: 5,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //

    //               //Images
    //               AspectRatio(
    //                 aspectRatio: 1,
    //                 child: Stack(
    //                   children: [

    return Container(
      height: 400,
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color(0x54000000),
              spreadRadius: 1,
              blurRadius: 4,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //Sub category
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${_post.subCategory}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 15),
                      ),
                    ),

                    Spacer(),

                    //Show phone number.
                    IconButton(
                      icon: Icon(MdiIcons.phoneOutline),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              PhoneNumberDialog(_post.phoneNumber),
                        );
                      },
                    ),
                  ],
                ),

                //Images
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x54000000),
                            spreadRadius: 1,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _post.imagesUrl.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                _post.imagesUrl[index],
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //Description
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
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
          ),
        ),
      ),
    );
  }
}

class PhoneNumberDialog extends StatelessWidget {
  final String phoneNumber;

  const PhoneNumberDialog(this.phoneNumber);

  @override
  Widget build(BuildContext context) {
    if (!isSignedIn)
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text('Please sign in first'),
          action: SnackBarAction(
              label: 'Sign in',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              }),
        ));

    return AlertDialog(
      title: Text(
        'Phone number',
        style: TextStyle(fontSize: 20),
      ),
      content: Text(
        '$phoneNumber',
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: 20,
            ),
      ),
      actions: [
        FlatButton(
          color: grey,
          child: Text(
            'Cancel',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        FlatButton(
          color: grey,
          child: Text(
            'Call',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white),
          ),
          onPressed: () {
            launch("tel://$phoneNumber");
          },
        ),
      ],
    );
  }
}

class BigButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const BigButton({this.text = '', this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 60,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 23,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
