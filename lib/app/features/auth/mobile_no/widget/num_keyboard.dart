import 'package:flutter/material.dart';

class NumericKeypad extends StatefulWidget {
  final TextEditingController controller;
  const NumericKeypad({super.key,required this.controller});

  @override
  State<NumericKeypad> createState() => _NumericKeypadState();
}

class _NumericKeypadState extends State<NumericKeypad> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

