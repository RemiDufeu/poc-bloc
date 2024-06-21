import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CustomChip extends StatelessWidget {
  final Color color;
  final String label;

  const CustomChip({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: PlatformText(label, style: TextStyle(color: color, fontSize: 10)),
      ),
    );
  }
}
