import 'package:bloc_demo/SignInScreen.dart';
import 'package:bloc_demo/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return DashboardScreen();
          } else {
            return SignInScreen();
          }
        });
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //Sign out
  signOut(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut().whenComplete(() {
      Navigator.pop(context);
    });
  }

// void toggleTheme() {
//   final themeModeBloc = BlocProvider.of<ThemeModeBloc>(context);
//   themeModeBloc.add(ThemeModeEvent.toggle);
// }
}
