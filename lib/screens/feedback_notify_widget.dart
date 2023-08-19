import 'package:flutter/material.dart';

class FeedBackNotify extends StatelessWidget {
  FeedBackNotify({required this.feedbackData, super.key});
  final feedbackData;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: size.height * 0.070,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          // color: Color(0xff1c1c1e),
          border: Border.all(
            color: const Color(0xffffffff),
          ),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://c0.wallpaperflare.com/preview/367/1014/409/bridge-man-person-trees.jpg'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${feedbackData['notifyBody']}submitted our feedback',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Oct 19',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
