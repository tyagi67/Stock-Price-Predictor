import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StockDetail extends StatefulWidget{
  const StockDetail({Key? key, required this.symbol,required this.company}):super(key: key);
  final String symbol;
  final String company;
  @override
  State<StockDetail> createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetail> {
  String LastRefreshDate="LOADING...";
  String StockSymbol="LOADING...";
  String StockName="LOADING...";
  String OpenPrice="LOADING...";
  String HighPrice="LOADING...";
  String LowPrice="LOADING...";
  String ClosePrice="LOADING...";
  String Predicted="PREDICTING...";
    void initState(){
    super.initState();
    getHttprequest(widget.symbol,widget.company);
  }
  Future<void>getHttprequest(String symbolName,String stockname) async {
      /*[APIKEY1,2,3]*/
   String url="https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol="+symbolName+".BSE&apikey=H5XXV9E9MU7QMKJ7";
   var response= await http.get(Uri.parse(url));
   if(response.statusCode==200)
   {
     Map<String,dynamic>map = jsonDecode(response.body);
     StockSymbol=symbolName;
     StockName=stockname;
     LastRefreshDate=map["Meta Data"]["3. Last Refreshed"];
     OpenPrice=map["Time Series (Daily)"][LastRefreshDate]["1. open"];
     HighPrice=map["Time Series (Daily)"][LastRefreshDate]["2. high"];
     LowPrice=map["Time Series (Daily)"][LastRefreshDate]["3. low"];
     ClosePrice=map["Time Series (Daily)"][LastRefreshDate]["4. close"];
     setState(() {

     });
    }
   String url2="http://ec2-13-233-130-174.ap-south-1.compute.amazonaws.com:8080/predict/"+symbolName+".BSE";
   var response2= await http.get(Uri.parse(url2));
   if(response2.statusCode==200)
   {
     Map<String,dynamic>map = jsonDecode(response2.body);
     Predicted=map["prediction"];
     setState(() {
     });
   }
  }
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title:Text("DETAILS ABOUT STOCK"),//widget.symbol),
      ),
      body:Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(11.0 ),
            child:SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Text("COMPANY NAME: ",style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold)),
                  Text(StockName,style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold,)),
                  SizedBox(height: 10,),
                  Text("STOCK SYMBOL: ",style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold)),
                  Text(StockSymbol,style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold)),
                  SizedBox(height: 10,),
                  Text("LAST REFRESH DATE: ",style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold)),
                  Text(LastRefreshDate,style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold)),
                  SizedBox(height: 10,),
                  Text("OPEN PRICE: ",style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold)),
                  Text(OpenPrice,style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold)),
                  SizedBox(height: 10,),
                  Text("HIGH PRICE: ",style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold)),
                  Text(HighPrice,style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold)),
                  SizedBox(height: 10,),
                  Text("LOW PRICE: ",style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold)),
                  Text(LowPrice,style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold)),
                  SizedBox(height: 10,),
                  Text("CLOSE PRICE: ",style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold)),
                  Text(ClosePrice,style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold)),
                  SizedBox(height: 10,),
                  Text("PREDICTED CLOSE PRICE: ",style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold)),
                  Text(Predicted,style: TextStyle(fontSize: 21,fontWeight:FontWeight.bold)),
                ]
              ),
            )
          ),
        ),
      )
    );
  }
}