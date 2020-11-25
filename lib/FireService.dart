import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference myCollection = Firestore.instance.collection('todolist');

class FireService {
  Stream<QuerySnapshot> getTaskList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshot = myCollection.snapshots();
    return snapshot;
  }
}
