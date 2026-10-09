import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'pages/sign_up_page.dart';
import 'pages/main_page.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCk-JpKWSbiixbIKUkUuQIW5boXdqynpo4",
        appId: "1:6735545479:android:280ab5aa3603d0468aa422",
        messagingSenderId: "6735545479",
        projectId: "safelygo-backend",
      ),
    );
  } catch (e) {
    print("e");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //dark
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          primary: Color(0xFF6750A4),
          secondary: Color(0x00000000),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F7FA),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),

        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void gurl() {
    print("This is a test button");
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> signin(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      auth.authStateChanges().listen((user) {
        if (user != null) {
          Navigator.push(
            context,

            MaterialPageRoute<void>(builder: (context) => MapScreen()),
          );
        }
      });
    } on FirebaseAuthException catch (e) {
      (() {
        showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Column(
              mainAxisAlignment: .center,
              children: <Widget>[
                Text("$e"),
                SizedBox(height: 4),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.

    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar

        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("SafelyGo"),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.directional(
          bottom: 20,
          top: 10,
          start: 30,
          end: 30,
        ),
        child: Card(
          child: Column(
            children: [
              SizedBox(height: 64),
              Text(
                "Login to your SafelyGo Account",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight(400)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 64),
              TextField(
                decoration: InputDecoration(
                  hint: Text("Email"),
                  label: Text("Email"),
                  border: OutlineInputBorder(),
                ),
                controller: email,
              ),
              SizedBox(height: 64),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hint: Text("Password"),
                  label: Text("Password"),

                  border: OutlineInputBorder(),
                ),
                controller: password,
              ),
              SizedBox(height: 64),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute<void>(
                            builder: (context) => SignUp(),
                          ),
                        );
                      },
                      style: ButtonStyle(visualDensity: VisualDensity.compact),
                      child: Text("Sign Up"),
                    ),
                    FilledButton(
                      onPressed: () {
                        signin(email.text, password.text);
                      },
                      style: ButtonStyle(visualDensity: VisualDensity.compact),
                      child: Text("Login"),
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
//FABOOBOO!!!!!!
