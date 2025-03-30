import 'package:flutter/material.dart';

class PageDefault extends StatelessWidget {
  final Widget child;

  const PageDefault({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AgroVision'),
        centerTitle: true,
        backgroundColor: Color(0xFF0A8A13),
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF0A8A13)
        ),
        child: child,
      ),
    );
  }
}
