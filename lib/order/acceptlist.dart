// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomadmin/Splashscreen/body.dart/splashbody.dart';
import 'package:ecomadmin/order/orederui.dart';
import 'package:ecomadmin/user.dart';
import 'package:flutter/material.dart';

class acceptList extends StatefulWidget {
  acceptList({Key? key}) : super(key: key);

  @override
  State<acceptList> createState() => _acceptListState();
}

class _acceptListState extends State<acceptList> {
  List<Order> orderList = [];
  List<String> notStock = [];
  List<int> updateStockList = [];
  bool isAccptOrder = true;
  @override
  void initState() {
    getOrder().then((value) {
      setState(() {
        orderList = value;
      });
    }).onError((error, stackTrace) {
      print(error);
      throw error!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order List'),
          backgroundColor: Color(0xFFFF7643),
        ),
        body: ListView.builder(
          itemCount: orderList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              color: index % 2 == 0 ? Colors.white : Colors.white54,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => orderui(o: orderList[index]),
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              orderList[index].name.toString(),
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.06,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            child: Text(
                              orderList[index].address.toString(),
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            child: Text(
                              orderList[index].phone.toString(),
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            child: Text(
                              orderList[index].email.toString(),
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            child: Text(
                              "Number of Product in Order : " +
                                  orderList[index].cart.length.toString(),
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            child: Text(
                              "Order Date : " +
                                  orderList[index].date.toString(),
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          DefaultButton(
                            text: 'Accept',
                            press: () {
                              accept(orderList[index]);
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          DefaultButton(
                            text: 'Decline',
                            press: () {},
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<List<Order>> getOrder() async {
    List<Order> u = [];
    final snapShot = await FirebaseFirestore.instance
        .collection('order')
        .where('isAccept', isEqualTo: false)
        .get();
    for (final doc in snapShot.docs) {
      u.add(Order.fromDoc(doc));
    }
    return u;
  }

  Future<void> accept(Order o) async {
    await checkStock(o.cart);
    isAccptOrder
        ? await acceptChnage(o)
        : await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Alert'),
              content: const Text('Items are not in Stock'),
              actions: [
                OutlinedButton(
                  child: const Text('Ok'),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
    ;
    getOrder().then((value) {
      setState(() {
        orderList = value;
      });
    }).onError((error, stackTrace) {
      print(error);
      throw error!;
    });
  }

  Future<void> acceptChnage(Order o) async {
    await FirebaseFirestore.instance
        .collection('order')
        .doc(o.email.toString() + o.date.toString())
        .update({'isAccept': true});
    await FirebaseFirestore.instance
        .collection('user')
        .doc(o.email)
        .collection('order')
        .doc(o.time)
        .update({'isAccepted': true});
    await updateStock(o.cart);
  }

  Future<void> updateStock(List o) async {
    for (var item in o) {
      int? change;
      Map<String, dynamic> data = item as Map<String, dynamic>;
      String category = data['category'];
      print(category);
      String product = data['Name'];
      print(product);
      await FirebaseFirestore.instance
          .collection('Data')
          .doc(category)
          .collection("Products")
          .doc(product)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          var dataOfItem = documentSnapshot.data() as Map<String, dynamic>;
          int stocki = dataOfItem['Quantity'];
          print(stocki);
          int stockj = data['Quantity'];
          change = stocki - stockj;
          print(change);
        } else {}
      });
      await FirebaseFirestore.instance
          .collection('Data')
          .doc(category)
          .collection("Products")
          .doc(product)
          .update({'Quantity': change});
    }
  }

  Future<void> checkStock(List o) async {
    notStock.clear();
    for (var item in o) {
      Map<String, dynamic> data = item as Map<String, dynamic>;
      String category = data['category'];
      print(category);
      String product = data['Name'];
      print(product);
      await FirebaseFirestore.instance
          .collection('Data')
          .doc(category)
          .collection("Products")
          .doc(product)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          var dataOfItem = documentSnapshot.data() as Map<String, dynamic>;
          int stocki = dataOfItem['Quantity'];
          print(stocki);
          int change = stocki - data['Quantity'] as int;
          print(change);
          if (change < 0) {
            isAccptOrder = false;
            notStock.add(dataOfItem['Name']);
            print(notStock);
          }
        } else {}
      });
    }
  }

  Future<void> delete(Order o) async {
    await FirebaseFirestore.instance
        .collection('order')
        .doc(o.email.toString() + o.date.toString())
        .delete();
    await FirebaseFirestore.instance
        .collection('user')
        .doc()
        .collection('order')
        .doc(o.time)
        .delete();
    getOrder().then((value) {
      setState(() {
        orderList = value;
      });
    }).onError((error, stackTrace) {
      print(error);
      throw error!;
    });
  }
}
