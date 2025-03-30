import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget BuildButton({
  IconData? icon,
  required String label,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) Icon(icon, color: Colors.green),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      ],
    ),
  );
}
