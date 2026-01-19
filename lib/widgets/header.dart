import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Hello,",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '4 Tasks ',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'today',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
