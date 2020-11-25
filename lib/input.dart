import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:withdata/Homepage.dart';
import 'package:withdata/task.dart';

class Input extends StatefulWidget {
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  TextEditingController taskname, taskdate, tasktime, taskdetails;
  int group_val = 0;
  String Task_type, taskname_, taskdate_, tasktime_, taskdetails_;
  DocumentReference ds = Firestore.instance.collection('todolist').document();

  DocumentSnapshot _snapshot;
  String get id => null;

  // all the getter functions
  getTaskName(String taskname) {
    taskname_ = taskname;
  }

  getTaskDate(String taskdate) {
    taskdate_ = taskdate;
  }

  getTaskTime(String tasktime) {
    tasktime_ = tasktime;
  }

  getTaskDetails(String taskdetails) {
    taskdetails_ = taskdetails;
  }

  // function to make  Radio working
  void On_change(int val) {
    setState(() {
      group_val = val;
      switch (val) {
        case 1:
          Task_type = "Travel";
          break;

        case 2:
          Task_type = "Party";
          break;

        case 3:
          Task_type = "Gym";
          break;
      }
    });
  }

  @override
  // function to insert data in Firestore
  createData() {
    Map<String, dynamic> tasks = {
      "taskdate": taskdate_,
      "taskdetails": taskdetails_,
      "taskname": taskname_,
      "tasktime": tasktime_,
      "tasktype": Task_type,
    };
    ds = Firestore.instance.collection('todolist').document();
    ds.setData(tasks).then((value) {
      Firestore.instance
          .collection('todolist')
          .document(ds.documentID)
          .updateData({"taskname": ds.documentID.toString()});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "CRUD",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          centerTitle: true),
      body: ListView(
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    // controller: taskdetails,
                    decoration: InputDecoration(
                      labelText: "TaskDetails",
                      hoverColor: Colors.black,
                    ),
                    onChanged: (String details) {
                      getTaskDetails(details);
                    },
                  ),
                  TextField(
                    // controller: taskdate,
                    decoration: InputDecoration(
                      labelText: "TaskDate",
                      hoverColor: Colors.black,
                    ),
                    keyboardType: TextInputType.datetime,

                    onChanged: (String date) {
                      getTaskDate(date);
                    },
                  ),
                  TextField(
                    // controller: tasktime,
                    decoration: InputDecoration(
                      labelText: "TaskTime",
                      hoverColor: Colors.black,
                    ),
                    keyboardType: TextInputType.datetime,
                    onChanged: (String time) {
                      getTaskTime(time);
                    },
                  ),
                  TextField(
                    // controller: taskname,
                    decoration: InputDecoration(
                      labelText: "Taskname",
                      hoverColor: Colors.black,
                    ),
                    onChanged: (String name) {
                      getTaskName(name);
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Task Type",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      activeColor: Colors.black,
                      value: 1,
                      groupValue: group_val,
                      onChanged: On_change,
                    ),
                    Text("Travel"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      activeColor: Colors.black,
                      value: 2,
                      groupValue: group_val,
                      onChanged: On_change,
                    ),
                    Text("Party"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      activeColor: Colors.black,
                      value: 3,
                      groupValue: group_val,
                      onChanged: On_change,
                    ),
                    Text("Gym"),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 100.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * .3,
              ),
              RaisedButton(
                onPressed: createData(),
                child: Text("Subimit", style: TextStyle(color: Colors.white)),
                color: Colors.black12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
