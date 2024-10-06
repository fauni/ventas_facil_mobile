import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonGenericWidget extends StatelessWidget {
  ButtonGenericWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.height,
    required this.width,
    required this.onPressed
  });

  final String label;
  final IconData icon;
  final double height;
  final double width;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10), 
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10)
            ),
          )
        ), 
        icon: Icon(icon),
      ),
    );
  }
}