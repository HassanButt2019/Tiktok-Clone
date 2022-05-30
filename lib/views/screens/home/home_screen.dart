

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ticktok_clone/constants.dart';
import 'package:ticktok_clone/views/widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[page],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        onTap: (id){
          setState(() {
            page = id;
            debugPrint(page.toString());
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined ,size:30 ),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined ,size:30 ),label: "Search"),

          BottomNavigationBarItem(icon: CustomIcon(),label: ""),

          BottomNavigationBarItem(icon: Icon(Icons.message_outlined ,size:30 ),label: "Message"),

          BottomNavigationBarItem(icon: Icon(Icons.person_outline_outlined ,size:30 ),label: "Profile"),

        ],
      ),


    );

  }
}