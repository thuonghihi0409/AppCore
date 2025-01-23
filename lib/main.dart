import 'package:appcore/blocs/auth/auth_bloc.dart';
import 'package:appcore/blocs/product/product_bloc.dart';
import 'package:appcore/screens/home_screen.dart';
import 'package:appcore/screens/login_screen.dart';
import 'package:appcore/providers/auth_provider.dart';
import 'package:appcore/providers/payment_method_provider.dart';
import 'package:appcore/providers/product_provider.dart';
import 'package:appcore/providers/search_Provider.dart';
import 'package:appcore/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';




void main() {

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(CheckAuthStatusEvent()),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc()..add(LoadProducts()),
        )      
      ],
      child: MyApp(),
    ),);
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
        useMaterial3: true

      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
