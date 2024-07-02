import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Helpers{
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Xatolik '),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'exit',
              ),
            ),
          ],
        );
      },
    );
  }
}
