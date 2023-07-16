import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_price_predictor/googlesignin.dart';
import 'package:stock_price_predictor/homescreen.dart';
import 'package:stock_price_predictor/resetpasswordscreen.dart';
import 'package:stock_price_predictor/reusable_Widgets/reusablewidgets.dart';
import 'package:stock_price_predictor/signupscreen.dart';

class SignInScreen extends StatefulWidget{
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailTextController=TextEditingController();
  TextEditingController _passwordTextController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: LinearGradient(colors:[
        Colors.red,
        Colors.green
      ],begin:Alignment.bottomCenter,end:Alignment.topCenter)),
      child:SingleChildScrollView(
        child: Padding(
            padding:EdgeInsets.fromLTRB(
                20,MediaQuery.of(context).size.height*0.14,20,0),
          child: Column(
            children:<Widget>[
              logoWidget("assets/images/background.png"),
              const SizedBox(
                height:30,
              ),
              reusableTextField("Enter Email Id",Icons.person_outline,false, _emailTextController),
              const SizedBox(
                height: 30,
              ),
              reusableTextField("Enter Password",Icons.lock_outline,true, _passwordTextController),
              const SizedBox(
                height:5,
              ),
              forgetPassword(context),
              firebaseButton(context, "SIGN IN",(){
                FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text).then((value){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>HomeScreen()));
                });
              }),
              signUpOption(),
              const SizedBox(
                height: 10
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height:50,
                margin:const EdgeInsets.fromLTRB(0,10,0,20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                child: ElevatedButton(
                    onPressed:() async {
                      await GoogleServices().signInWithGoogle(context);
                    },
                    style:ButtonStyle(
                      backgroundColor:MaterialStateProperty.resolveWith((states){
                        if(states.contains(MaterialState.pressed)){
                          return Colors.black26;
                        }
                        return Colors.white;
                      }),
                        shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/google.png",
                              width: 40,
                              height: 40,
                            ),
                            const SizedBox(
                              width:10,
                            ),
                            const Text(
                                "LOGIN WITH GOOGLE",
                            style: TextStyle(
                              color:Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                ),
              )
            ],
          ),
        ),
      ),
      ),
    );
  }
  Row signUpOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have acccount?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap:(){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpScreen()));
          },
          child:const Text(
            " SIGN UP",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height:35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "FORGOT PASSWORD?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>ResetPassword())),
      ),
    );
  }
}