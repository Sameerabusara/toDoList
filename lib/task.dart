import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:trucky_admin/addEditInfo.dart';

class Task{
  String? id;
  String? name;
  
 
  Task({this.id, this.name});

  Map toJson(){
    return {'id': id, 'name': name};
  }

  List<Task>? parseProducts(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Task>((json) => Task.fromJson(json)).toList();
  }

  factory Task.fromJson(Map<String, dynamic> json){
    return Task(  
      id: json['id'].toString(),
      name: json['name'].toString(),
    );
  }

  
  
}

class TaskDal{
  Future<Task> addTask(Task tsk) async{
    await FirebaseFirestore.instance
          .collection('tasks')
          // .doc(usr.id.toString())
          .add({
        "name": tsk.name.toString(),
        
      });
    return tsk;
  }

  Future<Task> editTask(Task tsk) async{
    await FirebaseFirestore.instance
          .collection('tasks')
          .doc(tsk.id)
          .set({
        "name": tsk.name.toString(),
      });
    return tsk;
  }

  Future<Task> deleteTask(Task tsk) async{
    await FirebaseFirestore.instance
          .collection('tasks')
          .doc(tsk.id)
          .delete();
    return tsk;
  }

  
}