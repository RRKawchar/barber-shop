import 'dart:async';

import 'package:berber_booking_app/local_database/local_storage.dart';
import 'package:berber_booking_app/login_demo/my_phone.dart';
import 'package:berber_booking_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SharedPreferences? pref;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Timer(const Duration(seconds: 4), () {
        screenNavigation();
      });
    });
    super.initState();
  }

  Future<void> screenNavigation() async {
    if (await LocalStorage.getLoggedInStatus()) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => MyPhoneScreen()));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
    }
  }
  Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
