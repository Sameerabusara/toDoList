// import 'dart:_http';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/io_client.dart';
import 'package:todolist/addEditTask.dart';
import 'package:todolist/task.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Task>? tasks = [];
  Task ts = new Task();
  @override

  void initState() {
    super.initState();
    get();
  }

  void get() async{
    tasks = await fetchProducts();
    setState(() {}); 
  }

  Future<List<Task>?> fetchProducts() async{
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response;


    Task i = new Task();
    if(response.statusCode == 200){
      List<Task>? tasks = i.parseProducts(response.body);
      try{

      }catch (x){}
      
      return tasks;
    }else{
      throw Exception('Unable to fetch products from the REST API');
    }  
  }
  
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('To Do List'),
          centerTitle: true,
          
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Expanded(
                
                child: Container(
                color: Colors.red,

                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                            .collection('task')
                            .snapshots(),
                      builder: (context, snapshot){
                        return ListView.builder(
                          itemCount: (snapshot.data!).docs.length,
                          itemBuilder: (context, index){
                            DocumentSnapshot doc = (snapshot.data!).docs[index];

                            return Slidable(
                              startActionPane: ActionPane(
                                motion: ScrollMotion(), 
                                children: [
                                  SlidableAction(
                                    onPressed: (int) async {
                                      Task ts = new Task();
                                      ts.id = doc.id.toString();

                                      // await FirebaseFirestore.instance
                                      //       .collection('users')
                                      //       .doc(it.id)
                                      //       .delete();
                                    
                                    TaskDal dl = new TaskDal();
                                    dl.deleteTask(ts);
                                    },


                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete', 
                                    ),
                                ]),
                              child: GestureDetector(
                                onLongPress: (){
                                  Task ts = new Task();
                                  ts.id = doc.id.toString();
                                  ts.name = doc['name'];
                                  
                                  
                                  // Item u = new Item();
                                  // u.addUser();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    addEditTask(tasks: tasks, saveorupdate: true, tsk: ts)),
                                );
                                   
                                },
                                
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(10.0),
                                  leading: Text('name: '+doc['name']),
                                  // subtitle: Text('Date: ' +doc['date'], textAlign: TextAlign.left,),
                                ),

                              ),
                            );
                          },
                        );
                      }
                  ),
              ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
              ts = new Task();
              ts.name = '';


              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                  addEditTask(tasks: tasks, saveorupdate: false, tsk: ts)),
              );
          },
          child: Icon(Icons.plus_one),),
      ),
    );
  }
}