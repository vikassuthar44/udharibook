import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProvider extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  late String verificationId;

  Future<void> verifyPhone(String countryCode, String mobile) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: countryCode + mobile,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatic verification if possible
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          Fluttertoast.showToast(msg: 'Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          // Save the verification ID to be used later
          // Usually, you'd save this in the state or somewhere secure
          this.verificationId = verificationId;
          print('Code sent. Verification ID: $verificationId');
          Fluttertoast.showToast(msg: 'Code sent on $mobile');
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> verifyOTP(String otp) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      final Future<UserCredential> userCredential = _firebaseAuth.signInWithCredential(credential);
      final User? currentUser = (await userCredential).user;
      if (currentUser?.uid != "") {
        print(currentUser?.uid);
      }
      return userCredential;
    } catch (e) {
      Fluttertoast.showToast(msg: "Something Went Wrong $e");
      return null;
    }
  }

  showError(error) {
    throw error.toString();
  }
}
