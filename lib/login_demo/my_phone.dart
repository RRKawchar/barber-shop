import 'package:berber_booking_app/login_demo/my_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyPhoneScreen extends StatefulWidget {
  const MyPhoneScreen({Key? key}) : super(key: key);
  static String verify = "";
  @override
  State<MyPhoneScreen> createState() => _MyPhoneScreenState();
}

class _MyPhoneScreenState extends State<MyPhoneScreen> {
  TextEditingController countryCode = TextEditingController();
  var phone = "";

  @override
  void initState() {
    countryCode.text = "+880";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/banner/my_bg.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countryCode,
                          keyboardType: TextInputType.phone,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      const Text(
                        '|',
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextField(
                        onChanged: (value) {
                          phone = value;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                        ),
                      ))
                    ],
                  ),
                )),
            Container(
              padding: const EdgeInsets.all(16.0),
              width: size.width,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () async {
                  if (phone.isEmpty) {
                    Fluttertoast.showToast(msg: "Enter your phone number");
                  } else {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '${countryCode.text + phone}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          MyPhoneScreen.verify = verificationId;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MyVerificationScreen()));
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {});
                  }
                },
                icon: const Icon(Icons.phone),
                label: const Text("LOGIN WITH PHONE"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
