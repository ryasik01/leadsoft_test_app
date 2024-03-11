import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        // width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: child);
  }
}
