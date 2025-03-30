import 'package:flutter/material.dart';

class PageDefault extends StatelessWidget {
  final Widget child;

  const PageDefault({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding:const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xFF0A8A13)
        ),
        child: child,
      ),
    );
  }
}
