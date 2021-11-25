import 'database.dart';
import 'model.dart';

class DBWrapper {
  static final DBWrapper sharedInstance = DBWrapper._();

  DBWrapper._();

  Future<List<Todo>> getTodos() async {
    List list = await DatabaseHelper.sharedInstance.retrieveTodos();
    return list;
  }

  Future<List<Todo>> getDones() async {
    List list = await DatabaseHelper.sharedInstance
        .retrieveTodos(status: TodoStatus.done);
    return list;
  }

  void addTodo(Todo todo) async {
    await DatabaseHelper.sharedInstance.createTodo(todo);
  }

  void markTodoAsDone(Todo todo) async {
    todo.status = TodoStatus.done.index;
    todo.updated = DateTime.now();
    await DatabaseHelper.sharedInstance.updateTodo(todo);
  }

  void markDoneAsTodo(Todo todo) async {
    todo.status = TodoStatus.active.index;
    todo.updated = DateTime.now();
    await DatabaseHelper.sharedInstance.updateTodo(todo);
  }

  void deleteTodo(Todo todo) async {
    await DatabaseHelper.sharedInstance.deleteTodo(todo);
  }

  void deleteAllDoneTodos() async {
    await DatabaseHelper.sharedInstance.deleteAllTodos();
  }
}
