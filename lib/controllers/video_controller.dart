


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
    _videoList.value.sort((a,b) => a.uploadedAt.compareTo(b.uploadedAt));
    _videoList.bindStream(firestore.collection("videos").orderBy("uploadedAt",descending: true).snapshots().map((QuerySnapshot snapshot){
      List<Video> retVal = [];
      for (var element in snapshot.docs) {
        retVal.add(
          Video.fromSnap(element),
        );

      }
      return retVal;
    }));
  }


  likeVideo(String id) async{
  DocumentSnapshot doc = await firestore.collection("videos").doc(id).get();
  var uid = authController.user.uid;

  if((doc.data()! as dynamic )['likes'].contains(uid))
    {
      await firestore.collection("videos").doc(id).update({
        'likes':FieldValue.arrayRemove([uid])
      });
    }else
      {
        await firestore.collection("videos").doc(id).update({
          'likes':FieldValue.arrayUnion([uid])
        });
      }
  }




}