


import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String name ;
  String profileImage;
  String email;
  String uid;
  String phoneNumber;



  User({
    required this.email ,required this.name,required this.phoneNumber,required this.profileImage,required this.uid
  });


Map<String ,dynamic> toJson()=>{
  "name":name,
  "profileImage":profileImage,
  "email":email,
  "uid":uid,
  "phoneNumber":phoneNumber,
};


static User fromSnap(DocumentSnapshot snap){
  var snapshot = snap.data() as Map<String , dynamic>;

  return User(email: snapshot["email"], 
  name: snapshot["name"],
   phoneNumber: snapshot["phoneNumber"],
    profileImage: snapshot["profileImage"],
     uid: snapshot["uid"]);
}

}