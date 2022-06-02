


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ticktok_clone/constants.dart';
import 'package:ticktok_clone/controllers/comment_controller.dart';
import 'package:ticktok_clone/widgets/network_image.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final id;
   CommentScreen({Key? key,required this.id}) : super(key: key);

  final TextEditingController controller = TextEditingController();
  CommentController commentController = Get.put(CommentController());


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width:size.width ,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                  child:Obx((){
                      return ListView.builder(
                        itemCount: commentController.comments.length,
                        itemBuilder: (context , index){
                          final comment = commentController.comments[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: CustomNetworkImage(imgUrl: comment.profilePhoto),
                             ),
                            title: Row(
                              children: [
                                Text(comment.username,style: TextStyle(fontSize: 18 , color: Colors.red , fontWeight: FontWeight.w700),),
                                const SizedBox(width: 15,),
                                Text(comment.comment,maxLines: 5,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16 , color: Colors.white , fontWeight: FontWeight.normal),),

                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text(tago.format(DateFormat("MM-dd-yyyy HH:mm:ss").parse(comment.datePublished)),style:const TextStyle(fontSize: 12 , color: Colors.white ,
                                    fontWeight: FontWeight.w500),),
                                const SizedBox(width: 15,),
                                Text("${comment.likes.length.toString()} Likes",style:const TextStyle(fontSize: 12 , color: Colors.white , fontWeight: FontWeight.w500),),


                              ],
                            ),

                            trailing: InkWell(
                                onTap:()=>commentController.likeComment(comment.id),
                                child: Icon(comment.likes.contains(authController.user.uid)?Icons.favorite:Icons.favorite_outline , size: 25,color:comment.likes.contains(authController.user.uid)? Colors.red:Colors.white,)),
                          );
                        },
                      );
                    }
                  )
              ),

              const Divider(),
              ListTile(
                title:TextFormField(
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Comment',
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
                ),
                trailing: TextButton(
                  onPressed: () => commentController.postComments(controller.text),
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),

              )
            ],

          ),
        ),
      ),
    );
  }
}
