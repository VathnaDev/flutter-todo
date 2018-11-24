import 'package:flutter/material.dart';

class Todo {
  String todo;
  String description;
  DateTime todoDate;
  TimeOfDay todoTime;
  String category;
  int priority;
  String location;

  Todo(this.todo, this.description, this.todoDate, this.todoTime, this.category,
      this.priority, this.location);
}
