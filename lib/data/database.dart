/*import 'package:hive_flutter/hive_flutter.dart';


class ToDoDataBase {
  List toDoList = [];

//reference the box
  final _myBox = Hive.box('"mybox');
  //run thsi methode if this is  the 1 time ever opinig this app
  void createInitialData() {
    toDoList = [
      ["make tuto", false],
      ["Do exercice", false],
    ];
  }

//load data
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

//update database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}*/
