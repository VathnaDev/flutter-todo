import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_app/src/bloc/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/src/model/todo.dart';

class Bloc extends Object with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _todos = BehaviorSubject<QuerySnapshot>();

  Stream<String> get email => _email.stream.transform(validateEmail);

  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Stream<QuerySnapshot> getTodos() {
    getTodo();
    return _todos;
  }

  Future<FirebaseUser> loginUser() async {
    final validEmail = _email.value;
    final validPassword = _password.value;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: validEmail, password: validPassword);

    return user;
  }

  Future<FirebaseUser> registerUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: _email.value, password: _password.value);
    return user;
  }

  Future<FirebaseUser> getUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return await _auth.currentUser();
  }

  void updateTodo(Todo todo) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await Firestore.instance
        .collection("users")
        .document(user.uid)
        .collection("todos")
        .document(todo.documentId)
        .setData(todo.toMap());
  }

  void deleteTodo(Todo todo) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await Firestore.instance
        .collection("users")
        .document(user.uid)
        .collection("todos")
        .document(todo.documentId)
        .delete();
  }

  void getTodo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var data = Firestore.instance
        .collection("users")
        .document(user.uid)
        .collection("todos")
        .snapshots();
    data.listen((snapshot) {
      _todos.add(snapshot);
    });
  }

  dispose() {
    _email.close();
    _password.close();
    _todos.close();
  }
}
