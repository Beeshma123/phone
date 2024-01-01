import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'otp1.dart';

class MyPhone extends StatefulWidget {
  static String verify="";


  const MyPhone({Key? key}) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  var phone ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: Text("AB-APP"),
        centerTitle: true,
      ),
        body:Center(
        child:SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/login.gif"),
    SizedBox(
      height: 30,
    ),
    Text( "Enter Your Phone Number",style: TextStyle(fontSize:25,fontWeight: FontWeight.bold),),
    Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          onChanged: (value){
            phone=value;
          },
    decoration: InputDecoration(
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
    ),
   hintText: "Enter your Phone Number ",
    ),
    ),
    ),
      SizedBox(
     height: 30,
      ),
      ElevatedButton(
        onPressed: ()async {
          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: '+91$phone',
            verificationCompleted: (PhoneAuthCredential credential) {},
            verificationFailed: (FirebaseAuthException e) {},
            codeSent: (String verificationId, int? resendToken) {
              MyPhone.verify=verificationId;
              Navigator.pushNamed(context, "otp");
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
          );
          }, child: Text("Send Code") ),

          ],
      ),
    ),
        ),
    );
  }
}
