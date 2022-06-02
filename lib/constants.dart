import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ticktok_clone/controllers/auth_controller.dart';
import 'package:ticktok_clone/views/videos/video_screen.dart';

import 'views/addvideo/add_video_screen.dart';
import 'views/message_screen/message_screen.dart';
import 'views/profile/profile_screen.dart';
import 'views/search/search_screen.dart';




 List pages = [
  VideoScreen(),
  SearchScreen(),
  kIsWeb?const AddVideoScreen():Container(),
  MessageScreen(),
  ProfileScreen(uid: authController.user.uid,),
];




// COLORS

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;
var iconColor = Colors.red[300];
var bottomBackgroundColor = Colors.red[400];




//Firebase constants

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;


//controllers
var authController = AuthController.authInstance;