// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomadmin/order/orederui.dart';
import 'package:ecomadmin/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class orderList extends StatefulWidget {
  orderList({Key? key}) : super(key: key);

  @override
  State<orderList> createState() => _orderListState();
}

class _orderListState extends State<orderList> {
  // DateTime? now = DateTime.now();
  bool isComplete = false;
  String dateInput = DateFormat('dd-MM-yyyy').format(DateTime.now());
  List<Order> orderList = [];
  @override
  void initState() {
    print(dateInput);
    getOrder().then((value) {
      setState(() {
        orderList = value;
        isComplete = true;
      });
    }).onError((error, stackTrace) {
      print(error);
      throw error!;
    });
    super.initState();
    // getdate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order List'),
          backgroundColor: const Color(0xFFFF7643),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                  onTap: () async {
                    await getdate();
                  },
                  child: const Icon(Icons.calendar_today)),
            )
          ],
        ),
        body: isComplete
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(child: Text(dateInput)),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: orderList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: double.infinity,
                          color: index % 2 == 0 ? Colors.white : Colors.white54,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      orderui(o: orderList[index]),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          orderList[index].name.toString(),
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06,
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
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
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
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
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
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
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
                                              orderList[index]
                                                  .cart
                                                  .length
                                                  .toString(),
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 8),
                                        child: Text(
                                          "Order Date : " +
                                              orderList[index].date.toString(),
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
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFF7643),
                ),
              ),
      ),
    );
  }

  Future<List<Order>> getOrder() async {
    List<Order> u = [];
    final snapShot = await FirebaseFirestore.instance
        .collection('order')
        .where('isAccept', isEqualTo: true)
        .where('date', isEqualTo: dateInput.toString())
        .get();
    for (final doc in snapShot.docs) {
      u.add(Order.fromDoc(doc));
    }
    return u;
  }

  Future<void> getdate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      print(formattedDate);
      setState(() {
        dateInput = formattedDate.toString();
        getOrder().then((value) {
          setState(() {
            orderList = value;
          });
        }).onError((error, stackTrace) {
          print(error);
          throw error!;
        }); //set output date to TextField value.
      });
    } else {}
  }
}
