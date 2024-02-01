import 'package:easy_khata/landing/login_page.dart';
import 'package:easy_khata/util/assets_path.dart';
import 'package:easy_khata/util/common_widget/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../util/common_widget/page_route.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();


  Future<UserCredential?> _handleSignIn() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      return await auth.signInWithCredential(credential);
    } catch (error) {
      print("Google Sign-In Error: $error");
      return null;
    }
  }

  void createAccount() {
    print("Entered data ${emailTextController.text}");
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        padding: EdgeInsets.symmetric(horizontal:screenSize.width * 0.05),
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 150,
                    width: screenSize.width,
                    child: Image.asset('assets/app_logo.png'))
                    .animate().fadeIn(duration: 0.2.seconds, delay: 0.1.seconds).slideY(),
                SizedBox(
                  width: screenSize.width,
                  child: Center(
                    child: Text(
                      "Easy Khata Book",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ).animate().fadeIn(duration: 0.2.seconds, delay: 0.3.seconds).slideY(),
                SizedBox(
                  height: screenSize.height * .01,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Text(
                        'Create Account',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ).animate().fadeIn(duration: 0.2.seconds, delay: 0.4.seconds).slideY(),
                      SizedBox(
                        height: screenSize.height * .02,
                      ),
                      InputTextField(
                          prefix: Icons.business,
                          hintText: 'enter business or your name here...',
                          isMobileNumber: false,
                          isPassword: false,
                          keyboardType: TextInputType.emailAddress,
                          textEditingController: emailTextController
                      ).animate().fadeIn(duration: 0.2.seconds, delay: 0.5.seconds).slideY(),
                      InputTextField(
                          prefix: Icons.email,
                          hintText: 'enter email id here...',
                          isMobileNumber: false,
                          isPassword: false,
                          keyboardType: TextInputType.emailAddress,
                          textEditingController: emailTextController
                      ).animate().fadeIn(duration: 0.2.seconds, delay: 0.6.seconds).slideY(),
                      InputTextField(
                          prefix: Icons.password,
                          hintText: 'enter password here...',
                          isMobileNumber: false,
                          isPassword: true,
                          keyboardType: TextInputType.emailAddress,
                          textEditingController: emailTextController
                      ).animate().fadeIn(duration: 0.2.seconds, delay: 0.7.seconds).slideY(),
                      InputTextField(
                          prefix: Icons.phone,
                          hintText: 'your mobile here...',
                          isMobileNumber: true,
                          isPassword: false,
                          keyboardType: TextInputType.emailAddress,
                          textEditingController: emailTextController
                      ).animate().fadeIn(duration: 0.2.seconds, delay: 0.7.seconds).slideY(),
                      SizedBox(
                        height: screenSize.height * .01,
                      ),
                      InkWell(
                        onTap: () {
                          createAccount();
                        },
                        child: Container(
                          width: screenSize.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              'Create Account',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ).animate().fadeIn(duration: 0.2.seconds, delay: 0.7.seconds).slideY(),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 0.2.seconds, delay: 0.5.seconds),
                SizedBox(
                  height: screenSize.height * .01,
                ),
                const Center(
                  child: Text('or signup with'),
                ).animate().fadeIn(duration: 0.2.seconds, delay: 0.7.seconds).slideY(),
                SizedBox(
                  height: screenSize.height * .01,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialLogin(
                        label: "Google",
                        image: AssetsPath.googleIcon,
                        onClick: () async {
                          UserCredential? userCredential = await _handleSignIn();
                          if (userCredential != null) {
                            print("Google Sign-In Successful! User ID: ${userCredential.user?.uid}");
                          } else {
                            print("Google Sign-In Failed.");
                          }

                        },
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 0.2.seconds, delay: 0.9.seconds).slideY(),
                SizedBox(
                  height: screenSize.height * .03,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("already an account?", style: Theme.of(context).textTheme.bodyLarge, ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              PageRouteClass.createRoute(const LoginPage()));
                        },
                        child: Text(" Login", style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary
                        ), ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 0.2.seconds, delay: 0.11.seconds).slideY(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocialLogin extends StatelessWidget {
  const SocialLogin(
      {super.key,
        required this.label,
        required this.image,
        required this.onClick});

  final String label;
  final String image;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("sadasdsa");
        onClick.call();
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width*0.6,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              height: 20,
              width: 20,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
