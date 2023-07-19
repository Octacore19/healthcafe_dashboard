import 'package:flutter/material.dart';

class Textbutton extends StatelessWidget {
  const Textbutton({required this.label, required this.onTap, super.key});

  final VoidCallback? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        minimumSize: const Size(double.maxFinite, 0)
      ),
      child: Text(label),
    );
  }
}
