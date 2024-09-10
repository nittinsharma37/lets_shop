import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/route_manager.dart';
import 'package:lets_shop/services/initial_binding.dart';
import 'package:lets_shop/view/cart/shopping_cart_screen.dart';
import 'package:lets_shop/view/product/product_details_screen.dart';

import 'package:lets_shop/view/product/product_listing_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lets Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialBinding: InitialBinding(),
      home: ProductListingScreen(),
      getPages: [
        GetPage(name: '/productDetails', page: () => ProductDetailsScreen()),
        GetPage(name: '/products', page: () => ProductListingScreen()),
        GetPage(name: '/cart', page: () => ShoppingCartScreen()),
      ],
    );
  }
}
