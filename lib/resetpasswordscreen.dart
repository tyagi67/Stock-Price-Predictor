import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stock_price_predictor/homescreen.dart';
import 'package:stock_price_predictor/reusable_Widgets/reusablewidgets.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailTextController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation:0,
          title: const Text(
            "RESET PASSWORD",
            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
          ),
        ),
        body:Container(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors:[
                  Colors.red,
                  Colors.green
                ],begin:Alignment.bottomCenter,end:Alignment.topCenter)),
            child:SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height:20,
                    ),
                    reusableTextField("Enter Email Id", Icons.person_outline, false, _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseButton(context, "RESET PASSWORD", (){
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _emailTextController.text)
                          .then((value)=>Navigator.of(context).pop());
                    })
                  ],
                ),
              ),
            )
        )
    );
  }
}
