class UserModel {
  String? id;
  String? email;
  String? alamat;
  String? fName;
  String? lName;
  String? noHp;

  UserModel(
      {this.id, this.email, this.alamat, this.fName, this.lName, this.noHp});

  // Terima data dari server
  factory UserModel.fromMap(map) {
    return UserModel(
        email: map['email'],
        alamat: map['alamat'],
        fName: map['namaDepan'],
        lName: map['namaBelakang'],
        noHp: map['noHp']);
  }

  factory UserModel.fromJson(Map<String, dynamic> jsonObject) {
    return UserModel(id: jsonObject['id'] as String);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nameDepan': fName,
      'nameBelakang': lName,
      'alamat': alamat,
      'noHp': noHp
    };
  }
}
