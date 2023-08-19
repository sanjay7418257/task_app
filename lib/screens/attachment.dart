import 'package:flutter/material.dart';

class Attachement extends StatelessWidget {
  const Attachement({super.key});

  @override
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      //height: size.height * 0.3,
      //padding: EdgeInsets.only(left: size.width * 0.55),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.32,
          vertical: size.height * 0.1,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color(0xff1c1c1e),
        ),
        height: size.height * 0.08,
        width: size.width * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  child: InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.image_outlined,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                const Text(
                  'Image',
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  child: InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.file_copy_outlined,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                const Text(
                  'Files',
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
