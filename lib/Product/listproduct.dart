import 'package:ecomadmin/Product/editproduct.dart';
import 'package:flutter/material.dart';

class listproduct extends StatefulWidget {
  listproduct({Key? key}) : super(key: key);

  @override
  State<listproduct> createState() => _listproductState();
}

class _listproductState extends State<listproduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Product'),
        backgroundColor: Color(0xFFFF7643),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(5),
              minVerticalPadding: 10,
              title: Text(
                'Home Product',
                style: TextStyle(fontSize: 18),
              ),
              leading: Icon(Icons.home),
              // subtitle: Text('You an Edit the Detail of the Product from this'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => editlist(value: 'Home Product'),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.all(2),
              minVerticalPadding: 10,
              title: Text(
                'Beauty',
                style: TextStyle(fontSize: 18),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.heart_broken),
              ),
              // subtitle: Text('You an Edit the Detail of the Product from this'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => editlist(value: 'Beauty'),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.all(5),
              minVerticalPadding: 10,
              title: Text(
                'Fashion',
                style: TextStyle(fontSize: 18),
              ),
              leading: Icon(Icons.edit_rounded),
              // subtitle: Text('You an Edit the Detail of the Product from this'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => editlist(value: "Fashion"),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.all(5),
              minVerticalPadding: 10,
              title: Text(
                'Gift Item',
                style: TextStyle(fontSize: 18),
              ),
              leading: Icon(Icons.edit_rounded),
              // subtitle: Text('You an Edit the Detail of the Product from this'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => editlist(value: 'Gifts'),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.all(5),
              minVerticalPadding: 10,
              title: Text(
                'Mobile Accesories',
                style: TextStyle(fontSize: 18),
              ),
              leading: Icon(Icons.edit_rounded),
              // subtitle: Text('You an Edit the Detail of the Product from this'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => editlist(value: 'Mobile Accessories'),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.all(5),
              minVerticalPadding: 10,
              title: Text(
                'Toys',
                style: TextStyle(fontSize: 18),
              ),
              leading: Icon(Icons.edit_rounded),
              // subtitle: Text('You an Edit the Detail of the Product from this'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => editlist(value: 'Toys'),
                  ),
                );
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
