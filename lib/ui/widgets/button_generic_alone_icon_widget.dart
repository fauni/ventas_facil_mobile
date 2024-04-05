import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonGenericAloneIconWidget extends StatelessWidget {
  ButtonGenericAloneIconWidget({
    super.key,
    required this.icon,
    required this.height,
    required this.onPressed
  });

  final IconData icon;
  final double height;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: IconButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10), 
              topRight: Radius.circular(10)
            ),
          )
        ), 
        icon: Icon(icon),
      ),
    );
  }
}