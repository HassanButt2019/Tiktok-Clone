


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ticktok_clone/constants.dart';
import 'package:ticktok_clone/models/video_model.dart';
import 'package:ticktok_clone/views/screens/home/home_screen.dart';
import 'package:ticktok_clone/views/screens/videos/video_screen.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController
{

  RxBool isLoading = false.obs;



  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.HighestQuality,
    );
    return compressedVideo!.file;
  }

  Future<String> _uploadVideoToStorage(String id , String path) async
  {
    Reference ref = firebaseStorage.ref().child("videos").child(id);
    UploadTask uploadTask = ref.putFile(await _compressVideo(path));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }


  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
  //upload video
  uploadView(String name , String caption , String path)async
  {
    try{
      isLoading.toggle();
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc = await firestore.collection("user").doc(uid).get();
      var allDoc = await firestore.collection("videos").get();
      int length = allDoc.docs.length;
      String url = await  _uploadVideoToStorage("Video $length",path);
      String thumbnail = await _uploadImageToStorage("Video $length", path);
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('MM-dd-yyyy HH:mm:ss').format(now);


      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)['name'].toString(),
        uid: uid.toString(),
        id: "Video $length",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: name.toString(),
        caption: caption.toString(),
        videoUrl: url.toString(),
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profileImage'].toString(),
        thumbnail: thumbnail.toString(),
          uploadedAt:formattedDate

      );

      await firestore.collection('videos').doc('Video $length').set(
        video.toJson(),
      );

      Get.offAll(()=>const HomeScreen());



    }catch(err)
    {
      Get.snackbar(
        'Error Uploading Video',
        err.toString(),
      );
    }

    isLoading.toggle();
  }
}