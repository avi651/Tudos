import 'package:flutter/material.dart';

import 'package:sq_mob/model/model.dart' as Model;
import 'package:sq_mob/utils/colors.dart';
import 'package:sq_mob/widgets/shared.dart';

const int NoTask = -1;
const int animationMilliseconds = 500;

class Todo extends StatefulWidget {
  final Function onTap;
  final Function onDeleteTask;
  final List<Model.Todo> todos;

  Todo({@required this.todos, this.onTap, this.onDeleteTask});

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  int taskPosition = NoTask;
  bool showCompletedTaskAnimation = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              if (widget.todos == null || widget.todos.isEmpty)
                Container(
                  height: 10,
                ),
              if (widget.todos != null)
                for (int i = 0; i < widget.todos.length; ++i)
                  AnimatedOpacity(
                    curve: Curves.fastOutSlowIn,
                    opacity: taskPosition != i
                        ? 1.0
                        : showCompletedTaskAnimation
                            ? 0
                            : 1,
                    duration: const Duration(seconds: 1),
                    child: getTaskItem(
                      widget.todos[i].title,
                      index: i,
                      onTap: () {
                        setState(() {
                          taskPosition = i;
                          showCompletedTaskAnimation = true;
                        });
                        Future.delayed(
                          const Duration(milliseconds: animationMilliseconds),
                        ).then((value) {
                          taskPosition = NoTask;
                          showCompletedTaskAnimation = false;
                          widget.onTap(pos: i);
                        });
                      },
                    ),
                  ),
            ],
          ),
        ),
        SharedWidget.getCardHeader(
            context: context, text: 'TO DO', customFontSize: 16),
      ],
    );
  }

  Widget getTaskItem(String text,
      {@required int index, @required Function onTap}) {
    return Container(
        child: Column(
      children: <Widget>[
        Dismissible(
          key: Key(text + '$index'),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            widget.onDeleteTask(todo: widget.todos[index]);
          },
          background: SharedWidget.getOnDismissDeleteBackground(),
          child: InkWell(
            onTap: onTap,
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 7,
                    decoration: BoxDecoration(
                      color: TodosColor.sharedInstance.leadingTaskColor(index),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, top: 15, right: 20, bottom: 15),
                      child: Text(
                        text,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 0.5,
          child: Container(
            color: Colors.grey,
          ),
        ),
      ],
    ));
  }
}
