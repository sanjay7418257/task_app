import 'package:flutter/material.dart';

class historywidget extends StatefulWidget {
  const historywidget({super.key});

  @override
  State<historywidget> createState() => _historywidgetState();
}

class _historywidgetState extends State<historywidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Stack(
            children: [
              Container(
                height: size.height * 0.08,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: Color(0xff1c1c1e),
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
                      Text(
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
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Color(0xffffffff),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Text(
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
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: size.width * 0.04,
                            height: size.height * 0.04,
                            decoration: BoxDecoration(
                              color: const Color(0xff009e10),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.check,
                            size: 10,
                            color: Color(0xffffffff),
                          )
                        ],
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text(
                        'Approved',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff009e10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: size.height * 0.08,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: Color(0xff1c1c1e).withOpacity(0.4),
                  border: Border.all(
                    color: const Color(0xff1c1c1e),
                  ),
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        )
      ],
    );
  }
}
