class Task {
  String _taskname;
  String _taskdetails;
  String _taskdate;
  String _tasktime;
  String _tasktype;

  Task(this._taskname, this._taskdetails, this._taskdate, this._tasktime,
      this._tasktype);

  Task.map(dynamic obj) {
    this._taskname = obj['taskname'];
    this._taskdetails = obj['taskdetails'];
    this._taskdate = obj['taskdate'];
    this._tasktime = obj['tasktime'];
    this._tasktype = obj['tasktype'];
  }

  String get taskname => _taskname;
  String get taskdetails => _taskdetails;
  String get taskdate => _taskdate;
  String get tasktime => _tasktime;
  String get tasktype => _tasktype;

  // The below function is used to convert object data into Map
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['taskname'] = _taskname;
    map['taskdetails'] = _taskdetails;
    map['taskdate'] = _taskdate;
    map['tasktime'] = _tasktime;
    map['tasktype'] = _tasktype;
    return map;
  }

// The below function is used to convert Map data into object data
  Task.fromMap(Map<String, dynamic> map) {
    this._taskdate = map['taskdate'];
    this._taskdetails = map['taskdetails'];
    this._taskname = map['taskname'];
    this._tasktime = map['tasktime'];
    this._tasktype = map['tasktype'];
    // This function is used to convert the data coming in Map form INTO the value of that map that can be displayed
  }
}
