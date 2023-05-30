import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/util/dialog_box.dart';

import '../data/database.dart';

//ignore: must_be_immutable
class ToDoTile extends StatefulWidget {
  
   ToDoTile(
      {required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteFunction,
      super.key,  }
    );

  String taskName;
  bool taskCompleted;
  final void Function(bool?) onChanged;
  final void Function(BuildContext) deleteFunction;

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  final editController = TextEditingController();
  ToDoDataBase db = ToDoDataBase();

  void saveEdit(String edit){
    if(edit.isNotEmpty){
      setState(() {
        db.toDoList.remove([widget.taskName, widget.taskCompleted]);
        widget.taskName = edit;
        widget.taskCompleted = false;
        db.toDoList.add([edit, false]);
        editController.clear();
      });
      Navigator.pop(context);
      db.updateDataBase();
    }
  }

  

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
              onPressed: widget.deleteFunction,
              icon: Icons.delete,
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Checkbox(
                        value: widget.taskCompleted,
                        onChanged: widget.onChanged,
                        activeColor: Theme.of(context).colorScheme.secondary),
                    Expanded(
                      child: Text(
                        widget.taskName,
                        style: TextStyle(
                          fontSize: 15,
                          decoration: widget.taskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                      onSelected: (value) {
                        if(value == 'Edit'){
                          showDialog(context: context, builder: (ctx){
                            return DialogBox(
                              controller: editController, 
                              onSave: (){saveEdit(editController.text);}, 
                              onCancel: (){Navigator.pop(context);},
                              hintText: 'Edit',);
                            }
                          );
                        }
                        if( value == 'Delete'){
                          widget.deleteFunction(context);
                        }
                        
                      },
                      child: Icon(Icons.more_horiz),
                      itemBuilder: (ctx){
                        return [
                          const PopupMenuItem(
                            value: 'Edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem(
                            value: 'Delete',
                            child: Text('Delete'),
                          )
                        ];
                      }
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
