import 'package:electromart/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());// Ensure Firebase is initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false, // Removes debug banner
      theme: AppTheme.lightTheme, // Light theme for the app
       // Optional dark theme
      themeMode: ThemeMode.system, // Switch theme based on system preference
      initialRoute: Routes.REGISTER, // Starting route for the app
      getPages: AppPages.pages, // Define navigation routes
      defaultTransition: Transition.fade, // Optional: transition effect
      locale: const Locale('en', 'US'), // Default app language
      translationsKeys: {}, // Optional: Localization keys
    );
  }
}
