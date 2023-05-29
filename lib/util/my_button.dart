import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({required this.text, required this.onClicked, super.key});

  final String text;
  final void Function() onClicked;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      onPressed: onClicked,
      child: Text(text),
    );
  }
}