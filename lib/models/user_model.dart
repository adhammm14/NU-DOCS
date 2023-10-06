class UserModel {
  String? uId;
  String? name;
  String? email;
  String? gender;
  String? image;
  String? school;


  UserModel({this.image,this.school,required this.uId,
      required this.name,
      required this.email,
      required this.gender});

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    image = json['image'];
    school = json['school'];

  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'gender': gender,
      'image' : image,
      'school' : school,
    };
  }
}
