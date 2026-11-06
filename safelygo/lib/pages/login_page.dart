import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safely_go/main.dart';
import 'package:safely_go/pages/main_page.dart';
import 'package:safely_go/pages/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<void> signin(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
        context,

        MaterialPageRoute<void>(builder: (context) => AuthGateway()),
      );
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 64),
              Text(
                "Login to your SafelyGo Account",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight(400)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 64),
              AutofillGroup(
                child: TextFormField(
                  decoration: InputDecoration(
                    hint: Text("Email"),
                    label: Text("Email"),
                    border: OutlineInputBorder(),
                  ),
                  controller: email,
                ),
              ),
              SizedBox(height: 64),
              AutofillGroup(
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hint: Text("Password"),
                    label: Text("Password"),

                    border: OutlineInputBorder(),
                  ),
                  controller: password,
                ),
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
                            builder: (context) => (SignUp()),
                          ),
                        );
                      },
                      style: ButtonStyle(visualDensity: VisualDensity.compact),
                      child: Text("Sign Up"),
                    ),

                    FilledButton(
                      onPressed: () {
                        TextInput.finishAutofillContext();
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
