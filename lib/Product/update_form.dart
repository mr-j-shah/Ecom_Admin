import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomadmin/Product/editproduct.dart';
import 'package:ecomadmin/Splashscreen/body.dart/splashbody.dart';
import 'package:ecomadmin/home/home.dart';
import 'package:ecomadmin/user.dart';
import 'package:flutter/material.dart';

class updateform extends StatefulWidget {
  updateform({Key? key, required this.pro, required this.vale})
      : super(key: key);
  product pro;
  String vale;
  @override
  State<updateform> createState() => _addprupdateform();
}

class _addprupdateform extends State<updateform> {
  GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
  AutovalidateMode _autovalid = AutovalidateMode.always;
  bool isComplete = false;
  String _nameproduct = "null";
  String _description = "null";
  int _quantity = 0;
  int _price = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Product'),
          backgroundColor: Color(0xFFFF7643),
        ),
        body: Container(
          child: Form(
            key: _formkey,
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    enabled: false,
                    initialValue: widget.pro.name.toString(),
                    decoration: InputDecoration(
                      labelText: "Name of Product",
                      hintText: 'Enter Name of the Product',
                      labelStyle: TextStyle(color: Color(0xFFFF7643)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFFF7643)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFFF7643)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                    onChanged: (val) {
                      print(val);
                      setState(() {
                        _nameproduct = val.toString();
                      });
                    },
                    validator: (ValueKey) {
                      if (ValueKey == '') {
                        return 'Enter Name of the Field';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    initialValue: widget.pro.description,
                    maxLines: 5,
                    maxLength: 1000,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: "Discription of  Product",
                      hintText: 'Enter Details of the Product',
                      labelStyle: TextStyle(color: Color(0xFFFF7643)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFFF7643)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFFF7643)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                    onChanged: (val) {
                      print(val);
                      setState(() {
                        _description = val.toString();
                      });
                    },
                    validator: (ValueKey) {
                      if (ValueKey == '') {
                        return 'Enter Name of the Field';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    initialValue: widget.pro.price.toString(),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Price of Product",
                      hintText: 'Enter the Selling Price of the Product',
                      labelStyle: TextStyle(color: Color(0xFFFF7643)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFFF7643)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFFF7643)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                    onChanged: (val) {
                      print(val);
                      if (val != '' && val != null) {
                        setState(() {
                          _price = int.parse(val);
                        });
                      } else {
                        _price = 0;
                      }
                    },
                    validator: (ValueKey) {
                      if (ValueKey == '0' || ValueKey == '') {
                        return 'Enter Name of the Field';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    initialValue: widget.pro.quantity.toString(),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Quantity of the Product",
                      hintText: 'Enter Quantity of the Product in the Buffer',
                      labelStyle: TextStyle(color: Color(0xFFFF7643)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFFF7643)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFFF7643)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                    onChanged: (val) {
                      print(val);
                      if (val != '' && val != null) {
                        setState(() {
                          _quantity = int.parse(val);
                        });
                      } else {
                        _quantity = 0;
                      }
                    },
                    validator: (ValueKey) {
                      if (ValueKey == '0' || ValueKey == '') {
                        return 'Enter Name of the Field';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: DefaultButton(
                    text: 'Update',
                    press: () async {
                      if (_formkey.currentState!.validate()) {
                        await submit();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => home(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submit() async {
    return FirebaseFirestore.instance
        .collection('Data')
        .doc(widget.vale)
        .collection('Products')
        .doc(widget.pro.name)
        .update({
          'Description': _description,
          'Quantity': _quantity,
          'Price': _price
        })
        .then((value) => print("Item Added"))
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }
}
