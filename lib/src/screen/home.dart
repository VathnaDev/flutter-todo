import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/bloc/bloc.dart';
import 'package:todo_app/src/bloc/provider.dart';
import 'package:todo_app/src/model/todo.dart';
import 'package:todo_app/src/screen/new_todo.dart';
import 'package:todo_app/src/widget/todo_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Bloc bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      drawer: _buildDrawer(),
      body: Column(
        children: <Widget>[
          _buildSummeryCard(),
          _buildListTodos(bloc),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTodoScreen()),
          );
        },
      ),
    );
  }
}

Widget _buildDrawer() {
  return Drawer(
    child: Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  "https://www.atlassian.com/dam/jcr:13a574c1-390b-4bfb-956b-6b6d114bf98c/max-rehkopf.png")),
          accountEmail: Text("Vathna@gmail.com"),
          accountName: Text("Vahnadev"),
        ),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("Home"),
                leading: Icon(Icons.home),
                onTap: () {},
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget _buildSummeryCard() {
  return SizedBox(
    width: double.infinity,
    height: 130.0,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Card(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Good Morning Vathnna",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "TODAY",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      DateFormat.yMMMd().format(DateTime.now()),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Completed",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "4/10",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                ))
          ],
        ),
      ),
    ),
  );
}

Widget _buildListTodos(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.todos,
    builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
      return Expanded(
        child: TodoList(
          todos: snapshot.data,
        ),
      );
    },
  );
}
