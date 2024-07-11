import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final Function(String) onSendPressed;
  final Function() onUploadPressed;
  final bool enabled;

  const CustomInput({
    Key? key,
    required this.onSendPressed,
    required this.onUploadPressed,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      color: Colors.blueGrey[50],
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: onUploadPressed,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              enabled: enabled,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Type a message',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              final text = _controller.text;
              if (text.isNotEmpty) {
                onSendPressed(text);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
