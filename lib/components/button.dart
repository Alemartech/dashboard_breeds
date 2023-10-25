import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double width;
  final String title;
  final bool disabled;
  final Function() onPressed;
  const Button(
      {Key? key,
      required this.width,
      required this.title,
      required this.onPressed,
      this.disabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          //  backgroundColor: Config.primaryColor,
          foregroundColor: Colors.white,
        ),
        onPressed: disabled ? null : onPressed,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
