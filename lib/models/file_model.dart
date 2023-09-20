class FileModel {
  String? id;
  String? name;
  String? fileUrl;
  String? courseCode;
  String? courseCode2;
  String? author;
  String? likes;
  String? date;
  bool? isVerifed;
  bool? isLiked;

  FileModel({
    required this.id,
    required this.name,
    required this.fileUrl,
    required this.courseCode,
    required this.courseCode2,
    required this.author,
    required this.likes,
    required this.date,
    required this.isVerifed,
    required this.isLiked,
  });

  FileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fileUrl = json['fileUrl'];
    courseCode = json['courseCode'];
    courseCode2 = json['courseCode2'];
    author = json['author'];
    likes = json['likes'];
    date = json['date'];
    isVerifed = json['isVerifed'];
    isLiked = json['isLiked'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'fileUrl': fileUrl,
      'courseCode': courseCode,
      'courseCode2': courseCode2,
      'author': author,
      'likes' : likes,
      'date' : date,
      'isVerifed' : isVerifed,
      'isLiked' : isLiked,
    };
  }
}