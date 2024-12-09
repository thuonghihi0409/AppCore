import 'package:appcore/UI/home_screen.dart';
import 'package:appcore/UI/login_screen.dart';
import 'package:appcore/providers/auth_provider.dart';
import 'package:appcore/providers/product_provider.dart';
import 'package:appcore/providers/search_Provider.dart';
import 'package:appcore/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




void main() {

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => ProductProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => SearchProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Core',
      theme: ThemeData(
        fontFamily: 'KoHo',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
