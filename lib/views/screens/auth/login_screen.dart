import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ticktok_clone/views/screens/auth/signup_screen.dart';
import 'package:ticktok_clone/views/widgets/text_input_field.dart';

import '../../../constants.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    Size mediaData = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("TikTok",
                style: TextStyle(
                    fontSize: 95,
                    color: buttonColor,
                    fontWeight: FontWeight.w900)),
            const Text("Make and Upload Your Videos  Socialise Yourself",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200)),
            const SizedBox(height: 25),
            const Text("Login",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900)),
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
                onTap: ()=> authController.loginUser(_emailController.text, _passwordController.text),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                   const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                     const  SizedBox(width: 20,),
                    
                    Container(child: Obx((){
                    return authController.isLoading.value?const CircularProgressIndicator(color: Colors.white,):Container();})
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
                  'Don\'t have an account? ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 20, color: buttonColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
