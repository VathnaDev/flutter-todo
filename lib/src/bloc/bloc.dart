import 'package:rxdart/rxdart.dart';
import 'package:todo_app/src/bloc/validators.dart';
import 'package:todo_app/src/model/todo.dart';

class Bloc extends Object with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  final _todos = BehaviorSubject<List<Todo>>();
  List<Todo> _listTodos = [];

  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);
  Stream<List<Todo>> get todos => _todos.stream;

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  void addTodo(Todo todo) {
    _listTodos.add(todo);
    _todos.sink.add(_listTodos);
  }

  void removeTodo(Todo todo) {
    _listTodos.remove(todo);
    _todos.sink.add(_listTodos);
  }

  bool submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;

    print('$validEmail and $validPassword');
    return true;
  }

  dispose() {
    _email.close();
    _password.close();
    _todos.close();
  }
}
