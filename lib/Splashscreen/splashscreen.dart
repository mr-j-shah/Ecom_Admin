import 'package:flutter/material.dart';

import 'body.dart/splashbody.dart';

class splashscreen extends StatelessWidget {
  static String routeName = "/splash";
  const splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: splashbody(),
    );
  }
}
