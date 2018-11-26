import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Todo {
  String id;
  String todo;
  String description;
  DateTime todoDate;
  TimeOfDay todoTime;
  String category;
  int priority;
  String location;
  bool isDone;

  String documentId;

  Todo(this.id, this.todo, this.description, this.todoDate, this.todoTime,
      this.category, this.priority, this.location, this.isDone,
      {this.documentId});

  Map<String, dynamic> toMap() => {
        'id': this.id,
        'todo': todo,
        'description': description,
        'todoDate': todoDate.millisecondsSinceEpoch,
        'todoTime': DateTime(0, 0, 0, todoTime.hour, todoTime.minute)
            .millisecondsSinceEpoch,
        'category': category,
        'priority': priority,
        'location': location,
        'isDone': isDone
      };

  Todo.fromMap(Map<String, dynamic> data, String documentId)
      : this(
          data['id'],
          data['todo'],
          data['description'],
          DateTime.fromMillisecondsSinceEpoch(data['todoDate']),
          TimeOfDay.fromDateTime(
              DateTime.fromMillisecondsSinceEpoch(data['todoTime'])),
          data['category'],
          data['priority'],
          data['location'],
          data['isDone'],
          documentId: documentId,
        );
}
