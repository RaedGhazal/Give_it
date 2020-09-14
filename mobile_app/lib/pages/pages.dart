library pages;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



import 'package:file_picker/file_picker.dart';
import 'package:material_design_icons_flutter/icon_map.dart';

import '../themes.dart';
import '../widgets.dart';
import '../models/account.dart';
import '../models/database.dart';
import '../widgets.dart';

//All app pages
part 'signUpPage.dart';

part 'homePage.dart';

part 'addPostPage.dart';

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
