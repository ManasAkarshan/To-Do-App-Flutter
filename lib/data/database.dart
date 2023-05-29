import 'package:hive/hive.dart';

class ToDoDataBase{
  List toDoList = [];

  //reference the box
  final _myBox = Hive.box('myBox');
  
  //run if first time ever opening the app
  void createInitialData(){
    toDoList = [];
  }
  //Load the data from the database
  void loadData(){
    toDoList = _myBox.get("TODOLIST");
  }
  //Update the database
  void updateDataBase(){
    _myBox.put("TODOLIST", toDoList);
  }
}