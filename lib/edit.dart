import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class edit_data extends StatefulWidget {
  DocumentReference ds = Firestore.instance.collection('todolist').document();
  String taskname, tasktype, taskdate, tasktime, taskdetails;
  String get id => ds.documentID;
  @override
  edit_data(this.taskdetails, this.taskdate, this.tasktime, this.taskname,
      this.tasktype);

  @override
  _edit_dataState createState() => _edit_dataState();
}

class _edit_dataState extends State<edit_data> {
  DocumentReference dr = Firestore.instance.collection('todolist').document();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit data"),
      ),
      body: Column(
        children: <Widget>[
          R_1("TaskDetails :", widget.taskdetails),
          R_1("TaskDate :", widget.taskdate),
          R_1("TaskTime :", widget.tasktime),
          R_1("TaskName :", widget.taskname),
          R_1("TaskType :", widget.tasktype),
          SizedBox(
            height: 30.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            child: RaisedButton(
              color: Colors.red,
              child: Text("Delete"),
              onPressed: () async {
                await Firestore.instance
                    .collection('todolist')
                    .document(widget.taskname)
                    .delete();
                print(": id = " + widget.taskname);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget R_1(String key, String value) {
  return Row(
    children: <Widget>[
      Text(
        key,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: 20.0,
      ),
      Text(value),
    ],
  );
}