import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/login/register_screen.dart';

import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController =  TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,

      validator: (value) {
        if (value!.isEmpty){
          return ("メールアドレスを記入してください");
        }

        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
          return ("有効なメールアドレスを記入してください");
        }

        return null;
      },

      onSaved: (value)
      {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
          hintText: "メールアドレス",
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,

      validator: (value) {
        if (value!.isEmpty){
          return ("パスワードを記入してください");
        }
        return null;
      },

      onSaved: (value){
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.password),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
          hintText: "パスワード",
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )
      ),
    );

    final loginButton = Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.lightBlue[900],
      child: MaterialButton(
        padding: const EdgeInsets.all(10.0),
        minWidth: MediaQuery.of(context).size.width,

        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: const Text("ログイン",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final registerButton = Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.lightBlue[900],
      child: MaterialButton(
        padding: const EdgeInsets.all(10.0),
        minWidth: MediaQuery.of(context).size.width,


        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context)=>
              const RegistrationScreen(),
            ),
          );
        },
        child: const Text("新規登録",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Text("ワールド・ニュース",
                      style: TextStyle(
                        fontSize:   30,
                        color: Colors.lightBlue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        "images/logo_login.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 25),

                    emailField,
                    const SizedBox(height: 15),

                    passwordField,
                    const SizedBox(height: 25),

                    loginButton,
                    const SizedBox(height: 7),

                    Text("または",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    const SizedBox(height: 7),

                    registerButton
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async{
    if (_formKey.currentState!.validate()){
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((uid) => {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context)=>
            HomeScreen(),
          ),
        ),
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}