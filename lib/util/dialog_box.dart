import 'package:flutter/material.dart';
import 'package:todo/util/my_button.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({required this.controller,required this.onSave, required this.onCancel, super.key});

  final TextEditingController controller;

  final void Function() onSave;
  final void Function() onCancel;

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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add new task'
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