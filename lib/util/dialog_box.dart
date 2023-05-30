import 'package:flutter/material.dart';
import 'package:todo/util/my_button.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({required this.controller,required this.onSave, required this.onCancel, super.key, required this.hintText});

  final TextEditingController controller;

  final void Function() onSave;
  final void Function() onCancel;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 120,
        color: Theme.of(context).colorScheme.secondary,
        child: Column(
          children: [
            TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: hintText
              ),
            ),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                MyButton(text: 'Save', onClicked: onSave),
                const SizedBox(width: 6,),
                //cancel button
                MyButton(text: 'Cancel', onClicked: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}