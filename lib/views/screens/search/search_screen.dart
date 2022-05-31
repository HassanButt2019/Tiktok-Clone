

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticktok_clone/controllers/search_controller.dart';
import 'package:ticktok_clone/views/screens/profile/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    searchController.users.clear();
    return Obx( () {

        return Scaffold(

          appBar: AppBar(
            backgroundColor: Colors.red.shade600,
            title: TextFormField(
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                filled: false,
                labelText: 'Search User',
                labelStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
              ),
               onChanged: (value) => searchController.searchUser(value),
            )
          ),
          body:searchController.users.isEmpty? const Center(
            child: Text(
              'Search for users!',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ):ListView.builder(
              itemCount: searchController.users.length,
              itemBuilder: (context , index){

            final user = searchController.users[index];
            return ListTile(
              onTap: ()=>Get.to(()=> ProfileScreen(uid: user.uid,)),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.profileImage),
              ),
              title: Text(user.name, style:const TextStyle(fontSize: 18,
                color: Colors.white,),),
            );
          }),
        );
      }
    );
  }
}
