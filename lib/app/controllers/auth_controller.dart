import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // FirebaseAuth instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Reactive user to track the authenticated user state
  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    // Bind the user stream to track authentication changes
    firebaseUser.bindStream(auth.authStateChanges());
  }

  /// Register a new user with email and password
  Future<void> register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar(
        "Registration Successful",
        "You have successfully registered.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor.withOpacity(0.7),
        colorText: Get.theme.cardColor,
      );
      Get.offAllNamed('/productList'); // Navigate to the product list
    } catch (e) {
      _handleAuthError(e, "Registration Error");
    }
  }

  /// Sign in an existing user with email and password
  Future<void> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar(
        "Login Successful",
        "Welcome back!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor.withOpacity(0.7),
        colorText: Get.theme.cardColor,
      );
      Get.offAllNamed('/productList'); // Navigate to the product list
    } catch (e) {
      _handleAuthError(e, "Login Error");
    }
  }

  /// Sign out the current user
  Future<void> signOut() async {
    try {
      await auth.signOut();
      Get.snackbar(
        "Signed Out",
        "You have been logged out.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor.withOpacity(0.7),
        colorText: Get.theme.cardColor,
      );
      Get.offAllNamed('/login'); // Navigate to the login screen
    } catch (e) {
      _handleAuthError(e, "Sign Out Error");
    }
  }

  /// Handle authentication errors
  void _handleAuthError(dynamic error, String title) {
    Get.snackbar(
      title,
      error.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.primaryColor.withOpacity(0.7),
      colorText: Get.theme.cardColor,
    );
  }
}
