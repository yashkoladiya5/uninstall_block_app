import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telecalling/connect_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTextField(label: "Enter Name", controller: nameController),
          _buildTextField(label: "Enter Email", controller: emailController),
          _buildTextField(
              label: "Enter Phone Number", controller: phoneController),
          _buildTextField(
              label: "Enter Password", controller: passwordController),
          SizedBox(
            height: 50,
          ),
          _buildSignUpButton()
        ],
      ),
    ));
  }

  Widget _buildTextField(
      {TextEditingController? controller,
      String? label,
      String? Function(String?)? validator}) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
        validator: validator);
  }

  Widget _buildSignUpButton() {
    return MaterialButton(
      onPressed: () async {
        await _register();
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => HomePage()));
      },
      color: Colors.lightGreen,
      child: Text("Sing Up"),
    );
  }

  Future<void> _register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
        .user;
    await storeDataInFirebase();
    if (user != null) {
      var _userEmail = user.email;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CheckConnection(
                phoneNumber: phoneController.text,
              )));
      print("user added");
      setState(() {});
    } else {
      setState(() {});
    }
  }

  Future<void> storeDataInFirebase() async {
    final fireStore = await FirebaseFirestore.instance.collection("users");

    fireStore
        .add({
          "name": nameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
        })
        .then((value) => print("data added in firebase"))
        .onError((error, stackTrace) => print(error));
  }
}
