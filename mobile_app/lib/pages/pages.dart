library pages;

import 'dart:convert';

import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../themes.dart';
import '../widgets.dart';
import '../models/account.dart';
import '../models/database.dart';
import '../models/post.dart';
import '../models/category.dart';

//All app pages
part 'signUpPage.dart';

part 'homePage.dart';

part 'addPostPage.dart';

part 'postPage.dart';

