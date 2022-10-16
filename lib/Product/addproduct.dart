import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomadmin/Splashscreen/body.dart/splashbody.dart';
import 'package:ecomadmin/home/home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

import '../Firestore.dart';

class addproduct extends StatefulWidget {
  addproduct({Key? key}) : super(key: key);

  @override
  State<addproduct> createState() => _addproductState();
}

class _addproductState extends State<addproduct> {
  GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
  AutovalidateMode _autovalid = AutovalidateMode.always;
  bool isComplete = false;
  String _category = "Select";
  String _nameproduct = "null";
  String _description = "null";
  String downloadlink = "";
  int _quantity = 0;
  int _price = 0;
  UploadTask? task;
  File? file;
  final List<String> _categorylist = [
    "Select",
    'Beauty',
    'Home Product',
    'Toys',
    'Gifts',
    'Mobile Accessories',
    'Fashion',
  ];
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
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
                  padding: const EdgeInsets.all(15),
                  child: DropdownButtonFormField(
                    dropdownColor: Colors.green[50],
                    decoration: InputDecoration(
                      labelText: "Categeries",
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
                    validator: (ValueKey) {
                      if (ValueKey == "Select") {
                        isComplete = false;
                        return 'Plese Select Caterory';
                      }
                      return null;
                    },
                    hint: const Text("Select height"),
                    value: _category,
                    elevation: 1,
                    isExpanded: true,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                    onChanged: (val) {
                      print(val);
                      setState(() {
                        _category = val.toString();
                      });
                    },
                    items: _categorylist.map((fname) {
                      return DropdownMenuItem(
                        child: new Text(fname),
                        value: fname,
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Price of Product",
                      hintText: 'Price of the Product',
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Quantity of the Product",
                      hintText:
                          'Enter Quantity of the Product Which is Avilible in Buffer',
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  // ignore: prefer_const_constructors
                  child: Text(
                    '*You Have to upload \n\t1. Upload Udyog Adhaar 2. Upload ShopAct',
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: InkWell(
                    onTap: () {
                      selectFile();
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Card(
                        color: Colors.white70,
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            // ignore: prefer_const_constructors
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Icon(Icons.attach_file),
                            ),
                            const VerticalDivider(
                              thickness: 2,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: const Text('Upload Files'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(
                    fileName,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    await uploadFile();
                  },
                  child: Text('Upload'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: DefaultButton(
                    text: 'Submit',
                    press: () async {
                      if (_formkey.currentState!.validate()) {
                        await submit();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => home()),
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        primary: Colors.white,
                        backgroundColor: const Color(0xFFFF7643),
                      ),
                      onPressed: () {
                        _formkey.currentState!.reset();
                      },
                      child: Text(
                        'Reset',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
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
        .doc(_category)
        .collection('Products')
        .doc(_nameproduct)
        .set({
          'Name': _nameproduct,
          'Description': _description,
          'Quantity': _quantity,
          'Price': _price,
          'Image': downloadlink
        })
        .then((value) => print("Item Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/products/$_category/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    downloadlink = urlDownload.toString();
    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
