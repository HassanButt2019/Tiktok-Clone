import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ticktok_clone/controllers/auth_controller.dart';

import 'views/screens/addvideo/add_video_screen.dart';
import 'views/screens/message_screen/message_screen.dart';
import 'views/screens/profile/profile_screen.dart';
import 'views/screens/search/search_screen.dart';
import 'views/screens/videos/video_screen.dart';


 List pages = [
  VideoScreen(),
  SearchScreen(),
  const AddVideoScreen(),
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