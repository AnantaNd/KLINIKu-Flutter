import 'package:flutter/material.dart';
import 'package:kliniku/components/utils/reuse_widgets.dart';
import 'package:kliniku/const.dart';
import 'package:kliniku/pages/ListDokter/model/DokterModel.dart';

class DokterDetail extends StatefulWidget {
  final DokterModel dokterMd;
  const DokterDetail({Key? key, required this.dokterMd}) : super(key: key);

  @override
  State<DokterDetail> createState() => _DokterDetailState();
}

class _DokterDetailState extends State<DokterDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 2 / 3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/doctor.jpg'),
                    fit: BoxFit.cover)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    offset: Offset(0, -4),
                    blurRadius: 8,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 30,
                      right: 30,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${widget.dokterMd.nama}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {}, //direct whatsapp
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              Icons.whatsapp,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        InkWell(
                          onTap: () {}, //direct tlp
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(
                              Icons.call_rounded,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 30,
                      right: 30,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Spesialis ${widget.dokterMd.spesialis}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 30,
                      right: 30,
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "${widget.dokterMd.deskripsi}",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  AlertDialog alert = confirmBox(context);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                },
                                child: Text(
                                  'buat janji'.toUpperCase(), // Buat Janji
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
