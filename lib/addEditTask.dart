import 'package:flutter/material.dart';
import 'package:todolist/task.dart';

class addEditTask extends StatefulWidget {

  final List<Task>? tasks;
  final bool? saveorupdate;
  final Task? tsk;

  addEditTask({Key? key, this.tasks, this.saveorupdate, this.tsk}) : super(key: key);

  @override
  State<addEditTask> createState() => _addEditTaskState();
}

class _addEditTaskState extends State<addEditTask> {

  TextEditingController txtName = new TextEditingController();
  late FocusNode focus;


  @override
  void initState() {
    super.initState();
    txtName.text = widget.tsk!.name.toString();
    

    focus = new FocusNode();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add & Edit'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0), 
              child: TextField(
                controller: txtName,

                autofocus: true,
                decoration: InputDecoration(hintText: 'Name'),
                
              ),
            ),

            Container(
              width: 100,
              child: ElevatedButton(
                onPressed: (){
                  Task or = new Task();
                  if(widget.saveorupdate == true){
                    or.id = widget.tsk!.id.toString();
                    or.name = txtName.text;
                    

                    TaskDal dl = new TaskDal();
                    dl.editTask(or);
                  }else{
                    or.id = widget.tsk!.id.toString();
                    or.name = txtName.text;
                    

                    TaskDal dl = new TaskDal();
                    dl.addTask(or);
                  }
                  Navigator.pop(context);
                  print(widget.tsk!.name.toString());
                  setState(() {
                    // isButtonActive = false;
                  });
                }, 
                child: Text('Save') 
              ),
            )
          ],
        )
      ),
    );
  }
}