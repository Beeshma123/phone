import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone/phone.dart';
import 'package:pinput/pinput.dart';

import 'home.dart';

void main() => runApp(Otp1());

class Otp1 extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var code = "";
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        hintColor: Colors.green,
      ),
      home: Scaffold(
        body: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter your OTP",
              style: TextStyle(fontSize:25,fontWeight: FontWeight.bold),
                ),
                SizedBox(
                    height: 20),
                Pinput(
                  onSubmitted: (String pin) => _showSnackBar(pin, context),
                  length: 6,
                  showCursor: true,
                  onChanged: (value) {
                    code = value;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: ()async {
                    try{
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: MyPhone.verify, smsCode: code);


                      await auth.signInWithCredential(credential);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Home();
                        },
                      ));
                    }
                    catch(e){
                      print("wrong OTP");
                    }

                  },
                  child: Text("Send Code"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 5),
      content: Container(
        height: 80.0,
        color: Colors.purpleAccent,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: Colors.greenAccent,
    );

  }
}
