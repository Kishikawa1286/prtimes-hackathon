import 'package:flutter/material.dart';

class BackNavigationButton extends StatelessWidget {
  const BackNavigationButton({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
              size: 14,
            ),
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
}
