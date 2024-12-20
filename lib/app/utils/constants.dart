import 'package:flutter/material.dart';

class AppConstants {
  // Firebase Node Names
  static const String productsNode = 'products';
  static const String usersNode = 'users';
  static const String ordersNode = 'orders';

  // Firebase Auth Error Messages
  static const Map<String, String> firebaseErrors = {
    "ERROR_INVALID_EMAIL": "Your email address appears to be invalid.",
    "ERROR_WRONG_PASSWORD": "Your password is incorrect.",
    "ERROR_USER_NOT_FOUND": "User with this email doesn't exist.",
    "ERROR_USER_DISABLED": "User with this email has been disabled.",
    "ERROR_TOO_MANY_REQUESTS": "Too many requests. Try again later.",
    "ERROR_OPERATION_NOT_ALLOWED": "Signing in with Email/Password is not enabled.",
    "CONFIGURATION_NOT_FOUND": "Firebase configuration not found.",
  };

  // Default App Colors
  static const Color primaryColor = Color(0xFF6C63FF); // Customize for your theme
  static const Color secondaryColor = Color(0xFFF2F2F2);
  static const Color accentColor = Color(0xFF3C3F58);

  // Default Images
  static const String placeholderImage =
      'https://via.placeholder.com/150/FFFFFF/000000?text=No+Image';

  // UI Constants
  static const double defaultPadding = 16.0;
}
