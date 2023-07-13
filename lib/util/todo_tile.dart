import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/util/dialog_box.dart';

//ignore: must_be_immutable
class ToDoTile extends StatefulWidget {
  
  const ToDoTile(
      {required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteFunction,
      super.key, required this.save, required this.editCont,  }
    );

  final String taskName;
  final bool taskCompleted;
  final void Function(bool?) onChanged;
  final void Function(BuildContext) deleteFunction;
  final void Function() save;
  final TextEditingController editCont;

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {

  @override
  Widget build(BuildContext conte) {
    return Padding(
      padding: const EdgeInsets.only(left: 28, right: 28, top: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.red,
              onPressed: (ctx){widget.deleteFunction(ctx);},
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
                          showDialog(context: conte, builder: (ctx){
                            return DialogBox(
                              controller: widget.editCont, 
                              onSave: (){widget.save(); widget.editCont.clear();}, 
                              onCancel: (){Navigator.pop(conte);},
                              hintText: 'Edit',);
                            }
                          );
                        }
                        if( value == 'Delete'){
                          widget.deleteFunction(conte);
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
