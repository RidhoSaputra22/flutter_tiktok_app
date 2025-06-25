class User {
  String? id;
  String? nama;
  String? tanggal_lahir;
  String? gender;
  String? email;
  String? phone;
  String? password;
  String? photo;

  User({
    this.id,
    this.nama,
    this.tanggal_lahir,
    this.gender,
    this.email,
    this.phone,
    this.password,
    this.photo,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'].toString(),
        nama: json['nama'],
        tanggal_lahir: json['tanggal_lahir'],
        gender: json['gender'],
        email: json['email'],
        phone: json['phone'],
        password: "",
        photo: json['photo'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'tanggal_lahir': tanggal_lahir,
        'gender': gender,
        'email': email,
        'phone': phone,
        'password': password,
        'photo': photo,
      };
}
