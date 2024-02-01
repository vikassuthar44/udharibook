import 'package:easy_khata/landing/register_page.dart';
import 'package:easy_khata/util/assets_path.dart';
import 'package:easy_khata/util/common_widget/page_route.dart';
import 'package:easy_khata/util/common_widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void onGoogleLoginClick() async {
    print("google login");
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        padding: EdgeInsets.all(screenSize.width * 0.05),
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 200,
                    width: screenSize.width,
                    child: Image.asset('assets/app_logo.png'))
                    .animate().fadeIn(duration: 0.2.seconds, delay: 0.1.seconds),
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
                ).animate().fadeIn(duration: 0.2.seconds, delay: 0.3.seconds),
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
                        'Login Account',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: screenSize.height * .02,
                      ),
                      InputTextField(
                        prefix: Icons.email,
                        hintText: 'enter email id here...',
                          isMobileNumber: false,
                          isPassword: false,
                          keyboardType: TextInputType.emailAddress,
                          textEditingController: emailTextController
                      ),
                      InputTextField(
                          prefix: Icons.password,
                          hintText: 'enter password here...',
                          isMobileNumber: false,
                          isPassword: true,
                          keyboardType: TextInputType.emailAddress,
                          textEditingController: emailTextController
                      ),
                      SizedBox(
                        height: screenSize.height * .01,
                      ),
                      Container(
                        width: screenSize.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 0.2.seconds, delay: 0.5.seconds),
                SizedBox(
                  height: screenSize.height * .01,
                ),
                const Center(
                  child: Text('or login with'),
                ).animate().fadeIn(duration: 0.2.seconds, delay: 0.7.seconds),
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
                        onClick: () {
                          print("sadasDAs");
                          onGoogleLoginClick();
                        },
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 0.2.seconds, delay: 0.9.seconds),
                SizedBox(
                  height: screenSize.height * .03,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Create new Account", style: Theme.of(context).textTheme.bodyLarge, ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              PageRouteClass.createRoute(const RegisterPage()));
                        },
                        child: Text(" Sign-Up", style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary
                        ), ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 0.2.seconds, delay: 0.11.seconds),
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
