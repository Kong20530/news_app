import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/user_model.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _formKey = GlobalKey<FormState>();

  final usernameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final passwordConfirmEditingController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final usernameField = TextFormField(
      autofocus: false,
      controller: usernameEditingController,
      keyboardType: TextInputType.name,

      validator: (value) {
        if (value!.isEmpty){
          return ("ユーザー名を記入してください");
        }

        return null;
      },

      onSaved: (value)
      {
        usernameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
          hintText: "ユーザー名",
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )
      ),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
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
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
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
      controller: passwordEditingController,
      obscureText: true,

      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');

        if (value!.isEmpty){
          return ("パスワードを記入してください");
        }

        if (!regex.hasMatch(value)){
          return ("有効なパスワードを記入してください");
        }

        return null;
      },

      onSaved: (value)
      {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
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

    final passwordConfirmField = TextFormField(
      autofocus: false,
      controller: passwordConfirmEditingController,
      obscureText: true,

      validator: (value) {
        if (passwordConfirmEditingController.text != passwordEditingController.text){
          return "パスワードが間違っています";
        }
        return null;
      },

      onSaved: (value)
      {
        passwordConfirmEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.password),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
          hintText: "パスワード（確認）",
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )
      ),
    );

    final registerButton = Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.lightBlue[900],
      child: MaterialButton(
        padding: const EdgeInsets.all(10.0),
        minWidth: MediaQuery.of(context).size.width,


        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: const Text("登録",
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            color: Colors.lightBlue[900],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
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

                    Text("新規登録",
                      style: TextStyle(
                        fontSize:   36,
                        color: Colors.lightBlue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 45),

                    usernameField,
                    const SizedBox(height: 15),

                    emailField,
                    const SizedBox(height: 15),

                    passwordField,
                    const SizedBox(height: 15),

                    passwordConfirmField,
                    const SizedBox(height: 25),

                    registerButton,
                    const SizedBox(height: 7,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToFirebase() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.username = usernameEditingController.text;

    await firebaseFirestore.collection("users").doc(user.uid).set(userModel.toMap());

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) =>
                LoginScreen()),
            (route) => false);
  }

  void signUp(String email, String password) async{
    if (_formKey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => {
        postDetailsToFirebase()
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}