import 'package:flutter/material.dart';

import '../firebase/firebase_service.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();

}