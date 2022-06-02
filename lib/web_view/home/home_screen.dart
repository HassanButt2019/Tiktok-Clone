

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ticktok_clone/constants.dart';
import 'package:ticktok_clone/views/message_screen/message_screen.dart';
import 'package:ticktok_clone/views/profile/profile_screen.dart';
import 'package:ticktok_clone/views/videos/video_screen.dart';
import 'package:ticktok_clone/web_view/message_screen/message_screen.dart';
import 'package:ticktok_clone/web_view/videos/video_screen.dart';
import 'package:ticktok_clone/widgets/custom_icon.dart';

class KWebHomeScreen extends StatefulWidget {
  const KWebHomeScreen({Key? key}) : super(key: key);

  @override
  State<KWebHomeScreen> createState() => _KWebHomeScreenState();
}

class _KWebHomeScreenState extends State<KWebHomeScreen> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    Size mediaData = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: mediaData .width*0.20,
            child:KWebMessageScreen() ,
          ),

          SizedBox(
            width: mediaData .width*0.60,
            child: Card(
              elevation:0.5,
                child: KWebVideoScreen()),
          ),
        ],
      ),
    );

  }
}