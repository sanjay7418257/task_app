import 'package:flutter/material.dart';

import 'chatoverviewscreen.dart';

class chatwidget extends StatefulWidget {
  const chatwidget({super.key});

  @override
  State<chatwidget> createState() => _chatwidgetState();
}

class _chatwidgetState extends State<chatwidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListTile(
      visualDensity: VisualDensity(vertical: -4),
      contentPadding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.03,
      ),
      leading: const CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(
            'https://thumbs.dreamstime.com/z/handsome-foreigner-answering-message-enjoying-conversation-joyful-international-student-bowing-head-keeping-smile-his-face-108343952.jpg'),
      ),
      title: const Text(
        'Joshua_I',
        style: TextStyle(
          color: Color(0xffffffff),
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: const Text(
        'Sent',
        style: TextStyle(
          fontSize: 13,
          color: Color(0xffb6b0b0),
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: const Icon(
        Icons.more_horiz_outlined,
        color: Color(0xffffffffff),
      ),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: ((context) => chatoverviewScreen())));
      },
    );
  }
}
