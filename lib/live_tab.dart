import 'package:flutter/material.dart';

class LiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.wifi, color: Colors.redAccent, size: 18),
        SizedBox(width: 4),
        Text('LIVE',
            style: TextStyle(
                color: Colors.redAccent, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
