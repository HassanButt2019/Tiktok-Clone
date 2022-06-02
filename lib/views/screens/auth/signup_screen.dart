



import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ticktok_clone/constants.dart';
import 'package:ticktok_clone/views/screens/auth/login_screen.dart';
import 'package:ticktok_clone/views/widgets/network_image.dart';
import 'package:ticktok_clone/views/widgets/text_input_field.dart';

class SignUpScreen extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

   SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size mediaData = MediaQuery.of(context).size;
    return SafeArea(
          child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
                child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("TikTok",
                    style: TextStyle(
                        fontSize: 65,
                        color: buttonColor,
                        fontWeight: FontWeight.w900)),
                const Text("Make and Upload Your Videos  Socialise Yourself",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200)),
                const SizedBox(height: 25),
                const Text("Register",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900)),
                 const SizedBox(
                  height: 25,
                ),
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.black,
                      child: CustomNetworkImage(imgUrl: 'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: authController.pickImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: mediaData.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _usernameController,
                    icon: Icons.email_outlined,
                    isObscure: false,
                    labelText: 'Username',
                  ),
                ),
                 const SizedBox(height: 25),
                Container(
                  width: mediaData.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _emailController,
                    icon: Icons.email_outlined,
                    isObscure: false,
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  width: mediaData.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _passwordController,
                    icon: Icons.password_outlined,
                    isObscure: true,
                    labelText: 'Password',
                  ),
                ),

               const SizedBox(height: 25),
                Container(
                  width: mediaData.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _phoneController,
                    icon: Icons.phone,
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: InkWell(
                    onTap: () => authController.registerUser(_usernameController.text,
                     _emailController.text,
                      _passwordController.text, _phoneController.text, authController.profilePhoto),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         const Text(
                            'Create User',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const  SizedBox(width: 20,),
                          Container(child: Obx((){
                            return authController.isLoading.value? const CircularProgressIndicator(color: Colors.white,):Container();})
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    InkWell(
                      onTap: ()=> Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20, color: buttonColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}