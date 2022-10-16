import 'package:ecomadmin/Splashscreen/body.dart/swip.dart';
import 'package:ecomadmin/home/home.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../user.dart';

int currentpage = 0;

class splashbody extends StatefulWidget {
  splashbody({Key? key}) : super(key: key);

  @override
  State<splashbody> createState() => _splashbodyState();
}

List<Map<String, String>> screen = [
  {
    "text": "Welcome to Budget Bazar, Let’s shop!",
    "image": "assets/images/splash_1.png"
  },
  {
    "text": "We help people conect with store \naround Region",
    "image": "assets/images/splash_2.png"
  },
  {
    "text": "We show the easy way to shop. \nJust stay at home with us",
    "image": "assets/images/splash_3.png"
  },
];

class _splashbodyState extends State<splashbody> {
  bool isLoading = false;
  Authcontroller _auth = new Authcontroller();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: const Color(0xFFFF7643),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                    child: Container(
                      //TO DO Chnage NAME AS PER COMPANY NAME
                      child: const Text(
                        'Budget Bazar',
                        style: TextStyle(
                          fontSize: 35,
                          color: Color(0xFFFF7643),
                          // fontStyle: ,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: PageView.builder(
                      onPageChanged: (value) {
                        setState(() {
                          currentpage = value;
                        });
                      },
                      itemCount: screen.length,
                      itemBuilder: (context, index) => swip(
                        text: screen[index]["text"],
                        image: screen[index]["image"],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              screen.length,
                              (index) => buildDot(index: index),
                            ),
                          ),
                          const Spacer(),
                          DefaultButton(
                            text: 'Sign In',
                            press: () {
                              setState(() {
                                isLoading = true;
                                googlelogin();
                              });
                            },
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),

                  // Expanded(flex: 1, child: Container()),
                ],
              ));
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentpage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentpage == index ? Colors.black54 : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  googlelogin() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    bool user = await Authcontroller().checkUserExists(googleUser!);
    if (user) {
      await _auth.signInWithGoogle();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => home(),
        ),
      );
      isLoading = false;
    }
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.06,
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: const Color(0xFFFF7643),
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
