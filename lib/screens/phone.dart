
import 'package:berber_booking_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);
  static String verify="";
  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  late String _verificationId;

  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();
  }


  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
    }

    verificationFailed(FirebaseAuthException authException) {
      print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    }

    codeSent(String verificationId, int? forceResendingToken) {
      print('Please check your phone for the verification code.');

      _verificationId = verificationId;
    }

    codeAutoRetrievalTimeout(String verificationId) {
      _verificationId = verificationId;
    }

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      print('Failed to verify phone number: $e');
    }
  }
  Future<void> _signInWithPhoneNumber(String smsCode) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
      } else {
        print('Failed to sign in with phone number.');
      }
    } catch (e) {
      print('Failed to sign in with phone number: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  hintText: 'Enter your phone number',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String phoneNumber = _phoneNumberController.text.trim();

                await _verifyPhoneNumber(phoneNumber);
              },
              child: const Text('Verify Phone Number'),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _smsController,
                decoration: const InputDecoration(
                  hintText: 'Enter the verification code',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String smsCode = _smsController.text.trim();

                await _signInWithPhoneNumber(smsCode);
              },
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   final size = MediaQuery.of(context).size;
  //   return Scaffold(
  //     body: Container(
  //       decoration: const BoxDecoration(
  //           image: DecorationImage(
  //               image: AssetImage('assets/banner/my_bg.png'),
  //               fit: BoxFit.cover)),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: [
  //           // Padding(
  //           //     padding: const EdgeInsets.all(8.0),
  //           //     child: Container(
  //           //       height: 55,
  //           //       decoration: BoxDecoration(
  //           //         border: Border.all(width: 1, color: Colors.grey),
  //           //       ),
  //           //       child: Row(
  //           //         mainAxisAlignment: MainAxisAlignment.center,
  //           //         children: [
  //           //           const SizedBox(
  //           //             width: 10,
  //           //           ),
  //           //           SizedBox(
  //           //             width: 40,
  //           //             child: TextField(
  //           //               controller: countryCode,
  //           //               keyboardType: TextInputType.phone,
  //           //               decoration:
  //           //                   const InputDecoration(border: InputBorder.none),
  //           //             ),
  //           //           ),
  //           //           const Text('|',style: TextStyle(fontSize: 33,color: Colors.grey),),
  //           //
  //           //           const SizedBox(width: 10,),
  //           //           Expanded(child: TextField(
  //           //             onChanged: (value){
  //           //               phone=value;
  //           //             },
  //           //              keyboardType: TextInputType.phone,
  //           //             decoration: const InputDecoration(
  //           //               border: InputBorder.none,
  //           //               hintText: "Phone",
  //           //
  //           //             ),
  //           //           ))
  //           //         ],
  //           //       ),
  //           //     )),
  //           Container(
  //             padding: const EdgeInsets.all(16.0),
  //             width: size.width,
  //             child: ElevatedButton.icon(
  //               style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
  //                 onPressed: (){
  //
  //                 },
  //               icon: const Icon(Icons.phone),
  //               label: const Text("LOGIN WITH PHONE"),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Future<void> verifyOTPCode() async {
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: receivedID,
  //     smsCode: countryCode.text,
  //   );
  //   await auth
  //       .signInWithCredential(credential)
  //       .then((value) => print('User Login In Successful'));
  // }
  //
  // void verifyUserPhoneNumber()async{
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: countryCode.text+phone,
  //     verificationCompleted: (PhoneAuthCredential credential) async{
  //       await auth.signInWithCredential(credential).then(
  //             (value) => print('Logged In Successfully'),
  //       );
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       print(e.message);
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       receivedID = verificationId;
  //
  //       setState(() {});
  //       Navigator.push(context, MaterialPageRoute(builder: (context)=>const PhoneScreen()));
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       print('TimeOut');
  //     },
  //   );
  // }

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
