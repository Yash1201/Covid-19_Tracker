import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class India extends StatefulWidget {
  @override
  _IndiaState createState() => _IndiaState();
}

class _IndiaState extends State<India> {

  final String url = "https://api.rootnet.in/covid19-in/stats/latest";
  Future<List>datas;
  Future <List> getData() async {
    var response = await Dio().get(url);
    return response.data['data']['regional'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datas = getData();
  }

  Future showcard (String ind,inter,recover,death) async
  {
    await showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            backgroundColor: Color(0xFF363636),
            shape: RoundedRectangleBorder(),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[

                  Text("Indian Cases :$ind",style: TextStyle(fontSize: 20,color : Colors.blue),),
                  Text("Foreigner Cases :$inter",style: TextStyle(fontSize: 20,color : Colors.white),),
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
        title: Text("India StateWise Statistics"),
        backgroundColor: Color(0xFF152238),
      ),
      backgroundColor: Colors.black,

      body: Container(
        child: FutureBuilder(
            future: datas,
            builder: (BuildContext context,Snapshot){
              if(Snapshot.hasData) {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1.0
                    ),
                    itemCount: 30,
                    itemBuilder: (BuildContext context,index)=>SizedBox(
                      height: 50,
                      width: 50,
                      child: GestureDetector(
                        onTap: ()=>showcard(
                            Snapshot.data[index]['confirmedCasesIndian'].toString(),
                            Snapshot.data[index]['confirmedCasesForeign'].toString(),
                            Snapshot.data[index]['discharged'].toString(),
                            Snapshot.data[index]['deaths'].toString()
                        ),
                        child: Card(
                          child: Container(
                            color: Color(0xFF292929),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(top: 5.0)),
                                Text("Total Cases : ${Snapshot.data[index]['confirmedCasesIndian'].toString()}",
                                style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF45b6fe)),),
                                Padding(padding: EdgeInsets.only(top: 5.0)),
                                Image(image: AssetImage("images/cases.png"),height: 85,width: 85,),
                                Padding(padding: EdgeInsets.only(top: 5.0)),
                                Text(
                                  "${Snapshot.data[index]['loc']}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        ),
      ),
    );
  }
}
