import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inventory_management/core/services/api_service.dart';
import 'package:inventory_management/core/services/auth_service.dart';
import 'package:inventory_management/features/auth/view/login_screen.dart';
import 'package:inventory_management/features/auth/viewModel/auth_view_model.dart';
import 'package:inventory_management/features/products/view/product_screen.dart';
import 'package:inventory_management/features/products/viewModel/product_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load();
  final apiService = Apiservice();
  final authService = Authservice();

  runApp(
    MultiProvider(
      providers: [
        Provider<Apiservice>.value(value: apiService),
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(authService, apiService),
        ),
        ChangeNotifierProvider(create: (_) => Productviewmodel(apiService)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventory Management',
      initialRoute: "/login",
      routes: {"/login": (_) => LoginScreen(), "/home": (_) => ProductScreen()},
    );
  }
}
