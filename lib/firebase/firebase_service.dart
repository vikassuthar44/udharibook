import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_khata/profile/own_profile.dart';
import 'package:easy_khata/util/myshared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirebaseService {
  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  static Future<List<OtherUser>?> getOwnProfileDetails() async {
    try {
      print("called getOwnProfileDetails");
      String? userId = MySharedPreference.getUserId();
      print("called getOwnProfileDetails userID $userId");
      // Get a reference to the collection
      CollectionReference collectionRef = _fireStore.collection("users");

      // Get a reference to the specific document using its ID
      DocumentReference documentRef = collectionRef.doc(userId);

      // Fetch the document data
      DocumentSnapshot documentSnapshot = await documentRef.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        print("Document Exist");
        // Access the data using documentSnapshot.data()
        //final allData = documentSnapshot.da.map((doc) => doc.data()).toList();
        Map<String, dynamic> dataMap =
            documentSnapshot.data() as Map<String, dynamic>;
        print("dataMap $dataMap");
        OwnProfile userDetailsData = OwnProfile.fromJson(dataMap);
        print("userDetailsData $userDetailsData");
        MySharedPreference.setTotalAmountGet(
            userDetailsData.totalAmountGet.toString());
        MySharedPreference.setTotalAmountGive(
            userDetailsData.totalAmountGive.toString());
        //Common.setUserDetails(userDetails);
        print("OwnProfile $userDetailsData");
        return userDetailsData.otherUsers;
      } else {
        print('Document does not exist');
      }
      print("Error found");
      return null;
    } catch (e) {
      print("Eception $e");
    }
    return null;
  }

  static Future<void>? addCustomer(String name, String phoneNumber) async {
    try {
      String? userId = MySharedPreference.getUserId();
      // Get a reference to the collection
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection("users");

      // Get a reference to the specific document using its ID
      DocumentReference documentRef = collectionRef.doc(userId);

      // Fetch the document data
      DocumentSnapshot documentSnapshot = await documentRef.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        await documentRef.update({
          'otherUsers': FieldValue.arrayUnion([
            OtherUser.toJson(OtherUser(
                userId: const Uuid().v4(),
                name: name,
                phoneNumber: phoneNumber,
                totalAmountGive: 0.0,
                totalAmountGet: 0.0,
                amountHistory: []))
          ]),
        });
      } else {
        print('Document does not exist');
        return;
      }
    } on Exception catch (_) {
      return;
    }
  }

  static Future<void> addAmountHistory(String userId, String amount,
      String description, bool isCredit, String dateTime) async {
    String? ownUserId = MySharedPreference.getUserId();
    
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("collectionPath")
  }

/*static Future<void> addAmountHistory(String userId, String amount,
      String description, bool isCredit, String dateTime) async {
    try {
      String? ownUserId = MySharedPreference.getUserId();
      //print("addAmountHistory userID $userId");
      // Get a reference to the collection
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection("users");

      // Get a reference to the specific document using its ID
      DocumentReference documentRef = collectionRef.doc(ownUserId);

      // Fetch the document data
      DocumentSnapshot documentSnapshot = await documentRef.get();

      print("addAmountHistory userID $userId");
      // Check if the document exists
      if (documentSnapshot.exists) {
        Map<String, dynamic> dataMap =
            documentSnapshot.data() as Map<String, dynamic>;

        // Find the user by userId
        Map<String, dynamic>? userToUpdate;
        int userIndex = -1;

        for (int i = 0; i < dataMap['otherUsers'].length; i++) {
          if (dataMap['otherUsers'][i]['userId'] == userId) {
            userToUpdate = dataMap['otherUsers'][i];
            userIndex = i;
            break;
          }
        }

        */ /*userToUpdate?['amountHistory'].add({
          AmountHistory.toJson(AmountHistory(
              amount: double.parse(amount),
              isCredit: isCredit,
              dateTime: dateTime,
              description: description))
        });*/ /*

        // Update the user in the existingData
        //dataMap['otherUsers'][userIndex] = userToUpdate;

        // Update the collection in Firebase
        //await documentRef.set(dataMap);
        List<OtherUser> otherUsers =
        await documentRef.update({
          'otherUsers': FieldValue.arrayUnion([

          ])
        });

        */ /*OwnProfile ownProfile = OwnProfile.fromJson(dataMap);
        // Find the OtherUser whose userId matches the specified userId
        //OtherUser? targetOtherUser = ownProfile.otherUsers?.firstWhereOrNull((user) => user.userId == otherUserId);
        print("addAmountHistory dataMap $dataMap");
        OtherUser otherUser = ownProfile.otherUsers!
            .firstWhere((otherUser) => otherUser.userId == userId);
        print("addAmountHistory other user before $otherUser");
        otherUser.amountHistory!.add(
            //AmountHistory.toJson(
            AmountHistory(
                amount: double.parse(amount),
                isCredit: isCredit,
                description: description,
                dateTime: dateTime
                //)
                ));

        print("addAmountHistory other user list after ${otherUser.amountHistory}");
        await documentRef.set({
          'otherUsers': FieldValue.arrayUnion([
            otherUser
            */ /* */ /*OtherUser.toJson(OtherUser(
                userId: ,
                name: name,
                phoneNumber: phoneNumber,
                totalAmountGive: 0.0,
                totalAmountGet: 0.0,
                amountHistory: []))*/ /* */ /*
          ]),
        });*/ /*
        print("addAmountHistory amount updated");
      } else {
        print('addAmountHistory Document does not exist');
        return;
      }
    } on Exception catch (_) {
      print("addAmountHistory Exception Getting $_");
      return;
    }
  }*/
}
