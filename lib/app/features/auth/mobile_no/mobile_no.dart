// ui/mobile_input_page.dart
import 'package:flutter/material.dart';

import '../../../../domain/auth/mobile_no/mobile_no_state.dart';
import '../../screen_export.dart';


class MobileNoScreen extends StatefulWidget {
  final MobileNoViewModel viewModel;
  const MobileNoScreen({super.key,required this.viewModel});

  @override
  State<MobileNoScreen> createState() => _MobileNoScreenState();
}

class _MobileNoScreenState extends State<MobileNoScreen> {
  final TextEditingController _controller = TextEditingController();


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<MobileInputState>(
        stream: widget.viewModel.state,
        initialData: widget.viewModel.currentState,
        builder: (context, snapshot) {
          final state = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Enter your mobile number", style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text("+91", style: TextStyle(fontSize: 16)),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.none,
                        maxLength: 10,
                        decoration: InputDecoration(
                          hintText: "Enter 10-digit number",
                          counterText: "",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: widget.viewModel.onMobileChanged,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: state.isValid ? widget.viewModel.onSubmit : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text("Submit"),
                ),
                if (state.isSubmitted)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      "Mobile Submitted: +91${state.mobile}",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                NumericKeypad(controller: _controller)

              ],
            ),
          );
        },
      ),
    );
  }
}
