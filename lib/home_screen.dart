import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.phoneNumber}) : super(key: key);
  String? phoneNumber;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // getIpAddress();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
    );
  }
}
