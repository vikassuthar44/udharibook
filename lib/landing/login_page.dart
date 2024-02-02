import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_khata/home/home_page.dart';
import 'package:easy_khata/landing/register_page.dart';
import 'package:easy_khata/profile/own_profile.dart';
import 'package:easy_khata/util/assets_path.dart';
import 'package:easy_khata/util/common_widget/custom_button.dart';
import 'package:easy_khata/util/common_widget/custom_text_field.dart';
import 'package:easy_khata/util/common_widget/page_route.dart';
import 'package:easy_khata/util/common_widget/text_field.dart';
import 'package:easy_khata/util/myshared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneTextController = TextEditingController();
  final otpTextController = TextEditingController();
  bool isOTPFieldVisible = false;
  String submitLabel = "Send OTP";
  bool otpSent = false;
  bool submitBtnEnable = false;
  bool isButtonLoading = false;
  late String otpVerificationId;

  // Function to send verification code to the user's mobile number
  Future<void> verifyPhone(String phoneNumber) async {
    setState(() {
      isButtonLoading = true;
    });
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatic verification if possible
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        Fluttertoast.showToast(msg: 'Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verification ID to be used later
        // Usually, you'd save this in the state or somewhere secure
        print('Code sent. Verification ID: $verificationId');
        setState(() {
          otpVerificationId = verificationId;
          otpSent = true;
          submitLabel = "Verify OTP";
          isOTPFieldVisible = true;
          submitBtnEnable = false;
        });
        Fluttertoast.showToast(msg: 'Code sent on $phoneNumber');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Called when the code auto-retrieval has timed out
        /*Fluttertoast.showToast(
            msg:
            'Code auto-retrieval timed out. Verification ID: $verificationId');*/
      },
    );
    setState(() {
      isButtonLoading = false;
    });
  }

  // Function to verify the entered code
  Future<void> verifyCode(String verificationId, String code) async {
    print("verification ID: $verificationId  and Code $code");
    setState(() {
      isButtonLoading = true;
    });
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: code,
    );

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      Fluttertoast.showToast(msg: 'Phone number verified successfully!');
      if (userCredential.additionalUserInfo!.isNewUser) {
        CollectionReference user =
            FirebaseFirestore.instance.collection('users');

        DocumentReference userDocRef = user.doc(userCredential.user?.uid);

        DocumentReference documentReference = FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid);

        userDocRef.set(OwnProfile.toJson(OwnProfile(
            userId: userCredential.user!.uid,
            name: "",
            phoneNumber: phoneTextController.text,
            totalAmountGet: 0.0,
            totalAmountGive: 0.0,
            otherUsers: [])));
      }
      MySharedPreference.setTotalAmountGet("0.0");
      MySharedPreference.setTotalAmountGive("0.0");
      MySharedPreference.setUserLogin(true);
      MySharedPreference.setUserId(userCredential.user!.uid);
      MySharedPreference.setPhoneNumber(phoneTextController.text);
      MySharedPreference.setUserName("");
      Navigator.of(context).pushReplacement(
          PageRouteClass.createRoute(const HomePage(title: "Easy Khata")));
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error verifying phone number: $e');
      print('Error verifying phone number: $e');
    }
    setState(() {
      isButtonLoading = false;
    });
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
                    .animate()
                    .fadeIn(duration: 0.2.seconds, delay: 0.1.seconds),
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
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
                      CustomTestField(
                        submitBtnEnable: submitBtnEnable,
                        labelText: "Mobile Number",
                        hintText: "Enter Mobile number here...",
                        maxLength: 10,
                        textInputType: TextInputType.phone,
                        textEditingController: phoneTextController,
                        onChange: (text) {
                          if (text.length >= 10) {
                            setState(() {
                              submitBtnEnable = true;
                            });
                          } else {
                            setState(() {
                              submitBtnEnable = false;
                            });
                          }
                        },
                        prefixIcon: Icons.phone,
                      ),
                      SizedBox(
                        height: screenSize.height * .02,
                      ),
                      Visibility(
                          visible: isOTPFieldVisible,
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 2),
                            child: CustomTestField(
                              submitBtnEnable: submitBtnEnable,
                              labelText: "OTP",
                              hintText: "Enter OTP here...",
                              maxLength: 6,
                              textInputType: TextInputType.phone,
                              textEditingController: otpTextController,
                              onChange: (text) {
                                if (text.length >= 6) {
                                  setState(() {
                                    submitBtnEnable = true;
                                  });
                                } else {
                                  setState(() {
                                    submitBtnEnable = false;
                                  });
                                }
                              },
                              prefixIcon: Icons.password,
                            ),
                          )),
                      SizedBox(
                        height: screenSize.height * .03,
                      ),
                      CustomButton(
                        onTap: () {
                          if (submitBtnEnable) {
                            if (phoneTextController.text.isNotEmpty &&
                                phoneTextController.text.length == 10) {
                              if (otpSent) {
                                if (otpTextController.text.isNotEmpty &&
                                    otpTextController.text.length == 6) {
                                  verifyCode(otpVerificationId,
                                      otpTextController.text);
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "OTP is not valid please check again!");
                                }
                              } else {
                                verifyPhone(phoneTextController.text);
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Phone not valid please check again!");
                            }
                          }
                        },
                        isLoading: isButtonLoading,
                        isButtonEnable: submitBtnEnable,
                        buttonLabel: isOTPFieldVisible == true
                            ? "Verify OTP"
                            : 'Send OTP',
                      )
                    ],
                  ),
                ).animate().fadeIn(duration: 0.2.seconds, delay: 0.5.seconds),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
