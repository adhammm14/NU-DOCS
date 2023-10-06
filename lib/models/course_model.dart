class CourseModel {
  String? id;
  String? name;
  String? code;
  String? code2;
  String? core;

  CourseModel({
    required this.name,
    required this.id,
    required this.code,
    required this.code2,
    required this.core,
  });

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    code2 = json['2nd code'];
    core = json['core'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      '2nd code': code2,
      'core' : core,
    };
  }
}