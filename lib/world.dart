import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class World extends StatefulWidget {
  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> {

  final String url = "https://corona.lmao.ninja/v2/countries";
  
  Future <List> datas;  // for holding the data of getData

  Future <List> getData() async{
    var response = await Dio().get(url);
    return response.data;
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datas = getData();
  }

  Future showCard(String ind,inter,recover,death) async {
    await showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Color(0xFF363636),
          shape: RoundedRectangleBorder(),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Total Cases :$ind",style: TextStyle(fontSize: 20,color : Colors.white),),
                Text("Today's Deaths :$inter",style: TextStyle(fontSize: 20,color : Colors.red),),
                Text("Total Recoveries :$recover",style: TextStyle(fontSize: 20,color : Colors.green),),
                Text("Total Deaths :$death",style: TextStyle(fontSize: 20,color : Colors.red),),
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contrywise Statistics"),
        backgroundColor: Color(0xFF152238),
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: datas,
          builder: (BuildContext context,Snapshot)
          {
            if(Snapshot.hasData){
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.0
                  ),
                  itemCount: 207,
                  itemBuilder: (BuildContext context,index)=>SizedBox(
                    height: 50,
                    width: 50,
                    child: GestureDetector(
                      onTap: () =>showCard(
                          Snapshot.data[index]['cases'].toString(),
                          Snapshot.data[index]['todayDeaths'].toString(),
                          Snapshot.data[index]['recovered'].toString(),
                          Snapshot.data[index]['deaths'].toString()
                      ),
                      child: Card(
                        child: Container(
                          color: Color(0xFF292929),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Total Cases:${Snapshot.data[index]['cases'].toString()}',
                                  style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),),
                                Padding(padding: EdgeInsets.only(top: 10.0)),
                                Image(
                                  image: AssetImage("images/wdeath.png"),
                                  height: 85,
                                  width: 85,
                                ),
                                Text(
                                  Snapshot.data[index]['country'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              );

            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
