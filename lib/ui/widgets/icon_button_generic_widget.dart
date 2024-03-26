import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IconButtonGenericWidget extends StatelessWidget {
  IconButtonGenericWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed
  });

  final String label;
  final IconData icon;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed, 
      icon: Icon(icon), 
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
    );
  }
}