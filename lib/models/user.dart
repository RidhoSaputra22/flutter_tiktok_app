class User {
  String id;
  String nama;
  String tanggal_lahir;
  String gender;
  String email;
  String password;
  String photo;

  User({
    required this.id,
    required this.nama,
    required this.tanggal_lahir,
    required this.gender,
    required this.email,
    required this.password,
    required this.photo,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'].toString(),
        nama: json['nama'],
        tanggal_lahir: json['tanggal_lahir'],
        gender: json['gender'],
        email: json['email'],
        password: "",
        photo: json['photo'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'tanggal_lahir': tanggal_lahir,
        'gender': gender,
        'email': email,
        'password': password,
        'photo': photo,
      };
}
