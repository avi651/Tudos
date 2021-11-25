import 'package:flutter/material.dart';
import 'package:sq_mob/utils/colors.dart';

class SharedWidget {
  static Widget getCardHeader(
      {@required BuildContext context,
      @required String text,
      Color textColor = Colors.white,
      int backgroundColorCode = TodosColor.kPrimaryColorCode,
      double customFontSize}) {
    customFontSize ??= 15;

    return Container(
      width: 85,
      alignment: AlignmentDirectional.center,
      margin: const EdgeInsets.only(left: 32),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(backgroundColorCode),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
          fontSize: customFontSize,
        ),
      ),
    );
  }

  static Widget getOnDismissDeleteBackground() {
    return Container(
      alignment: Alignment.centerRight,
      color: Colors.red[300],
      padding: const EdgeInsets.only(right: 10),
      child: const Text(
        'DELETE',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
