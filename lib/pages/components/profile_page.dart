import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kliniku/components/utils/reuse_widgets.dart';
import 'package:kliniku/const.dart';
import 'package:kliniku/pages/auth/model/user_model.dart';

class ProfilePage extends StatefulWidget {
  final UserModel userAuth;
  const ProfilePage({Key? key, required this.userAuth}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Controller
  final _firstNameController = new TextEditingController();
  final _secondNameController = new TextEditingController();
  final _addrController = new TextEditingController();
  final _noHpController = new TextEditingController();
  final _emailController = new TextEditingController();

  final auth = FirebaseAuth.instance.currentUser!;
  final db = FirebaseFirestore.instance.collection('users');

  Future updateUser(String fname, String lname, String addr, String phoneNum,
      String email) async {
    try {
      db.where('email', isEqualTo: auth.email).get().then((event) {
        for (var doc in event.docs) {
          db.doc(doc.id).update({
            'firstName': fname,
            'lastName': lname,
            'address': addr,
            'phoneNum': phoneNum,
          });
          print(doc.id);
        }
      });
      print("user with uid ${auth.uid} updated");
    } on FirebaseAuthException catch (e) {
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            switch (e.code) {
              case "email-already-in-use":
                return alertBox(context, "Email sudah dipakai");
              default:
                return alertBox(context, "Terdapat kesalahan");
            }
          });
    }
  }

  checkNullfName(_firstNameController) {
    if (_firstNameController == '') {
      return widget.userAuth.fName;
    } else {
      return _firstNameController.text.trim();
    }
  }

  checkNullLName(_secondNameController) {
    if (_secondNameController == '') {
      return widget.userAuth.lName;
    } else {
      return _secondNameController.text.trim();
    }
  }

  checkNullAddr(_addrNameController) {
    if (_addrNameController == '') {
      return widget.userAuth.alamat;
    } else {
      return _addrNameController.text.trim();
    }
  }

  checkNullnoHp(_noHpNameController) {
    if (_noHpNameController == '') {
      return widget.userAuth.noHp;
    } else {
      return _noHpNameController.text.trim();
    }
  }

  checkNullEmail(_emailNameController) {
    if (_emailNameController == '') {
      var email = widget.userAuth.email;
      return email;
    } else {
      return _emailNameController.text.trim();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontFamily: 'Montserrat'),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  updateUser(
                      checkNullfName(_firstNameController),
                      checkNullLName(_secondNameController),
                      checkNullAddr(_addrController),
                      checkNullnoHp(_noHpController),
                      checkNullEmail(_emailController));
                },
                icon: Icon(
                  Icons.check,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, top: 18, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              defaultPicProfile(),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Text(
                "${widget.userAuth.fName} ${widget.userAuth.lName}",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
              SizedBox(
                height: 25,
              ),
              _textField("Nama Depan", "${widget.userAuth.fName}",
                  _firstNameController),
              _textField("Nama Belakang", "${widget.userAuth.lName}",
                  _secondNameController),
              _textField(
                  "Alamat", "${widget.userAuth.alamat}", _addrController),
              _textField(
                  "No Handphone", "${widget.userAuth.noHp}", _noHpController),
              _textField("Email", "${widget.userAuth.email}", _emailController),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _textField(
    String labelText, String placeholder, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 35.0),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
              fontSize: 16, fontFamily: 'Montserrat', color: Colors.black)),
    ),
  );
}

Center defaultPicProfile() {
  return Center(
    child: Stack(
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
              border: Border.all(width: 4, color: Colors.white),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(.1),
                    offset: Offset(0, 10))
              ],
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg"))),
        )
      ],
    ),
  );
}
