import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  void signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/productList');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void signOut() async {
    await auth.signOut();
    Get.offAllNamed('/login');
  }
}
