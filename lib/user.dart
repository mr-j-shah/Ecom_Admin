import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authcontroller {
  Future<bool> checkUserExists(GoogleSignInAccount googleUser) async {
    // check if user already exists in firebase auth
    final snapShot = await FirebaseFirestore.instance
        .collection('Admin')
        .doc(googleUser.email)
        .get();

    if (snapShot.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class Requestuser {
  String? name, num, email, address, image;
  Requestuser() {}
  Requestuser.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    name = data['Name'];
    num = data['phone'];
    address = data['address'];
    email = data['email'];
    image = data['image'];
  }
  accept(Requestuser r) async {
    print(r.name);
    print(r.address);
    print(r.num);
    print(r.email);
    print(r.image);
    await FirebaseFirestore.instance.collection('user').doc(r.email).set({
      'Name': r.name,
      'address': r.address,
      'phone': r.num,
      'email': r.email,
      'image': r.image
    });
    await FirebaseFirestore.instance
        .collection('requestUser')
        .doc(r.email)
        .delete();
  }

  Decline(Requestuser r) async {
    await FirebaseFirestore.instance
        .collection('requestUser')
        .doc(r.email)
        .delete();
  }
}

class product {
  String? name, description;
  int? quantity, price;
  product.fromDocument(DocumentSnapshot d) {
    final data = d.data()! as Map<String, dynamic>;
    name = d['Name'];
    description = d['Description'];
    quantity = d['Quantity'];
    price = d['Price'];
  }
}

class Order {
  String? name, address, email, phone, date, time, category;
  List<dynamic> cart = [];
  Order.fromDoc(DocumentSnapshot d) {
    final data = d.data()! as Map<String, dynamic>;
    name = d['Name'];
    address = d['address'];
    email = d['email'];
    phone = d['phone'];
    cart = d['cartList'];
    date = d['date'];
    time = d['time'];
  }
}

class User {
  String? name, num, email, address, image;

  User.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    name = data['Name'];
    num = data['phone'];
    address = data['address'];
    email = data['email'];
    image = data['image'];
  }
}
