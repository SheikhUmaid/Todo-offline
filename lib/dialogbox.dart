import 'package:flutter/material.dart';
import 'package:todo/button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.red,
      content: SizedBox(
        height: 120,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Add a Todo'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Button(text: 'Add', onPressed: onSave),
              Button(text: 'Cancel', onPressed: onCancel),
            ],
          )
        ]),
      ),
    );
  }
}
