import 'dart:async';
import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:telecalling/model/user_model.dart';

class CheckConnection extends StatefulWidget {
  CheckConnection({Key? key, required this.phoneNumber}) : super(key: key);

  String? phoneNumber;

  @override
  State<CheckConnection> createState() => _CheckConnectionState();
}

class _CheckConnectionState extends State<CheckConnection> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  List<UserModel> _searchResults = [];
  bool permissionDenied = false;
  List<Contact> contactsNumber = [];
  @override
  void initState() {
    super.initState();

    initConnectivity();
    _fetchContacts();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
    await storeDataInFirebase();

    print('Connectivity changed: $_connectionStatus');
  }

  search({String? number}) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('contacts')
        .where('phoneNumber', isEqualTo: number)
        .get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      _searchResults = [];
      UserModel userModel = UserModel();
      userModel = UserModel.fromJson(querySnapshot.docs[i].data());
      _searchResults.add(userModel);
      print(_searchResults.map((e) => e.toJson()));
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Connectivity Plus Example'),
          elevation: 4,
          actions: [
            IconButton(
                onPressed: () async {
                  await _fetchContacts();
                  for (int i = 0; i < contactsNumber.length; i++) {
                    for (var number in contactsNumber) {
                      String? phoneNumber;
                      if (number.phones.first.normalizedNumber.isEmpty) {
                        phoneNumber = number.phones.first.number;
                      } else {
                        phoneNumber = number.phones.first.normalizedNumber;
                      }

                      String extractedNumber = phoneNumber.substring(3);
                      print(extractedNumber);
                      await search(number: extractedNumber);
                    }
                  }
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return Card(
                child: Text(_searchResults[index].phone ?? ""),
              );
            }));
  }

  Future<void> storeDataInFirebase() async {
    final fireStore = await FirebaseFirestore.instance.collection("contacts");

    fireStore
        .add({
          "phoneNumber": widget.phoneNumber,
          "status": _connectionStatus.name,
        })
        .then((value) => print("data added in firebase"))
        .onError((error, stackTrace) => print(error));
  }

  Future _fetchContacts() async {
    contactsNumber = [];
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts(withProperties: true);

      setState(() => contactsNumber = contacts);
    }
  }
}
