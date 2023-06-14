import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_app/Admin/feedbackwidget.dart';
import 'package:task_app/Admin/historyfeedback.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_app/Modal/authenticate.dart';
import 'package:uuid/uuid.dart';

import '../Modal/announce.dart';
import 'leavewidget.dart';

class adminleave extends StatefulWidget {
  const adminleave({super.key});

  @override
  State<adminleave> createState() => _adminleaveState();
}

class _adminleaveState extends State<adminleave> {
  String name = '';
  String email = '';
  bool circle = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(name);
      }
    } catch (e) {
      Text(
        'SignUp Error: $e',
        style: TextStyle(color: Color(0xffffffff)),
      );
      return null;
    }
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordtroller = TextEditingController();
  TextEditingController _announcement = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool switches = false;
  bool isLoading = true;
  void _submit() {
    final _isValid = _form.currentState!.validate();
    if (_isValid) {
      _form.currentState!.save();
    }
  }

  // void toggleSwitch(bool value) {
  //   fetch(switches);
  //   if (switches == false) {
  //     setState(() {
  //       switches = true;
  //     });
  //   } else {
  //     setState(() {
  //       switches = false;
  //     });
  //   }
  // }

  // Future<void> fetch(bool switches) async {
  //   await FirebaseFirestore.instance
  //       .collection('switch')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .set({
  //     'toggleValue': switches,
  //     'createdDate': DateTime.now(),
  //   });

  // }

  void get() async {
    await FirebaseFirestore.instance.collection('1').doc('1').update({
      'isFeedback': switches,
      'lastfeedback Active date': DateTime.now(),
    });
  }

  Future<void> getSwitchStatus() async {
    var s = await FirebaseFirestore.instance.collection('1').doc('1').get();
    setState(() {
      switches = s.data()!['isFeedback'];
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    getSwitchStatus();
    super.initState();
  }

  bool history = false;

  void cleartext() {
    _emailController.text = '';
    _passwordtroller.text = '';
    _nameController.text = '';
    _announcement.text = '';
  }

  bool _isVisible = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Color(0xff1c1c1e),
                      title: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffffffff),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      scrollable: true,
                      content: Container(
                        height: size.height * 0.39,
                        width: size.width * 0.9,
                        child: Form(
                          key: _form,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' Name',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                height: size.height * 0.06,
                                child: TextFormField(
                                  controller: _nameController,
                                  cursorColor: const Color(0xffffffff),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffffffff),
                                  ),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xfffffffff),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xfffffffff),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                'Email',
                                style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                height: size.height * 0.06,
                                child: TextFormField(
                                  controller: _emailController,
                                  cursorColor: const Color(0xffffffff),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffffffff),
                                  ),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xfffffffff),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xfffffffff),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty ||
                                        !value.contains('@')) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                'password',
                                style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                height: size.height * 0.06,
                                child: TextFormField(
                                  controller: _passwordtroller,
                                  cursorColor: const Color(0xffffffff),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffffffff),
                                  ),
                                  obscureText: _isVisible,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isVisible = !_isVisible;
                                        });
                                      },
                                      icon: _isVisible
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility),
                                      color: Color(0xffffffff),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xfffffffff),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xfffffffff),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().length < 6) {
                                      return 'Please must be at least 6 characters long.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Center(
                                child: circle
                                    ? CircularProgressIndicator()
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color(0xff5200ff),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          // textStyle: const TextStyle(
                                          //   fontSize: 16,
                                          //   fontWeight: FontWeight.w500,
                                          // ),
                                          fixedSize: Size(size.width * 0.30,
                                              size.height * 0.05),

                                          elevation: 8,
                                        ),
                                        onPressed: () async {
                                          name = _nameController.text.trim();
                                          email = _emailController.text.trim();
                                          if (_form.currentState!.validate()) {
                                            signUp(
                                                    _emailController.text
                                                        .trim(),
                                                    _passwordtroller.text
                                                        .trim(),
                                                    _nameController.text.trim())
                                                .then((value) async {
                                              var a = authenticate(
                                                name: name,
                                                email: email,
                                                image: '',
                                                uuid: FirebaseAuth
                                                    .instance.currentUser!.uid,
                                              );
                                              await FirebaseFirestore.instance
                                                  .collection('Users Data')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .set(a.tojson());
                                            });
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  adminleave(),
                                            ));
                                          }
                                          cleartext();
                                        },
                                        child: const Text(
                                          'Create User',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            icon: const Icon(
              Icons.group_add_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_sharp,
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.08,
                        vertical: size.height * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Leave',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Track',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff5200ff),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('Leave details')
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: List.generate(
                              snapshot.data!.docs.length,
                              (index) => leavewidget(
                                    snapped: snapshot.data!.docs[index],
                                  )),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.08,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'FeedBack',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Transform.scale(
                          scale: 1,
                          child: Switch(
                            value: switches,
                            onChanged: (bool value) {
                              setState(() {
                                switches = value;
                              });
                              get();
                            },
                            activeColor: (const Color(0xffffffff)),
                            activeTrackColor: (const Color(0xff009e10)),
                            inactiveTrackColor: const Color(0xff1c1c1e),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future:
                        FirebaseFirestore.instance.collection('Feedback').get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: List.generate(
                              snapshot.data!.docs.length,
                              (index) => feedbackwidget(
                                    feedbackdata: snapshot.data!.docs[index],
                                  )),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.08,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'History FeedBack',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              history = !history;
                            });
                          },
                          child: history
                              ? const Icon(
                                  Icons.keyboard_arrow_up_outlined,
                                  color: Color(0xffffffff),
                                  size: 32,
                                )
                              : const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Color(0xffffffff),
                                  size: 32,
                                ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  if (history)
                    Column(
                      children:
                          List.generate(3, (index) => const historyfeedback()),
                    ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.08,
                        vertical: size.height * 0.01),
                    child: const Text(
                      'Send Announcement',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.08),
                    child: TextFormField(
                      controller: _announcement,
                      cursorColor: const Color(0xffffffff),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffffffff),
                      ),
                      maxLines: null,
                      minLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        fillColor: const Color(0xff00000000),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            color: Color(0xfffffffff),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            color: Color(0xfffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff5200ff),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        // textStyle: const TextStyle(
                        //   fontSize: 16,
                        //   fontWeight: FontWeight.w500,
                        // ),
                        fixedSize: Size(size.width * 0.28, size.height * 0.05),

                        elevation: 8,
                      ),
                      onPressed: () async {
                        var uuid = Uuid();
                        var i = uuid.v4();
                        var a = announce(
                            announcement: _announcement.text,
                            uuid: FirebaseAuth.instance.currentUser!.uid,
                            createdDate: DateTime.now(),
                            id: i);
                        await FirebaseFirestore.instance
                            .collection('Announcement')
                            .doc(i)
                            .set(a.tojson());
                        // await FirebaseFirestore.instance
                        //     .collection('Announcement')
                        //     .doc(FirebaseAuth.instance.currentUser!.uid)
                        //     .update({'announcement': _announcement.text});
                        await FirebaseFirestore.instance
                            .collection('1')
                            .doc('1')
                            .update({
                          'announcement': true,
                          'sendAnnouncementdate': DateTime.now()
                        });
                        cleartext();
                      },
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                ],
              ),
            ),
    );
  }
}
