class UserModel {
  String? email;
  String? alamat;
  String? fName;
  String? lName;
  String? noHp;

  UserModel({this.email, this.alamat, this.fName, this.lName, this.noHp});

  // Terima data dari server
  factory UserModel.fromMap(map) {
    return UserModel(
        email: map['email'],
        alamat: map['alamat'],
        fName: map['namaDepan'],
        lName: map['namaBelakang'],
        noHp: map['noHp']);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': fName,
      'lastName': lName,
      'alamat': alamat,
      'noHp': noHp
    };
  }
}
