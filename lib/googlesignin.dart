import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stock_price_predictor/homescreen.dart';

class GoogleServices{
 final _auth=FirebaseAuth.instance;
 final _googleSignIn=GoogleSignIn();

 signInWithGoogle(context) async{
  try{
    final GoogleSignInAccount? googleSignInAccount= await _googleSignIn.signIn();
    if(googleSignInAccount!=null){
      final GoogleSignInAuthentication googleSignInAuthentication=
      await googleSignInAccount.authentication;
      final AuthCredential authCredential=GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      await _auth.signInWithCredential(authCredential);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
  } on FirebaseAuthException catch (e)
  {
    throw e;
  }
 }

 signOutWithGoogle() async{
   await _auth.signOut();
   await _googleSignIn.signOut();
 }
}
