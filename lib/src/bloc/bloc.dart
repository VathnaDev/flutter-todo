import 'package:rxdart/rxdart.dart';
import 'package:todo_app/src/bloc/validators.dart';
import 'package:todo_app/src/model/todo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Bloc extends Object with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  String _userId;

  final _todos = BehaviorSubject<List<Todo>>();

  List<Todo> _listTodos = [];

  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);
  Stream<List<Todo>> get todos => _todos.stream;

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  String get userId => _userId;

  void addTodo(Todo todo) {
    _listTodos.add(todo);
    _todos.sink.add(_listTodos);
  }

  void removeTodo(Todo todo) {
    _listTodos.remove(todo);
    _todos.sink.add(_listTodos);
  }

  Future<FirebaseUser> loginUser() async {
    final validEmail = _email.value;
    final validPassword = _password.value;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: validEmail, password: validPassword);

    if (user != null) _userId = user.uid;
    return user;
  }

  Future<FirebaseUser> registerUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: _email.value, password: _password.value);
    if (user != null) _userId = user.uid;
    return user;
  }

  dispose() {
    _email.close();
    _password.close();
    _todos.close();
  }
}
