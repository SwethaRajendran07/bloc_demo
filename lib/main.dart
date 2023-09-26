import 'package:bloc_demo/auth_service.dart';
import 'package:bloc_demo/themeModeBloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dark/Light Mode Demo',
      home: BlocProvider(
        create: (context) => ThemeModeBloc(),
        child: AuthService().handleAuthState(),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final themeModeBloc = BlocProvider.of<ThemeModeBloc>(context);
//
//     return BlocBuilder<ThemeModeBloc, bool>(
//       builder: (context, isDarkMode) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Text('Dark/Light Mode Demo'),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.only(top: 20.0, left: 250.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   isDarkMode ? 'Dark Mode' : 'Light Mode',
//                   style: TextStyle(fontSize: 24),
//                 ),
//                 SizedBox(height: 10),
//                 Switch(
//                   value: isDarkMode,
//                   onChanged: (_) {
//                     themeModeBloc.add(ThemeModeEvent.toggle);
//                   },
//                 ),
//               ],
//             ),
//           ),
//           backgroundColor: isDarkMode ? Colors.black : Colors.white,
//         );
//       },
//     );
//   }
// }
