import 'package:flutter/cupertino.dart';

void showConfirmationDialog(BuildContext context, String title, String content, List<CupertinoDialogAction> actions) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(
        title,
      ),
      content: Text(
        content,
      ),
      actions: actions,
    ),
  );
}
