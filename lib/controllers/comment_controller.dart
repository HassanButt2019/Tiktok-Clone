


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ticktok_clone/constants.dart';
import 'package:ticktok_clone/models/comment_model.dart';

class CommentController extends GetxController
{

  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);

  List<Comment> get comments => _comments.value;

  String _postId = "";

  updatePostId(String id)
  {
    _postId = id;
    getComments();
  }

  getComments()async
  {
    _comments.bindStream(
    firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .snapshots()
        .map(
          (QuerySnapshot query) {
        List<Comment> retValue = [];
        for (var element in query.docs) {
          retValue.add(Comment.fromSnap(element));
        }
        return retValue;
      },
    ),
  );

  }

  postComments(String commentText)async
  {
    try{
    if(commentText.isNotEmpty) {
      DocumentSnapshot userDoc = await firestore.collection("user").doc(
          authController.user.uid).get();
      var allDocs = await firestore.collection("videos")
          .doc(_postId)
          .collection("comments")
          .get();
      int length = allDocs.docs.length;
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('MM-dd-yyyy HH:mm:ss').format(now);
      Comment comment = Comment(
          datePublished: formattedDate,
          username: (userDoc.data()! as dynamic)["name"].toString(),
          uid: authController.user.uid,
          id: 'Comment $length',
          comment: commentText.toString().trim(),
          profilePhoto: (userDoc.data()! as dynamic)["profileImage"].toString(),
          likes: []

      );

      await firestore.collection("videos").
      doc(_postId).
      collection("comments").
      doc("Comment $length").
      set(comment.toJson());
      }

    DocumentSnapshot doc =
    await firestore.collection('videos').doc(_postId).get();
    await firestore.collection('videos').doc(_postId).update({
      'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
    });

  }catch(err)
  {
    Get.snackbar("Error in Posting Comment", "Unable To Post Your Comment Because "+ err.toString());
  }
  }



  likeComment(String id) async
  {
    var uid = authController.user.uid;
    DocumentSnapshot doc = await firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }

  }



}