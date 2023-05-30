import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/data/database.dart';

import '../util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState(){
      return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{

  @override
  void initState(){
    if(_mybox.get("TODOLIST")==null){
      //first time app is opened (ever)
      db.createInitialData();
    }
    else{
      //Load the data
      db.loadData();
    }
    super.initState();
  }

  //reference the box
  final _mybox = Hive.box('myBox');

  //Creating a TextEditingController to reference in the dialog box class
  final _controller = TextEditingController();
  final editCont = TextEditingController();

  ToDoDataBase db = ToDoDataBase();


  void checkBoxChanged(int index){   // value can be null
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void onCancel(){
    //Popping the dialog box
    Navigator.of(context).pop();
  }

  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    //Popping the dialog box
    Navigator.of(context).pop();
    //updating the database
    db.updateDataBase();
  } 

  void createNewTask(){
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(onSave: saveNewTask, onCancel: onCancel, controller: _controller, hintText: 'Add new task',);
      }
    );
  }

  void deleteTask(int index){
    //Temporarily storing the task
    List deletedTasks = db.toDoList.elementAt(index);

    setState(() {
      db.toDoList.removeAt(index);
    });
    //updating the database
    db.updateDataBase();
    // Showing a snackbar with undo button
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: const Text('Task deleted'),
        action: SnackBarAction(
          label: "Undo", 
          onPressed: (){
            setState(() {
              db.toDoList.insert(index, deletedTasks);
            });
            db.updateDataBase();
          },
        ),
      )
    );
  }

  void saveEdit(String edit, int index){
    setState(() {
      db.toDoList.removeAt(index);
      db.toDoList.add([edit, false]);
    });
    db.updateDataBase();
    Navigator.pop(context);
  }

  @override
  Widget build(context){
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 126, 126, 126),
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: db.toDoList.isNotEmpty ?
      ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder:(context, index){
          return ToDoTile(
            taskName: db.toDoList[index][0], 
            taskCompleted: db.toDoList[index][1],
            onChanged: (val) {
              checkBoxChanged(index);
              // return ;
            },
            deleteFunction: (ctx){
              deleteTask(index);
            },
            editCont: editCont,
            save: (){
              saveEdit(editCont.text, index);
            },
          );
        }
      ) 
      : const Center(
          child: Text(
            'No tasks',
            style: TextStyle(fontSize: 18),
          )
      )
    );
  }
}