import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);
  static String verify="";
  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
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
                      const Text('|',style: TextStyle(fontSize: 33,color: Colors.grey),),

                      SizedBox(height: 10,),
                      Expanded(child: TextField(
                        onChanged: (value){
                          phone=value;
                        },
                         keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
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
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: countryCode.text+phone,
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneScreen()));
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );

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
