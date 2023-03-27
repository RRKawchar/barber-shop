
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);
  static String verify="";
  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  bool otpFieldVisibility=false;
  TextEditingController countryCode = TextEditingController();
  var phone = "";
  var receivedID = '';
  FirebaseAuth auth = FirebaseAuth.instance;
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
            // Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       height: 55,
            //       decoration: BoxDecoration(
            //         border: Border.all(width: 1, color: Colors.grey),
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           const SizedBox(
            //             width: 10,
            //           ),
            //           SizedBox(
            //             width: 40,
            //             child: TextField(
            //               controller: countryCode,
            //               keyboardType: TextInputType.phone,
            //               decoration:
            //                   const InputDecoration(border: InputBorder.none),
            //             ),
            //           ),
            //           const Text('|',style: TextStyle(fontSize: 33,color: Colors.grey),),
            //
            //           const SizedBox(width: 10,),
            //           Expanded(child: TextField(
            //             onChanged: (value){
            //               phone=value;
            //             },
            //              keyboardType: TextInputType.phone,
            //             decoration: const InputDecoration(
            //               border: InputBorder.none,
            //               hintText: "Phone",
            //
            //             ),
            //           ))
            //         ],
            //       ),
            //     )),
            Container(
              padding: const EdgeInsets.all(16.0),
              width: size.width,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: (){
                    if(otpFieldVisibility){
                      verifyOTPCode();
                    } else{
                      verifyUserPhoneNumber();
                    }
                    FocusManager.instance.primaryFocus?.unfocus();
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

  Future<void> verifyOTPCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: receivedID,
      smsCode: countryCode.text,
    );
    await auth
        .signInWithCredential(credential)
        .then((value) => print('User Login In Successful'));
  }

  void verifyUserPhoneNumber()async{
    await auth.verifyPhoneNumber(
      phoneNumber: countryCode.text+phone,
      verificationCompleted: (PhoneAuthCredential credential) async{
        await auth.signInWithCredential(credential).then(
              (value) => print('Logged In Successfully'),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        receivedID = verificationId;

        setState(() {});
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const PhoneScreen()));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('TimeOut');
      },
    );
  }

   // processLogin(BuildContext context) {
   //
   //  var user=FirebaseAuth.instance.currentUser;
   //
   //  if(user==null){
   //    FirebaseAuthUi.instance().launchAuth([AuthProvider.phone()]).then((firebaseUser){
   //
   //    });
   //  }
   // }
}
