import 'package:flutter/material.dart';

class historyfeedback extends StatefulWidget {
  const historyfeedback({super.key});

  @override
  State<historyfeedback> createState() => _historyfeedbackState();
}

class _historyfeedbackState extends State<historyfeedback> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.009,
          ),
          child: Container(
            height: size.height * 0.08,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color: const Color(0xff1c1c1e),
              border: Border.all(
                color: const Color(0xff1c1c1e),
              ),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://c0.wallpaperflare.com/preview/367/1014/409/bridge-man-person-trees.jpg'),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  const Text(
                    'Maryam',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffffffff),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.10,
                  ),
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: Color(0xffffffff),
                  ),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  const Text(
                    'Oct 19',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffffffff),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.12,
                  ),
                  Icon(
                    Icons.delete_outline_outlined,
                    color: Color(0xffff8282),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  Icon(
                    Icons.file_download_outlined,
                    color: Color(0xffffffff),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
