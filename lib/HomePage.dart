import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  
  StreamSubscription<QuerySnapshot>subscription;
  
  List<DocumentSnapshot>snapshot;
  
  CollectionReference collectionReference=Firestore.instance.collection("Quote");
  
  @override
  void initState() {
    
    subscription=collectionReference.snapshots().listen((datasnapshot){
      setState(() {
        snapshot=datasnapshot.documents;
      });
    });
    
    super.initState();
  }


  List<MaterialColor>_color=[Colors.orange,Colors.blue,Colors.purple,Colors
      .pink,Colors.amber];

  List<MaterialColor>sndColor=[Colors.purple,Colors.green,Colors.indigo,Colors.brown,Colors.amber];

  MaterialColor sndMtcolor;


  MaterialColor color;
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
        title: new Text("Quote App"),
        backgroundColor: Colors.black,
      ),//end of appbar
      backgroundColor: Colors.grey.withOpacity(0.5),

      body: new ListView(
        children: <Widget>[

          new Container(
            height: 450.0,

            width: MediaQuery.of(context).size.width,
            child: new ListView.builder(
                itemCount: snapshot.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){

                color=_color[index % _color.length];

                sndMtcolor=sndColor[index % _color.length];

                  return Card(
                    elevation: 10.0,
                    margin: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: new Container(
                      width: 300.0,
                      child: new Column(
                        children: <Widget>[

                          new Expanded(
                              flex: 3,
                            child: new Container(
                              color: color,
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text(snapshot[index].data["title"],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white
                                  ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          new Divider(height: 2.0,color: Colors.black,),

                          new Expanded(
                              flex: 1,
                            child: new Container(
                              color: sndMtcolor,
                              width: MediaQuery.of(context).size.width,
                              child: new Row(
                                children: <Widget>[

                                  new Expanded(
                                      flex: 1,
                                    child: new CircleAvatar(
                                      child: new Text(snapshot[index].data["writer"][0],),
                                      backgroundColor: color,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),


                                  new Expanded(
                                    flex: 3,
                                    child: new Text(snapshot[index].data["writer"],
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white
                                    ),
                                    ),
                                  )

                                ],
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                  );
              }
            ),
          )

        ],
      ),

    );
  }
}


