import 'package:ecomadmin/home/home.dart';
import 'package:ecomadmin/user.dart';
import 'package:flutter/material.dart';

class requestuserprofile extends StatefulWidget {
  requestuserprofile({Key? key, required this.r}) : super(key: key);
  Requestuser r;
  @override
  State<requestuserprofile> createState() => _requestuserprofileState();
}

bool isUpdate = false;

class _requestuserprofileState extends State<requestuserprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        // ignore: prefer_const_constructors
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color(0xFFFF7643),
      ),
      backgroundColor: Color(0xFFFF7643),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              // border: Border.all(color: kPrimaryColor),
              // ignore: unnecessary_const
              borderRadius: const BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    '${widget.r.name}',
                    // ignore: unnecessary_const
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Text(
                    'Mobile Num : ${widget.r.num}',
                    // ignore: unnecessary_const
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Text(
                    'Address : ${widget.r.address}',
                    // ignore: unnecessary_const
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.height * 0.4,
                      child: Image(image: NetworkImage('${widget.r.image}')),
                    ),
                  ),
                ),
                isUpdate
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Text(
                          'Request Procedue',
                          // ignore: unnecessary_const
                          style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.green),
                              onPressed: () async {
                                await Requestuser().accept(widget.r);
                                setState(
                                  () {
                                    isUpdate = true;
                                  },
                                );
                              },
                              child: Text('Accept'),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () async {
                                await Requestuser().Decline(widget.r);
                                setState(
                                  () {
                                    isUpdate = true;
                                  },
                                );
                              },
                              child: Text('Decline'),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
