import 'package:electromart/app/views/cart_view.dart';
import 'package:electromart/app/views/checkout_view.dart';
import 'package:electromart/app/views/product_detail_view.dart';
import 'package:electromart/app/views/product_list_view.dart';
import 'package:get/get.dart';
import '../views/login_view.dart';
import '../views/registration_view.dart'; // Import the new RegisterView

class Routes {
  static const LOGIN = '/login';
  static const REGISTER = '/register'; // Added route for registration
  static const PRODUCT_LIST = '/productList';
  static const CART = '/cart';
  static const CHECKOUT = '/checkout';
  static const PRODUCT_DETAIL = '/productDetail';
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.LOGIN, page: () => LoginView()),
    GetPage(name: Routes.REGISTER, page: () => RegistrationView()), // Added RegisterView
    GetPage(name: Routes.PRODUCT_LIST, page: () => ProductListView()),
    GetPage(name: Routes.CART, page: () => CartView()),
    GetPage(name: Routes.CHECKOUT, page: () => CheckoutView()),
    GetPage(
      name: Routes.PRODUCT_DETAIL,
      page: () => ProductDetailView(product: Get.arguments),
    ),
  ];
}
