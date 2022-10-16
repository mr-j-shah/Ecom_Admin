import 'package:flutter/material.dart';

class swip extends StatelessWidget {
  const swip({Key? key, required this.text, required this.image})
      : super(key: key);
  final String? text;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(text!),
          ),
          Expanded(
            child: Image(
              image: AssetImage(image!),
            ),
          ),
        ],
      ),
    );
  }
}
