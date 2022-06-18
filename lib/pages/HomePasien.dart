import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kliniku/const.dart';
import 'package:kliniku/pages/auth/model/user_model.dart';
import 'package:kliniku/pages/components/home_menu.dart';
import 'package:kliniku/pages/components/location_menu.dart';
import 'package:kliniku/pages/components/profile_page.dart';
import 'package:kliniku/pages/components/status_menu.dart';

class MenuPasien extends StatefulWidget {
  const MenuPasien({Key? key}) : super(key: key);

  @override
  State<MenuPasien> createState() => _MenuPasienState();
}

class _MenuPasienState extends State<MenuPasien> {
  int index = 0;
  final screens = [HomePage(), StatusPage(), LocationPage()];
  User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;
  UserModel authUser = UserModel();
  String userId = '';

  void getData() async {
    await db
        .collection("users")
        .where('email', isEqualTo: user!.email)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
        this.authUser = UserModel.fromMap(doc.data());
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30, color: Colors.white),
      Icon(Icons.library_books, size: 30, color: Colors.white),
      Icon(Icons.location_on_sharp, size: 30, color: Colors.white),
    ];

    return Scaffold(
        appBar: _buildAppBar(),
        extendBody: true,
        backgroundColor: secondaryColor,
        bottomNavigationBar: _buildCurvedNavbar(items),
        body: screens[index]);
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text("Halo ${authUser.fName}",
          style: TextStyle(color: Colors.black, fontFamily: 'Montserrat')),
      leading: IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(userAuth: this.authUser)));
        },
        icon: Icon(
          Icons.account_circle_outlined,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout_outlined, color: Colors.black))
      ],
    );
  }

  CurvedNavigationBar _buildCurvedNavbar(List<Widget> items) {
    return CurvedNavigationBar(
      color: primaryColor,
      backgroundColor: Colors.transparent,
      items: items,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 300),
      height: 55,
      index: index,
      onTap: (index) => setState(() {
        this.index = index;
      }),
    );
  }
}
