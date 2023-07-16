import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stock_price_predictor/homescreen.dart';
import 'package:stock_price_predictor/reusable_Widgets/reusablewidgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailTextController=TextEditingController();
  TextEditingController _passwordTextController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation:0,
        title: const Text(
          "SIGN UP",
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
                  height:20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true, _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseButton(context, "SIGN UP", (){
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                      .then((value){
                          Navigator.push(context,MaterialPageRoute(builder:(context)=>HomeScreen()));
                  });

                })
              ],
            ),
          ),
        )
      )
    );
  }
}
