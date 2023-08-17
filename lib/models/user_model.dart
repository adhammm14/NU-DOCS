class UserModel {
  String? uId;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? bio;


  UserModel({this.image,this.bio,required this.uId,
      required this.name,
      required this.email,
      required this.phone});

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    bio = json['bio'];

  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'phone': phone,
      'image' : image,
      'bio' : bio,
    };
  }
}
