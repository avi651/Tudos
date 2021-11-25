import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:sq_mob/constants.dart';
import 'package:sq_mob/model/db_wrapper.dart';
import 'package:sq_mob/utils/utils.dart';

class Popup extends StatelessWidget {
  Function getTodosAndDones;

  Popup({this.getTodosAndDones});

  get kAppPortfolioApple => null;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
        elevation: 4,
        icon: const Icon(Icons.more_vert),
        onSelected: (value) {
          if (value == kMoreOptionsKeys.clearAll.index) {
            Utils.showCustomDialog(context,
                title: 'Are you sure?',
                msg: 'All done todos will be deleted permanently',
                onConfirm: () {
              DBWrapper.sharedInstance.deleteAllDoneTodos();
              getTodosAndDones();
            });
          }
        },
        itemBuilder: (context) {
          List list = List<PopupMenuEntry<int>>();

          for (int i = 0; i < kMoreOptionsMap.length; ++i) {
            list.add(PopupMenuItem(value: i, child: Text(kMoreOptionsMap[i])));
          }

          return list;
        });
  }
}
