import 'package:flutter/material.dart';
import 'package:task_app/screens/attachment.dart';
import 'package:task_app/screens/message_bubble.dart';
import 'dart:math' as math;

class chatoverviewScreen extends StatefulWidget {
  const chatoverviewScreen({super.key});

  @override
  State<chatoverviewScreen> createState() => _chatoverviewScreenState();
}

class _chatoverviewScreenState extends State<chatoverviewScreen> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: const NetworkImage(
                      "https://c0.wallpaperflare.com/preview/367/1014/409/bridge-man-person-trees.jpg"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Joshua_I",
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.more_horiz_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                MessageBubble(
                    text: 'hii', isCurrentUser: true, time: DateTime.now()),
                MessageBubble(
                    text: 'Hii! how are you',
                    isCurrentUser: false,
                    time: DateTime.now()),
                MessageBubble(
                    text: 'Fine what about you',
                    isCurrentUser: true,
                    time: DateTime.now()),
                MessageBubble(
                    text: 'yeah fine',
                    isCurrentUser: false,
                    time: DateTime.now()),
                MessageBubble(
                    text: 'Fine what about you',
                    isCurrentUser: true,
                    time: DateTime.now()),
                MessageBubble(
                    text: 'yeah fine',
                    isCurrentUser: false,
                    time: DateTime.now()),
              ],
            ),
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 50,
                  width: size.width * 0.8,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: messageController,
                      cursorColor: const Color(0xffffffff),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffffffff),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => Attachement(),
                                );
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.mic_none,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        hintText: 'send message',
                        // hintText: ,
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 187, 183, 183)),
                        fillColor: const Color(0xff00000000),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            color: Color(0xfffffffff),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            color: Color(0xfffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff5200ff),
                      shape: CircleBorder(),
                      fixedSize: Size.fromRadius(24)),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Transform.rotate(
                      angle: 180 * math.pi / 105,
                      child: Icon(
                        Icons.send,
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }
}
