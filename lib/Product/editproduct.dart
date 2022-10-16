import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomadmin/Product/update_form.dart';
import 'package:ecomadmin/user.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class editlist extends StatefulWidget {
  editlist({Key? key, required this.value}) : super(key: key);
  String value;
  @override
  State<editlist> createState() => _editlistState();
}

class _editlistState extends State<editlist> {
  List<product> list = [];
  List<product> searchresult = [];
  bool isLoading = true;
  bool isError = false;
  String search = '';
  @override
  void initState() {
    getdata().then((value) {
      setState(() {
        list = value;
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

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController(text: "");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.value.toString()),
        backgroundColor: const Color(0xFFFF7643),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFFF7643)),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: const Color(0xFF979797).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      // showCursor: false,

                      onChanged: ((value) {
                        setState(() {
                          print(value);
                          print(searchresult.length);
                          search = value;
                          searchOperation(search);
                        });
                      }),
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: "Search product",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                searchresult.isEmpty || search.isEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Card(
                              color: Colors.white70,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => updateform(
                                        vale: widget.value,
                                        pro: list[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        list[index].name.toString(),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        list[index].quantity.toString(),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchresult.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Card(
                              color: Colors.white70,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => updateform(
                                        vale: widget.value,
                                        pro: searchresult[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        searchresult[index].name.toString(),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        searchresult[index].quantity.toString(),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
    );
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (searchText != null) {
      for (var i = 0; i < list.length; i++) {
        product data = list[i];
        if (data.name!.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }

  Future<List<product>> getdata() async {
    List<product> pro = [];
    final snapshot = await FirebaseFirestore.instance
        .collection("Data")
        .doc(widget.value.toString())
        .collection('Products')
        .get();
    for (final doc in snapshot.docs) {
      pro.add(product.fromDocument(doc));
    }
    return pro;
  }
}
