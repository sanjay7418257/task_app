import 'package:flutter/material.dart';

import 'chatwidget.dart';

class chatscreen extends StatefulWidget {
  const chatscreen({super.key});

  @override
  State<chatscreen> createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  final TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff000000),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Container(
                  height: size.height * 0.06,
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 3,
                  ),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Color(0xffFFFFFF)),
                    controller: _search,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 4),
                        border: InputBorder.none,
                        fillColor: const Color(0xFFFFFFFF),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        hintText: "Search...",
                        hintStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Column(
                children: List.generate(8, (index) => chatwidget()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
