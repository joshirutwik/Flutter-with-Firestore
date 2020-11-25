import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:withdata/task.dart';
import 'input.dart';
import 'dart:async';
import 'FireService.dart';
import 'edit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FireService fires = new FireService();
  List<Task> items;
  List<Task> to_delete;
  StreamSubscription<QuerySnapshot> todoTasks;
  QuerySnapshot snapshot;
  DocumentReference dr;
  String id;

  @override
  void initState() {
    super.initState();
    items = new List();
    todoTasks = fires.getTaskList().listen((QuerySnapshot snapshot) {
      final List<Task> tasks = snapshot.documents
          .map((documentSnapshot) => Task.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        items = tasks;
      });
    });
  }

  // get(String id) {
  //   this.id = id;
  //   return this.id;
  // }

  @override
  Widget todoCir(String val) {
    IconData ic;
    Color co;
    switch (val) {
      case "travel":
        ic = FontAwesomeIcons.tripadvisor;
        co = Color(0xff4158ba);
        break;
      case "party":
        ic = FontAwesomeIcons.glassCheers;
        co = Color(0xff9962d0);
        break;
      case "Gym":
        ic = FontAwesomeIcons.dumbbell;
        co = Color(0xff4caf50);
        break;
      default:
        ic = FontAwesomeIcons.tasks;
        co = Color(0xff0dc8f5);
    }
    return CircleAvatar(
      backgroundColor: co,
      child: Icon(
        ic,
        color: co,
        size: 20.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80.0,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 5.0),
                    child: Material(
                      color: Colors.white,
                      elevation: 10.0,
                      shadowColor: Colors.grey.withOpacity(0.4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          todoCir('${items[index].tasktype}'),
                          Text('${items[index].taskname}'),
                          Column(
                            children: <Widget>[
                              Text('${items[index].taskdate}',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold)),
                              Text('${items[index].tasktime}'),
                            ],
                          ),
                          IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              color: Colors.deepPurple,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => edit_data(
                                      items[index].taskdetails,
                                      items[index].taskdate,
                                      items[index].tasktime,
                                      items[index].taskname,
                                      items[index].tasktype,
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Input(),
              ));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
