import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100),
      child: Ink(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blue,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: onTap,
          child: const Center(
            child: Icon(Icons.add_location_alt)
          ),
        ),
      ),
    );
  }
}
