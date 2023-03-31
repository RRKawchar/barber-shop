import 'package:berber_booking_app/local_database/local_storage.dart';
import 'package:berber_booking_app/login_demo/my_phone.dart';
import 'package:berber_booking_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyVerificationScreen extends StatefulWidget {
  const MyVerificationScreen({Key? key}) : super(key: key);

  @override
  State<MyVerificationScreen> createState() => _MyVerificationScreenState();
}

class _MyVerificationScreenState extends State<MyVerificationScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  var code = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/banner/img1.png",
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Phone Varification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                onChanged: (value) {
                  code = value;
                },
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                          verificationId: MyPhoneScreen.verify,
                          smsCode: code,
                        );

                        /// Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);
                        Navigator.pushAndRemoveUntil(
                            (context),
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (route) => false);
                             SharedPreferences prefs=await SharedPreferences.getInstance();
                             prefs.setBool('showHome', true);
                             LocalStorage.setLoggedInStatus(false);
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

                      } catch (e) {
                        print("Wrong Otp");
                      }
                    },
                    child: const Text("Verify Phone Number")),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  const MyPhoneScreen()),
                            (route) => false);
                      },
                      child: const Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
