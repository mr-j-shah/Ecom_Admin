// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../user.dart';

class userdata extends StatefulWidget {
  const userdata({Key? key}) : super(key: key);

  @override
  State<userdata> createState() => _userdataState();
}

class _userdataState extends State<userdata> {
  List<User> l = [];
  bool isComplete = false;
  @override
  void initState() {
    getUser().then((value) {
      setState(() {
        l = value;
        isComplete = true;
      });
    }).onError((error, stackTrace) {
      print(error);
      throw error!;
    });
    print("Complete");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Data'),
          backgroundColor: const Color(0xFFFF7643),
        ),
        body: isComplete
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: l.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          // height: MediaQuery.of(context).size.height * 0.07,
                          width: double.infinity,

                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            color:
                                index % 2 == 0 ? Colors.white : Colors.white54,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l[index].name.toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    l[index].address.toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    l[index].num.toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    l[index].email.toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(),
                  )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(color: Color(0xFFFF7643)),
              ),
      ),
    );
  }

  Future<List<User>> getUser() async {
    List<User> u = [];
    final snapShot = await FirebaseFirestore.instance.collection('user').get();
    for (final doc in snapShot.docs) {
      u.add(User.fromDocument(doc));
    }
    return u;
  }
}
