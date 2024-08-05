import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:online_store_fl_app/screens/e_shop_home_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Box box = Hive.box('StoargeToken');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        String? token = await user.getIdToken();

        _firestore.collection('usersInfo').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'displayName': user.displayName,
          'photoURL': user.photoURL,
        });
        Get.to(() => EshopHomePage());
        box.put('userToken', token);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      final box = Hive.box('StoargeToken');
      await box.clear();

      print("User signed out and Hive data cleared.");
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
