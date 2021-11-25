import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sq_mob/model/db_wrapper.dart';
import 'package:sq_mob/model/model.dart' as Model;
import 'package:sq_mob/utils/utils.dart';
import 'package:sq_mob/widgets/done.dart';
import 'package:sq_mob/widgets/header.dart';
import 'package:sq_mob/widgets/popup.dart';
import 'package:sq_mob/widgets/task_input.dart';
import 'package:sq_mob/widgets/todo.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({Key key}) : super(key: key);

  @override
  _HomeComponentState createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  String welcomeMsg;
  List<Model.Todo> todos;
  List<Model.Todo> dones;
  //String _selection;

  @override
  void initState() {
    super.initState();
    getTodosAndDones();
    welcomeMsg = Utils.getWelcomeMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            Utils.hideKeyboard(context);
          },
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).backgroundColor,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Header(
                                      msg: welcomeMsg,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 35),
                                      child: Popup(
                                        getTodosAndDones: getTodosAndDones,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: TaskInput(
                                  onSubmitted: addTaskInTodo,
                                ), // Add Todos
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                expandedHeight: 200,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    switch (index) {
                      case 0:
                        return Todo(
                          todos: todos,
                          onTap: markTodoAsDone,
                          onDeleteTask: deleteTask,
                        ); // Active todos
                      case 1:
                        return const SizedBox(
                          height: 30,
                        );
                      default:
                        return Done(
                          dones: dones,
                          onTap: markDoneAsTodo,
                          onDeleteTask: deleteTask,
                        ); // Done todos
                    }
                  },
                  childCount: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getTodosAndDones() async {
    final _todos = await DBWrapper.sharedInstance.getTodos();
    final _dones = await DBWrapper.sharedInstance.getDones();

    setState(() {
      todos = _todos;
      dones = _dones;
    });
  }

  void addTaskInTodo({@required TextEditingController controller}) {
    final inputText = controller.text.trim();

    if (inputText.isNotEmpty) {
      // Add todos
      Model.Todo todo = Model.Todo(
        title: inputText,
        created: DateTime.now(),
        updated: DateTime.now(),
        status: Model.TodoStatus.active.index,
      );

      DBWrapper.sharedInstance.addTodo(todo);
      getTodosAndDones();
    } else {
      Utils.hideKeyboard(context);
    }

    controller.text = '';
  }

  void markTodoAsDone({@required int pos}) {
    DBWrapper.sharedInstance.markTodoAsDone(todos[pos]);
    getTodosAndDones();
  }

  void markDoneAsTodo({@required int pos}) {
    DBWrapper.sharedInstance.markDoneAsTodo(dones[pos]);
    getTodosAndDones();
  }

  void deleteTask({@required Model.Todo todo}) {
    DBWrapper.sharedInstance.deleteTodo(todo);
    getTodosAndDones();
  }
}
