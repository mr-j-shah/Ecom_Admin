// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomadmin/Product/addproduct.dart';
import 'package:ecomadmin/Product/listproduct.dart';
import 'package:ecomadmin/Splashscreen/splashscreen.dart';
import 'package:ecomadmin/home/requestprofile.dart';
import 'package:ecomadmin/home/user.dart';
import 'package:ecomadmin/order/acceptlist.dart';
import 'package:ecomadmin/order/orderlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../user.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<Requestuser> l = [];
  bool isLoading = true;
  bool isError = false;
  @override
  void initState() {
    getUser().then((value) {
      setState(() {
        l = value;
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      setState(() {
        isError = true;
      });
      throw error!;
    });
    super.initState();
  }

  Future<List<Requestuser>> getUser() async {
    List<Requestuser> users = [];
    final snapShot =
        await FirebaseFirestore.instance.collection('requestUser').get();
    for (final doc in snapShot.docs) {
      users.add(Requestuser.fromDocument(doc));
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFF7643),
              ),
              // ignore: unnecessary_const
              child: const Center(
                child: Text('Budget Bazar'),
              ),
            ),
            ListTile(
              title: const Text(
                'Add Product',
                style: const TextStyle(fontSize: 18),
              ),
              leading: const Icon(Icons.add_box),
              subtitle: const Text('You can add a Product from this'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => addproduct()),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Edit Product',
                style: TextStyle(fontSize: 18),
              ),
              leading: const Icon(Icons.edit_rounded),
              subtitle:
                  const Text('You an Edit the Detail of the Product from this'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => listproduct(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Request Order',
                style: TextStyle(fontSize: 18),
              ),
              leading: const Icon(Icons.business_center),
              subtitle:
                  const Text('You an see the Details of the Request Order'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => acceptList(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Accepted Order',
                style: TextStyle(fontSize: 18),
              ),
              leading: const Icon(Icons.business_center),
              subtitle: const Text('You an see the Details of the Order'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => orderList(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Log Out',
                style: TextStyle(fontSize: 18),
              ),
              leading: const Icon(Icons.logout),
              onTap: () {
                setState(() {
                  isLoading = true;
                });
                signout();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Admin'),
        backgroundColor: const Color(0xFFFF7643),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                setState(() {
                  isLoading = false;
                  getUser().then((value) {
                    setState(() {
                      l = value;
                      isLoading = false;
                    });
                  }).onError((error, stackTrace) {
                    print(error);
                    print(stackTrace);
                    setState(() {
                      isError = true;
                    });
                    throw error!;
                  });
                });
              },
              icon: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      body: isLoading
          // ignore: prefer_const_constructors
          ? Center(
              child: const CircularProgressIndicator(
                color: Color(0xFFFF7643),
              ),
            )
          : Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => userdata(),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            'User Data',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: l.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: double.infinity,
                        color: index % 2 == 0 ? Colors.white : Colors.white54,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                requestuserprofile(r: l[index]),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        l[index].name.toString(),
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        isLoading = true;
                                        await Requestuser().accept(l[index]);
                                        setState(() {
                                          print('Accept');
                                          isLoading = false;
                                          getUser().then((value) {
                                            setState(() {
                                              l = value;
                                              isLoading = false;
                                            });
                                          }).onError((error, stackTrace) {
                                            print(error);
                                            print(stackTrace);
                                            setState(() {
                                              isError = true;
                                            });
                                            throw error!;
                                          });
                                        });
                                      },
                                      icon: Image.asset(
                                          'assets/icons/accept.png'),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        isLoading = true;
                                        await Requestuser().Decline(l[index]);
                                        setState(() {
                                          isLoading = false;
                                          getUser().then((value) {
                                            setState(() {
                                              l = value;
                                              isLoading = false;
                                            });
                                          }).onError((error, stackTrace) {
                                            print(error);
                                            print(stackTrace);
                                            setState(() {
                                              isError = true;
                                            });
                                            throw error!;
                                          });
                                        });
                                      },
                                      icon: Image.asset(
                                          'assets/icons/cancel.png'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  signout() async {
    GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const splashscreen(),
      ),
    );
  }
}
