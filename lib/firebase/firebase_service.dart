
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_khata/profile/own_profile.dart';
import 'package:easy_khata/util/Cosntant.dart';
import 'package:easy_khata/util/myshared_preference.dart';
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


  static Future<OtherUser?> getOtherUser(String? userId) async {
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
        return userDetailsData.otherUsers!.firstWhere((otherUser) => otherUser.userId == userId);
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

  static Future<void> addAmountHistory(
      String? userId,
      String amount,
      String description,
      bool isCredit,
      String dateTime,
      OtherUser otherUser) async {
    String? ownUserId = MySharedPreference.getUserId();

    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(Constant.FIREBASE_COLLECTION_USER);

    DocumentReference documentReference = collectionReference.doc(ownUserId);

    DocumentSnapshot documentSnapshot = await documentReference.get();

    Map<String, dynamic> dataMap =
        documentSnapshot.data() as Map<String, dynamic>;

    // Find the user by userId
    int userIndex = -1;

    List<Map<String, dynamic>> otherUsers = [];

    for (int i = 0; i < dataMap['otherUsers'].length; i++) {
      otherUsers.add(dataMap['otherUsers'][i]);
      if (dataMap['otherUsers'][i]['userId'] == userId) {
        userIndex = i;
      }
    }

    if(isCredit) {
      otherUsers[userIndex]['totalAmountGive'] = (otherUsers[userIndex]['totalAmountGive'] as num).toDouble() + double.parse(amount);
      dataMap['totalAmountGive'] = (dataMap['totalAmountGive'] as num).toDouble() + double.parse(amount);
      MySharedPreference.setTotalAmountGive(
          (dataMap['totalAmountGive'] as num).toString());
    } else {
      otherUsers[userIndex]['totalAmountGet'] = (otherUsers[userIndex]['totalAmountGet'] as num).toDouble() + double.parse(amount);
      dataMap['totalAmountGet'] = (dataMap['totalAmountGet'] as num).toDouble() + double.parse(amount);
      MySharedPreference.setTotalAmountGet(
          (dataMap['totalAmountGet'] as num).toString());
    }

    Map<String, dynamic> newAmountHistoryData = AmountHistory.toJson(
        AmountHistory(
            amount: double.parse(amount),
            isCredit: isCredit,
            dateTime: dateTime,
            description: description));

    otherUsers[userIndex]['amountHistory'].add(newAmountHistoryData);
    await documentReference.update({
      'otherUsers': otherUsers,
      'totalAmountGet':(dataMap['totalAmountGet'] as num).toDouble(),
      'totalAmountGive': (dataMap['totalAmountGive'] as num).toDouble()
    });
  }
}
