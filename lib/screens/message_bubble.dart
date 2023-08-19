import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isCurrentUser;
  final DateTime time;
  const MessageBubble(
      {required this.text,
      required this.isCurrentUser,
      required this.time,
      super.key});

  @override
  Widget build(context) {
    String formattedTime = DateFormat.Hm().format(time);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Align(
            alignment:
                isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: isCurrentUser ? Color(0xff1c1c1e) : Color(0xA50079FE),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment:
              isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              formattedTime,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
