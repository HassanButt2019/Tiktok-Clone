import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticktok_clone/constants.dart';
import 'package:ticktok_clone/models/user_model.dart' as model;
import 'package:http/http.dart'as http;
import 'package:ticktok_clone/views/auth/login_screen.dart';
import 'package:ticktok_clone/views/home/home_screen.dart';
import 'package:ticktok_clone/web_view/auth/login_screen.dart';
import 'package:ticktok_clone/web_view/home/home_screen.dart';


class AuthController extends GetxController {
  static AuthController authInstance = Get.find();

  RxBool isLoading = false.obs;

  late Rx<User?> _user;

  Rx<File?>? _pickedImage;
  File? get profilePhoto => _pickedImage!.value;

  User get user => _user.value!;


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  Future sendEmail(String name,String subject, String email, String message) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const templateId = 'template_34oqqeg';
    const userId = 'KdfJ6R7msjgm8Pwxy';
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'service_id': "service_zcdbwyp",
          'template_id': templateId,
          'user_id': userId,
          "accessToken":"rmk_4hYQpABy2h0H-SzEg",
          'template_params': {
            'to_name': name,
            "subject": subject,
            'message': message,
            "to_email":email,
          }
        }));
    return response.statusCode;
  }


  _setInitialScreen(User? user)
  {
    if(user == null)
      {
        Get.offAll(()=>kIsWeb? KWebLoginScreen():LoginScreen());
      }else{
      Get.offAll(()=> kIsWeb? const KWebHomeScreen():const HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          'You have successfully selected your views.screens.profile picture!');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  //upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child("profilePictures")
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);

    TaskSnapshot snap = await uploadTask;
    String url = await snap.ref.getDownloadURL();
    return url;
  }

  //register the user

  void registerUser(String username, String email, String password,
      String phoneNumber, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          image != null) {
        //save user into firebase and auth
        isLoading.toggle();
        var message =
        """ 
        You Just Registered In Our Application at ${DateTime.now().toUtc().toString().substring(0,19)}
        """;

        UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password).then((value) {
          sendEmail(username, "You Just Have Registered In Our Application", email,message );
          return value;
        });;

        String url = await _uploadToStorage(image);
        model.User usr = model.User(
            email: email,
            name: username,
            phoneNumber: phoneNumber,
            profileImage: url,
            uid: userCredential.user!.uid);

        await firestore
            .collection("user")
            .doc(userCredential.user!.uid)
            .set(usr.toJson());
      } else {
        Get.snackbar("Error Creating User", "Please Enter All Information");
      }
    } catch (err) {
      Get.snackbar("Error Creating Account", err.toString());
    }

    isLoading.toggle();

  }

  //register the user
  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        isLoading.toggle();
        var message =
        """ 
        You Just Loggin In Our Application at ${DateTime.now().toUtc().toString().substring(0,19)}
        """;
        //save user into firebase and auth
        UserCredential userCredential = await firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password).then((value) {
             sendEmail(_user.value!.displayName.toString(), "You Just Have Loggin In Our Application", email,message );
            return value;
        });
        Get.offAll(()=>const HomeScreen());
      } else {
        Get.snackbar("Error Login User", "Please Enter All Information");
      }
    } catch (err) {
      Get.snackbar("Error Login Account", err.toString());
    }
    isLoading.toggle();
  }


  void signOut() async
  {

    isLoading.toggle();
    await firebaseAuth.signOut();
    isLoading.toggle();

  }
}
