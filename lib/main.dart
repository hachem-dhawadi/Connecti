import 'package:flutter/material.dart';
import 'package:login_page/auth/google_sign_in.dart';
import 'package:login_page/auth/login.dart';
import 'package:login_page/auth/signup.dart';
import 'package:login_page/crud/addnotes.dart';
import 'package:login_page/home/accueiladmin.dart';
import 'package:login_page/home/chat.dart';
import 'package:login_page/home/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_page/home/accueil.dart';
import 'package:login_page/crud/details.dart';
import 'package:login_page/auth/forgetpass.dart';
import 'package:login_page/home/listusers.dart';
import 'package:login_page/home/news.dart';
import 'package:login_page/home/newsadmin.dart';
import 'package:login_page/home/profil.dart';
import 'package:login_page/home/todo.dart';
import 'package:login_page/home/todo/postes.dart';
import 'package:login_page/intro/selfpage.dart';
import 'package:login_page/model/post_add_edit.dart';
import 'package:login_page/model/post_item.dart';
import 'package:login_page/newstab/adminEvent.dart';
import 'package:login_page/newstab/adminFile.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //int hive
 //Hive.initFlutter();
  //open box
  //var box = await Hive.openBox("mybox");

  /*await Firebase.initializeApp(
        // Replace with actual values
        options: const FirebaseOptions(
          apiKey: "AIzaSyBzH7d8F0twppcwBlkz9mCba2xMVjxdkGY",
          appId: "1:1087221200178:android:099ee75ad5c9e59f42d32b",
          messagingSenderId: "XXX",
          projectId: "crudfirestore-5f32a",
        ),
      );*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: OverlaySupport.global(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Login(),
            theme: ThemeData(
                primaryColor: Colors.blue,
                buttonColor: Colors.blue,
                textTheme: TextTheme(
                    headline6: TextStyle(fontSize: 20, color: Colors.white))),
            routes: {
              "login": (context) => Login(),
              "signup": (context) => SignUp(),
              "addnotes": (context) => AddNotes(),
              "details": (context) => Details(),
              "forgetpass": (context) => Forgetpass(),
              "accueil": (context) => Accueil(),
              "accueiladmin": (context) => AccueilAdmin(),
              "listusers": (context) => ListUsers(),
              "homepage": (context) => HomePage(),
              "selfpage": (context) => SelfPage(),
              "todo": (context) => ToDo(),
              "news": (context) => News(),
              "chat": (context) => Chat(),
              "profil": (context) => Profil(),
              "postes": (context) => Postes(),
              "newsadmin": (context) => NewsAdmin(),
              "postitem": (context) => PostItem(),
              "postaddedit":(context) => PostAddEdit(),
              "adminfile":(context) => AdminFile(),
              "adminevent":(context) => AdminEvent(),
              
            },
          ),
        ),
      );
}
