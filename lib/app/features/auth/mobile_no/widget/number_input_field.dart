import 'package:flutter/material.dart';

class NumberInputField extends StatelessWidget {
   final TextEditingController controller;
  const NumberInputField({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text("+91", style: TextStyle(fontSize: 16)),
        ),
        SizedBox(width: 5),
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.none,
            maxLength: 10,
            decoration: InputDecoration(
              hintText: "Enter 10-digit number",
              counterText: "",
              border: OutlineInputBorder(),
            ),

          ),
        ),
      ],
    );
  }
}
