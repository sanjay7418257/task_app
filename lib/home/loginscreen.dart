import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_app/screens/homescreen.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  bool showSpinner = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => homeScreen())));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17)),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Wrong Mail ID'),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.dangerous_outlined,
                        size: 34,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            });
        print('No user found for the email');
      } else if (e.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17)),
                content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Wrong Password'),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.dangerous_outlined,
                            size: 34,
                            color: Colors.red,
                          ))
                    ]),
              );
            });
        print('wrong password provided');
      } else {
        print("error: ${e.code}");
      }
    } catch (e) {
      print('Error:$e');
    }
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff1c1c1e),
      appBar: AppBar(
        leadingWidth: size.width * 0.2,
        elevation: 0,
        backgroundColor: Color(0xff1c1c1e),
        leading: Icon(
          Icons.arrow_back_ios,
          color: Color(0xffffffff),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.05, left: size.width * 0.06),
                  child: Text(
                    'Let\'s sign you in.',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 34,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.06),
                  child: Text(
                    'Welcome back.',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 28,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.14,
                ),
                Container(
                  padding: EdgeInsets.only(left: size.width * 0.09),
                  height: size.height * 0.08,
                  width: size.width * 0.9,
                  child: TextFormField(
                    cursorColor: Colors.grey,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffffffff),
                    ),
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Phone, email or username',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(17.0),
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
                  height: size.height * 0.03,
                ),
                Container(
                  padding: EdgeInsets.only(left: size.width * 0.09),
                  height: size.height * 0.08,
                  width: size.width * 0.9,
                  child: TextFormField(
                    cursorColor: Colors.grey,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffffffff),
                    ),
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(17.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().length < 6) {
                        return 'Please must be at least 6 characters long.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.15,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: showSpinner
          ? CircularProgressIndicator()
          : FloatingActionButton.extended(
              extendedPadding: EdgeInsets.symmetric(
                horizontal: size.width * 0.34,
                vertical: size.height * 0.34,
              ),
              disabledElevation: 0.0,
              backgroundColor: Color(0xffffffff),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17)),
              onPressed: () {
                showLoaderDialog(context);
                if (_form.currentState!.validate()) {
                  setState(() {
                    showSpinner = true;
                  });
                  signIn(_emailController.text.trim(),
                      _passwordController.text.trim());
                  setState(() {
                    showSpinner = false;
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('Wrognly typed email & password'),
                      );
                    },
                  );
                }
              },
              label: Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Color(0xff1c1c1e),
      content: Row(
        children: [
          CircularProgressIndicator(
            color: Color(0xffffffffff),
          ),
          Container(
            color: Color(0xff1c1c1e),
            margin: EdgeInsets.only(left: 7),
            child: Text(
              'Loading...',
              style: TextStyle(color: Color(0xffffffff)),
            ),
          )
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
