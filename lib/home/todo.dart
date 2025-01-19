import 'package:flutter/material.dart';
import 'package:login_page/home/todo/constants/colors.dart';
import 'package:login_page/home/todo/util/dialogbox.dart';
import 'package:login_page/home/todo/widgets/todoitem.dart';

class ToDo extends StatefulWidget {
  ToDo({Key? key}) : super(key: key);

  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  //reference the box from main
  //final _myBox = Hive.box('mybox');
  //ToDoDataBase db = ToDoDataBase();

  @override
  /*void initState() {
    // this is firest time ever opping app then create deault data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //already exist data
      db.loadData();
    }
    super.initState();
  }*/

  final _controller = TextEditingController();
  //final _control = TextEditingController();

  List toDoList = [
    ["Make tutor ", false],
    ["Do exercie", false],
  ];
  //checkBox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
    //updateDataBase();
  }

  //save function
  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    //db.updateDataBase();
  }

  //DELTE TASK
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
    //db.updateDataBase();
  }

  //create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //final user = FirebaseAuth.instance.currentUser!;
  //PageController _controller = PageController();

  @override
  Widget build(BuildContext context) => Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
          //_create();
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: tdBGColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: tdBGColor,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Text(
            "List of Activitiés",
            style: TextStyle(fontSize: 30, color: Colors.grey),
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
                //borderRadius: BorderRadius.circular(20),
                child: Image.asset("lib/images/todo.png")),
          )
        ]),
      ),
      body: Stack(
        children: [
          /*Container(
            height: 700,
            width: 500,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/images/todo.png"),
                    fit: BoxFit.cover)),
          ),*/
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(
                        Icons.search,
                        color: tdBlack,
                        size: 20,
                      ),
                      prefixIconConstraints:
                          BoxConstraints(maxHeight: 20, minHeight: 0),
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(color: tdGrey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    "lib/images/todo.png",
                    height: 100,
                    //width: 500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: toDoList.length,
                    itemBuilder: (context, index) {
                      Icon(
                        Icons.delete,
                        size: 100,
                      );
                      return ToDoItem(
                        taskName: toDoList[index][0],
                        taskCompleted: toDoList[index][1],
                        onchanged: (value) => checkBoxChanged(value, index),
                        deleteFunction: (context) => deleteTask(index),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          /*Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 340, bottom: 20),
                  child: ElevatedButton(
                    child: Text(
                      "+",
                      style: TextStyle(fontSize: 40),
                    ),
                    onPressed: createNewTask,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                ),
              ],
            ),
          )*/
        ],
      ));
}
