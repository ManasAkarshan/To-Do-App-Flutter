import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  const ToDoTile({required this.taskName, required this.taskCompleted, required this.onChanged, required this.deleteFunction, super.key});

  final String taskName;
  final bool taskCompleted;
  final void Function(bool?) onChanged;
  final void Function(BuildContext) deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28, right: 28, top: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.red,
              onPressed: deleteFunction,
              icon: Icons.delete,
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted, 
                onChanged: onChanged,
                activeColor: Theme.of(context).colorScheme.secondary
              ),
              Text(
                taskName,
                style: TextStyle(
                  fontSize: 15,
                  decoration: taskCompleted 
                  ? TextDecoration.lineThrough 
                  : TextDecoration.none,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}