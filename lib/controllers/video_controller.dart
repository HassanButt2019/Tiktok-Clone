


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ticktok_clone/constants.dart';
import 'package:ticktok_clone/models/video_model.dart';

class VideoController extends GetxController
{
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  List<Video> get videoList => _videoList.value;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _videoList.bindStream(firestore.collection("videos").snapshots().map((QuerySnapshot snapshot){
      List<Video> retVal = [];
      for (var element in snapshot.docs) {
        retVal.add(
          Video.fromSnap(element),
        );
      }
      return retVal;
    }));
  }

}