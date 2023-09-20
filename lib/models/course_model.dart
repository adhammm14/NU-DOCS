class CourseModel {
  String? id;
  String? name;
  String? code;
  String? code2;
  String? core;
  bool? favorite = false;

  CourseModel({
    required this.name,
    required this.id,
    required this.code,
    required this.code2,
    required this.core,
    required this.favorite,
  });

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    code2 = json['2nd code'];
    core = json['core'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      '2nd code': code2,
      'core' : core,
      'favorite' : favorite,
    };
  }
}