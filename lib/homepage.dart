import 'dart:convert';

import 'package:coronatracker/Hospital.dart';
import 'package:coronatracker/Hstate.dart';
import 'package:coronatracker/Tindia.dart';
import 'package:coronatracker/india.dart';
import 'package:coronatracker/world.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'model/total_cases.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url = "https://corona.lmao.ninja/v2/all";

  Future <Tcases> getJson() async {
    var response = await http.get(
      Uri.encodeFull(url),
    );
    if(response.statusCode==200)
    {
      final convertDataJson = jsonDecode(response.body);
      return Tcases.fromJson(convertDataJson);
    }
    else {
      throw Exception(
        "try to Reload"
      );
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJson();
  }


  navigateToCountry() async{
    await Navigator.push(context, MaterialPageRoute(builder: (context)=> World()));
  }

  navigateToIndiaMap() async{
    await Navigator.push(context, MaterialPageRoute(builder: (context)=> India()));
  }

  navigateToIndia() async{
    await Navigator.push(context, MaterialPageRoute(builder: (context)=> Tindia()));
  }

  navigateToHospital() async{
    await Navigator.push(context, MaterialPageRoute(builder: (context)=> Hospital()));
  }

  navigateToHstate() async{
    await Navigator.push(context, MaterialPageRoute(builder: (context)=> Hstate()));
  }

  navigateToWHO(url) async {
    if(await canLaunch(url)) {
      await launch(url);
    }
    else {
      Text('Link is not Working $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Tracker'),
        backgroundColor: Color(0xFF152238),
        actions: <Widget>[

          IconButton(icon: Icon(Icons.share), onPressed: () {
            Share.share('check out *COVID-19 Tracker App* at https://drive.google.com/drive/folders/1TxT3AT04ssEAqz_ZmvGH-mNIlmNON8ip?usp=sharing');
          }),
          SizedBox(width: 15,),
        ],
      ),
      backgroundColor: Colors.black,
      
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 80)),
                      Text("Stay",style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold
                      ),),
                      Card(
                        color: Color(0xFFfe9900),
                        child: Text(" Home ",style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold
                        ),),
                      ),

                    ],
                  ),
                ),
//                Padding(padding: EdgeInsets.only(top: 10.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('WorldWide Statistics',style: TextStyle(fontSize: 16.0,color: Colors.white),),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    OutlineButton(
                      onPressed: ()=>navigateToIndia(),
                      color: Colors.blue,
                      borderSide: BorderSide(color: Color(0xFFfe9900)),
                      child: Text(
                        'India Statistics',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFfe9900)
                        ),
                      ),
                    )
                  ],
                ),
                
                FutureBuilder(
                  builder: (BuildContext context,SnapShot)
                  {
                    if(SnapShot.hasData) {
                        final covid = SnapShot.data;
                        return Column(
                          children: <Widget>[
                            Card(
                              color: Color(0xFF292929),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text("${covid.cases}",style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 23.0,
                                      fontWeight: FontWeight.bold
                                    ),),

                                    Text("${covid.deaths}",style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 23.0,
                                        fontWeight: FontWeight.bold
                                    ),),

                                    Text("${covid.recovered}",style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 23.0,
                                        fontWeight: FontWeight.bold
                                    ),)
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      }else if(SnapShot.hasError){
                        return Text(SnapShot.error.toString());}
                    else return Center(
                        child: CircularProgressIndicator(),
                      );
                  },
                  future: getJson(),
                ),
//              Padding(padding: EdgeInsets.only(top: 20)),
                Container(
                  child: Card(
                    color: Color(0xFF292929),
                  child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Total Cases",style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),),

                      Text("Deaths",style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),),

                      Text("Recovered",style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                  )
                  )
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
//                    Padding(padding: EdgeInsets.all(10)),
                      Card(
                        child: Container(
                          color: Color(0xFF292929),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(10)),
                                Image(
                                  image: AssetImage("images/india.png"),
                                  height: 90,
                                  width: 90,
                                ),
                                Padding(padding: EdgeInsets.all(5.0)),
                                OutlineButton(
                                  onPressed: ()=>navigateToIndiaMap(),
                                  borderSide: BorderSide(
                                    color: Color(0xFFfe9900)
                                  ),
                                  child: Text(
                                    "             India \n StateWise Statistics",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFFfe9900),
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      Card(
                        child: Container(
                          color: Color(0xFF292929),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(10)),
                                Image(
                                  image: AssetImage("images/world.png"),
                                  height: 90,
                                  width: 90,
                                ),
                                Padding(padding: EdgeInsets.all(5.0)),
                                OutlineButton(
                                  onPressed: ()=>navigateToCountry(),
                                  borderSide: BorderSide(
                                      color: Color(0xFFfe9900)
                                  ),
                                  child: Text(
                                    "WorldWise Statistics",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFfe9900),
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),





                    ],
                  ),

                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
//                    Padding(padding: EdgeInsets.all(10)),
                      Card(
                        child: Container(
                          color: Color(0xFF292929),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(10)),
                                Image(
                                  image: AssetImage("images/hospital.png"),
                                  height: 90,
                                  width: 90,
                                ),
                                Padding(padding: EdgeInsets.all(5.0)),
                                OutlineButton(
                                  onPressed: ()=>navigateToHospital(),
                                  borderSide: BorderSide(
                                      color: Color(0xFFfe9900)
                                  ),
                                  child: Text(
                                    "          Indian \n Hospital Statistics",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFfe9900),
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      Card(
                        child: Container(
                          color: Color(0xFF292929),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(10)),
                                Image(
                                  image: AssetImage("images/hs.png"),
                                  height: 90,
                                  width: 90,
                                ),
                                Padding(padding: EdgeInsets.all(5.0)),
                                OutlineButton(
                                  onPressed: ()=>navigateToHstate(),
                                  borderSide: BorderSide(
                                      color: Color(0xFFfe9900)
                                  ),
                                  child: Text(
                                    "    Indian Hospitals \n Statewise Statistics",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFFfe9900),
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),





                    ],
                  ),

                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Card(
                  child: Container(
                    color: Color(0xFF292929),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10)),
                          Image(
                            image: AssetImage("images/myth.png"),
                            height: 90,
                            width: 90,
                          ),
                          Padding(padding: EdgeInsets.all(5.0)),
                          OutlineButton(
                            onPressed: ()=> navigateToWHO("https://www.who.int/news-room/q-a-detail/q-a-coronaviruses"),
                            borderSide: BorderSide(
                                color: Color(0xFFfe9900)
                            ),
                            child: Text(
                              "Myth Busters by WHO",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFFfe9900),
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
