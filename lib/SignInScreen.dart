import 'package:bloc_demo/auth_service.dart';
import 'package:bloc_demo/dashboard.dart';
import 'package:bloc_demo/signUpScreen.dart';
import 'package:bloc_demo/themeModeBloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailController.text, password: passwordController.text)
          .whenComplete(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      });
    } on FirebaseAuthException catch (e) {
      print("eeeeeeeeeeeeeeeeee");
      print(e);
      Navigator.pop(context);
      // showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepOrange,
            title: Center(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final themeModeBloc = BlocProvider.of<ThemeModeBloc>(context);

    return BlocBuilder<ThemeModeBloc, bool>(
      builder: (context, isDarkMode) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(left: 250),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            isDarkMode ? 'Dark Mode' : 'Light Mode',
                            style: TextStyle(fontSize: 15, color: isDarkMode ? Colors.white : Colors.black),
                          ),
                          SizedBox(height: 10),
                          Switch(
                            value: isDarkMode,
                            onChanged: (_) {
                              themeModeBloc.add(ThemeModeEvent.toggle);
                            },
                            activeColor: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 70),
                    TextField(
                      controller: emailController,
                      obscureText: false,
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Enter Email',
                        labelStyle: TextStyle(
                          color: Colors.grey, // Custom label color
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // password textfield
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Enter Password',
                        labelStyle: TextStyle(
                          color: Colors.grey, // Custom label color
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // forgot password?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // sign in button
                    ElevatedButton(
                      onPressed: () async {
                        // try {
                        //   await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                        // } on FirebaseAuthException catch (e) {
                        //   Navigator.pop(context);
                        //   showErrorMessage(e.code);
                        // }
                        await signUserIn();
                        print("signed in");
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => DashboardScreen()),
                        // );
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: isDarkMode ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: isDarkMode
                            ? MaterialStateProperty.all<Color>(Colors.white)
                            : MaterialStateProperty.all<Color>(Colors.black),
                      ), // Set your custom color here
                    ),

                    const SizedBox(height: 50),

                    // or continue with
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              AuthService().signInWithGoogle();
                            },
                            child: Icon(Icons.g_mobiledata_rounded, size: 100, color: isDarkMode ? Colors.white : Colors.black),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Not a member?',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(width: 4),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: isDarkMode
                                      ? MaterialStateProperty.all<Color>(Colors.white)
                                      : MaterialStateProperty.all<Color>(Colors.black),
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: isDarkMode ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
        );
      },
    );
  }
}
