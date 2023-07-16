import 'package:flutter/material.dart';

class aboutUs extends StatefulWidget {
  const aboutUs({Key? key}) : super(key: key);

  @override
  State<aboutUs> createState() => _aboutUsState();
}

class _aboutUsState extends State<aboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Center(child:Text("ABOUT US          "))),
      body:Container(
        child:SingleChildScrollView(
          child: Column(
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Text("We Are Final Year Students Of KIET Group Of Institutions And We Have Made This APP As Our Final Year Project.\n\nThis App Show The Prediction For Indian Stocks Listed On Bombay Stock Exchange (BSE).\n\n Using This APP You Can See The Prediction For Any Stock On Next Day.\n\nThis Is Made By The Following Students:\n\nPRANAV GARG\nANKIT SRIVASTAVA\nANANT TYAGI\n\n",style: TextStyle(fontSize: 18),),
            ),
          ],
          ),
        )
      )
    );
  }
}
