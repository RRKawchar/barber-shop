import 'package:berber_booking_app/login_demo/my_phone.dart';
import 'package:berber_booking_app/login_demo/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Berber Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const SplashScreen()
    );
  }


}

