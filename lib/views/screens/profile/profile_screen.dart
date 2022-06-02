import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticktok_clone/constants.dart';
import 'package:ticktok_clone/controllers/profile_controller.dart';
import 'package:ticktok_clone/views/widgets/network_image.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    profileController.updateUserId(widget.uid);
    profileController.getUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black12,
              leading: const Icon(
                Icons.person_add_alt_1_outlined,
              ),
              actions: const [
                Icon(Icons.more_horiz),
              ],
              title: Center(
                child: Text(
                  profileController.user["name"].toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: CustomNetworkImage(imgUrl:  profileController.user["profileImage"]
                                .toString(),)
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                profileController.user["following"],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Following",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                profileController.user["followers"].toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Followers",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                profileController.user["likes"],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Likes",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.uid == authController.user.uid
                              ? Column(
                                  children: [
                                    Switch(
                                        activeColor: Colors.red,
                                        value: true,
                                        onChanged: (value) {}),
                                    Text(
                                      "Private",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBox(
                            width: 50,
                          ),
                          Obx(() {
                            print('Proflie screen   ${controller.isFollowing.value}');
                              return TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        controller.isFollowing.value
                                            ? Colors.black
                                            : Colors.red)),
                                onPressed: () => {

                                  if (widget.uid == authController.user.uid)
                                    {authController.signOut()}
                                  else
                                    {
                                      controller.isFollowing.toggle(),
                                      controller.followUser()

                                    }


                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        widget.uid == authController.user.uid
                                            ? 'Sign Out'
                                            : controller.isFollowing.value
                                                ? 'Unfollow'
                                                : 'Follow',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(child: Obx(() {
                                      return authController.isLoading.value
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 3,
                                            )
                                          : Container();
                                    })),
                                  ],
                                ),
                              );
                            }
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      controller.user['thumbnails'].length != 0
                          ? GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.user['thumbnails'].length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 3 / 2,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemBuilder: (context, index) {
                                String thumbnail =
                                    controller.user['thumbnails'][index];
                                return CachedNetworkImage(
                                  imageUrl: thumbnail,
                                  fit: BoxFit.fill,
                                );
                              },
                            )
                          : const Center(
                              child: Text(
                                'User Has No Videos',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                    ],
                  ),
                ],
              ),
            )),
          );
        });
  }
}
