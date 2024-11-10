import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_ecommerce_app/navigation/main_navigation.dart';
import 'package:sample_ecommerce_app/providers/cart_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: MainNavigation(),
      // home: ProductDetailScreen(),
    );
  }
}

