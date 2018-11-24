import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/bloc/bloc.dart';
import 'package:todo_app/src/bloc/provider.dart';
import 'package:todo_app/src/model/todo.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewTodoScreen extends StatefulWidget {
  _NewTodoScreenState createState() => _NewTodoScreenState();
}

class _NewTodoScreenState extends State<NewTodoScreen> {
  final List<String> categories = [
    "Housework",
    "School Work",
    "Hobby",
    "Free Time",
    "Other"
  ];
  final CollectionReference todoCollection =
      Firestore.instance.collection('todos');

  String todo = "";
  String desciption = "";
  String category = "Housework";
  DateTime todoDate = DateTime.now();
  TimeOfDay todoTime = TimeOfDay.now();
  int priorityValue = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onDateClicked(BuildContext con) async {
    DateTime selectedDate = await showDatePicker(
        context: con,
        firstDate: DateTime.now(),
        lastDate: DateTime(3000),
        initialDate: DateTime.now());
    if (selectedDate == null) return;
    setState(() {
      todoDate = selectedDate;
    });
  }

  void _onTimeClicked() async {
    TimeOfDay selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selectedTime == null) return;
    setState(() {
      todoTime = selectedTime;
    });
  }

  void _onPriorityChanged(int val) {
    setState(() {
      priorityValue = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    Bloc bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Todo"),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            buildTextFieldTodo(),
            SizedBox(height: 8.0),
            buildTextFieldDescription(),
            SizedBox(height: 8.0),
            buildRowDateTime(context),
            SizedBox(height: 8.0),
            buildDropdownButtonHideUnderline(),
            SizedBox(height: 8.0),
            buildPrioritySelection(),
            SizedBox(height: 8.0),
            buildPickLocation(),
            SizedBox(height: 8.0),
            buildSaveButton(context, bloc)
          ],
        ),
      ),
    );
  }

  Widget buildPickLocation() {
    return InkWell(
      onTap: () {
        print("tap");
      },
      child: InputDecorator(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Location",
            suffixIcon: Icon(
              Icons.map,
              color: Colors.red,
            )),
        child: Text("Pick place"),
      ),
    );
  }

  Widget buildPrioritySelection() {
    return InputDecorator(
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: "Priority",
      ),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Radio(
              groupValue: priorityValue,
              value: 0,
              onChanged: _onPriorityChanged,
              activeColor: Colors.red,
            ),
            Text(
              "High",
              style: TextStyle(color: Colors.red),
            ),
            Radio(
              groupValue: priorityValue,
              value: 1,
              onChanged: _onPriorityChanged,
              activeColor: Colors.green,
            ),
            Text(
              "Medium",
              style: TextStyle(color: Colors.green),
            ),
            Radio(
              groupValue: priorityValue,
              value: 3,
              onChanged: _onPriorityChanged,
              activeColor: Colors.cyan,
            ),
            Text(
              "Normal",
              style: TextStyle(color: Colors.cyan),
            ),
            Radio(
              groupValue: priorityValue,
              value: 4,
              onChanged: _onPriorityChanged,
              activeColor: Colors.blue,
            ),
            Text(
              "Low",
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFieldTodo() {
    return TextField(
      onChanged: (todoName) {
        setState(() {
          todo = todoName;
        });
      },
      decoration: InputDecoration(
        labelText: "Todo",
        hintText: "What will you do?",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget buildTextFieldDescription() {
    return TextField(
      onChanged: (des) {
        setState(() {
          desciption = des;
        });
      },
      maxLines: 3,
      decoration: InputDecoration(
        labelText: "Description",
        hintText: "More details ",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget buildRowDateTime(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {
              _onDateClicked(context);
            },
            child: InputDecorator(
              decoration: InputDecoration(labelText: "Date"),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(DateFormat.yMMMd().format(todoDate)),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: InkWell(
            onTap: () {
              _onTimeClicked();
            },
            child: InputDecorator(
              decoration: InputDecoration(labelText: "Time"),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(todoTime.format(context)),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDropdownButtonHideUnderline() {
    return DropdownButtonHideUnderline(
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: "Category",
          contentPadding: EdgeInsets.zero,
        ),
        isEmpty: categories == null,
        child: DropdownButton<String>(
          value: category,
          onChanged: (newVal) {
            setState(() {
              category = newVal;
            });
          },
          items: categories.map((String cate) {
            return DropdownMenuItem<String>(
              value: cate,
              child: Text(cate),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildSaveButton(BuildContext context, Bloc bloc) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      onPressed: () {
        //Add Todos to Bloc
        // bloc.addTodo(Todo(todo, desciption, todoDate, todoTime, category,
        //     priorityValue, "Phnom Penh"));

        //Add Todo to CloudFireStore
        createTodo(Todo(Uuid().v4().toString(), todo, desciption, todoDate,
            todoTime, category, priorityValue, "Phnom Penh"));
      },
      textColor: Colors.white,
      color: Theme.of(context).primaryColor,
      elevation: 10.0,
      child: Text("Save"),
    );
  }

  createTodo(Todo todo) async {
    // Map<String, dynamic> newTodo = todo.toMap();
    // newTodo['todoDate'] = todo.todoDate.millisecond;
    // newTodo['todoTime'] = todo.todoTime.minute;
    await Firestore.instance.collection('todos').add(todo.toMap());
  }
}
