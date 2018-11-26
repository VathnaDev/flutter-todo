import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/model/todo.dart';
import 'package:todo_app/src/utils/misc.dart';

class TodoDetailScreen extends StatelessWidget {
  final Todo todo;

  TodoDetailScreen(this.todo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(todo.todo),
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: 50.0,
            child: Container(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Card(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          todo.todo,
                          style:
                              TextStyle(fontSize: 28.0, fontFamily: "Raleway"),
                        ),
                        Text(
                          DateFormat.yMMMd().format(todo.todoDate) +
                              " | " +
                              todo.todoTime.format(context),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(todo.description),
                        SizedBox(height: 32.0),
                        Row(
                          children: <Widget>[
                            Text(
                              "Priority: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.favorite,
                              color: Misc.getColorPriority(todo.priority),
                            )
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: <Widget>[
                            Text(
                              "Category: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(todo.category)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          iconSize: 40.0,
                          onPressed: () {},
                          color: Colors.red,
                          icon: Icon(Icons.delete_outline),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {},
                          iconSize: 40.0,
                          color: Colors.blue,
                          icon: Icon(Icons.edit),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {},
                          color: Colors.indigo,
                          iconSize: 40.0,
                          icon: Icon(Icons.access_time),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {},
                          iconSize: 40.0,
                          color: Colors.green,
                          icon: Icon(Icons.event_available),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
