


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ticktok_clone/constants.dart';

import '../models/user_model.dart';

class SearchController extends GetxController
{
  final Rx<List<User>> _users = Rx<List<User>>([]);

  List<User> get users => _users.value;


  searchUser(String typedUser) async
  {
    print("HELLO $typedUser");
    _users.bindStream(
      firestore.collection("user").where("name", isGreaterThanOrEqualTo: typedUser).snapshots().map((QuerySnapshot querySnapshot) {
        List<User> retVal = [];
        for(var element in querySnapshot.docs)
          {
            retVal.add(User.fromSnap(element));
          }
        print(retVal);

        return retVal;
      })
    );

  }
}