import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'pages/signUp.dart';
import 'pages/mainHub.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> initializeDefault() async {
  FirebaseApp app = await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCk-JpKWSbiixbIKUkUuQIW5boXdqynpo4",
      appId: "1:6735545479:android:280ab5aa3603d0468aa422",
      messagingSenderId: "6735545479",
      projectId: "safelygo-backend",
    ),
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDefault();
  const MyApp();
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
      home: const MyHomePage(title: 'Login Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;

  void gurl() {
    print("This is a test button");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    final FirebaseAuth auth = FirebaseAuth.instance;
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();

    void _signin(String email, String password) async {
      try {
        auth.signInWithEmailAndPassword(email: email, password: password);
        MaterialPageRoute<void>(builder: (context) => MapScreen());
        Navigator.push(
          context,

          MaterialPageRoute<void>(builder: (context) => signUp()),
        );
      } catch (e) {
        print(e);
      }
    }

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
        title: Text(widget.title),
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
                            builder: (context) => signUp(),
                          ),
                        );
                      },
                      style: ButtonStyle(visualDensity: VisualDensity.compact),
                      child: Text("Sign Up"),
                    ),
                    FilledButton(
                      onPressed: () {
                        _signin(email.text, password.text);
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
