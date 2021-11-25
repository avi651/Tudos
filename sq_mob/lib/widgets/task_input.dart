import 'package:flutter/material.dart';

class TaskInput extends StatefulWidget {
  final Function onSubmitted;

  TaskInput({@required Function this.onSubmitted});

  @override
  _TaskInputState createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: 40,
              child: const Icon(
                Icons.add,
                color: Color(0xffca3e47),
                size: 30,
              ),
            ),
            Expanded(
              child: TextField(
                minLines: 1,
                maxLines: 2,
                decoration: const InputDecoration(
                    hintText: 'Enter todos', border: InputBorder.none),
                textInputAction: TextInputAction.done,
                controller: textEditingController,
                onEditingComplete: () {
                  widget.onSubmitted(controller: textEditingController);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
