import 'package:flutter/material.dart';
import 'package:totowala/core/decoration/app_decoration.dart';
import 'package:totowala/core/theme/typography.dart';

import '../../../../../core/theme/colors.dart';

class NumericKeypad extends StatefulWidget {
  final TextEditingController controller;
  final int length;
  const NumericKeypad({super.key,required this.controller,required this.length});

  @override
  State<NumericKeypad> createState() => _NumericKeypadState();
}

class _NumericKeypadState extends State<NumericKeypad> {
  late TextEditingController _controller;
  double padding10= 10.0;
  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  void dispose() {
    _controller.dispose;
    // dispose stuff later
    super.dispose();
  }

  // 1
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(top: padding10 * .5),
            child: Row(
              children: [
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: padding10 * .5),
            child: Row(
              children: [
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: padding10 * .5),
            child: Row(
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: padding10 * .5),
            child: Row(
              children: [
                _buildBlankButton(),
                _buildButton('0'),
                _buildBackButton('⌫',
                    onPressed: _backspace, longBackspace: _longBackspace),
                // _buildDelIconButton("assets/images/ic_bio_blue.png", onPressed: _backspace,longBackspace:_longBackspace),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Individual keys
  Widget _buildButton(String text,
      {VoidCallback? onPressed, VoidCallback? longBackspace}) {
    return Expanded(
      child: Container(
        height: padding10 * 5,
        width: padding10 * 6.4,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: AppDecoration.kKeyboardDecoration(),
        child: TextButton(
          onPressed: onPressed ?? () => _input(text),
          onLongPress: longBackspace ?? () => _input(text),
          child: Text(
            text,
            style:  kTextStyleCustomSemiBold( size: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(String text,
      {VoidCallback? onPressed, VoidCallback? longBackspace}) {
    return Expanded(
      child: Container(
        height: padding10 * 5,
        width: padding10 * 6.4,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: AppDecoration.kKeyboardDecoration(from: 'blank'),
        child: TextButton(
          onPressed: onPressed ?? () => _input(text),
          onLongPress: longBackspace ?? () => _input(text),
          child: Text(
            text,
            style: kTextStyleCustomSemiBold( size: 25),
          ),
        ),
      ),
    );
  }

  // Individual keys
  Widget _buildBlankButton() {
    return Expanded(
      child: Container(
        height: padding10 * 5,
        width: padding10 * 6.4,
        margin: EdgeInsets.symmetric(horizontal: padding10*0.5, vertical: 2),
        decoration: AppDecoration.kKeyboardDecoration(from: 'blank'),
      ),
    );
  }

// 3
  void _input(String text) {
    // inputs text
    if(_controller.text.length>=10)return;
    final value = _controller.text + text;
    _controller.text = value;
  }

// 4
  void _backspace() {
    // clear
    final value = _controller.text;
    if (value.isNotEmpty) {
      _controller.text = value.substring(0, value.length - 1);
    }
  }

  void _longBackspace() {
    // clear
    final value = _controller.text;
    if (value.isEmpty) return;
    setState(() {
      _controller.text = '';
    });
  }
}

