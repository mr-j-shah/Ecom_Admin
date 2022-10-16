import 'package:ecomadmin/user.dart';
import 'package:flutter/material.dart';

class orderui extends StatefulWidget {
  orderui({Key? key, required this.o}) : super(key: key);
  Order o;
  @override
  State<orderui> createState() => _orderuiState();
}

// ignore: camel_case_types
class _orderuiState extends State<orderui> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.o.name.toString()),
          backgroundColor: const Color(0xFFFF7643),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.o.cart.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> cartList =
                        widget.o.cart[index] as Map<String, dynamic>;
                    return Row(
                      children: [
                        SizedBox(
                          width: 88,
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F6F9),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child:
                                  Image.network(cartList['Image'].toString()),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartList['Name'],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              maxLines: 2,
                            ),
                            const SizedBox(height: 10),
                            Text.rich(
                              TextSpan(
                                text: "INR ${cartList['Price']}",
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFFF7643)),
                                children: [
                                  TextSpan(
                                      text: " x ${cartList['Quantity']}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
