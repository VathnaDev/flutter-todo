import 'package:flutter/material.dart';
import 'package:todo_app/src/model/todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function onTodoTapped;
  final Function onTodoSwipeToLeft;
  final Function onTodoSwipeToRight;

  TodoList({
    this.todos,
    this.onTodoSwipeToLeft,
    this.onTodoSwipeToRight,
    this.onTodoTapped,
  });

  @override
  Widget build(BuildContext context) {
    if (todos == null || todos.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/meditation.png'),
          SizedBox(height: 16.0),
          Text(
            "Relax",
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'Raleway',
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        Todo todo = todos[index];
        return Dismissible(
          background: Card(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(color: Colors.green),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.event_available,
                    color: Colors.white,
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    "Done",
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                ],
              ),
            ),
          ),
          secondaryBackground: Card(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(color: Colors.red),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Later",
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                  SizedBox(width: 16.0),
                  Icon(
                    Icons.access_time,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          key: Key(todo.todo),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.startToEnd) {
              onTodoSwipeToRight(todo);
            } else {
              onTodoSwipeToLeft(todo);
            }
          },
          child: InkWell(
            onTap: () {
              onTodoTapped(todo);
            },
            child: Card(
              child: ListTile(
                title: Text(todo.todo),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.grade,
                      color: Colors.yellow,
                    ),
                    SizedBox(width: 8.0),
                    Icon(
                      Icons.brightness_1,
                      color: Colors.red,
                    ),
                  ],
                ),
                subtitle: Text(todo.todoTime.format(context)),
              ),
            ),
          ),
        );
      },
    );
  }
}
