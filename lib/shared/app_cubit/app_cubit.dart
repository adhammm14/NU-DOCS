import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nu_sources/models/course_model.dart';
import 'package:nu_sources/models/file_model.dart';
import 'package:nu_sources/shared/app_cubit/app_states.dart';
import 'package:path_provider/path_provider.dart';

import '../../modules/app_pages/AddPostPage.dart';
import '../../modules/app_pages/FavoritePage.dart';
import '../../modules/app_pages/HomePage.dart';
import '../styles/icon_broken.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit(this.context) : super(AppInitialState());

  final BuildContext context;

  static AppCubit get(context) => BlocProvider.of(context);

  //Navbar Functions..

  int currentIndex = 0;

  var pages = [
    const HomePage(),
    const AddPostPage(),
    const FavoritePage(),
  ];

  List<IconData> navIcons = [
    IconBroken.Home,
    IconBroken.Plus,
    IconBroken.Heart,
  ];

  void changeNavigationPage(int value) {
    if (value == 1) {
      emit(AddPostPageState());
    } else {
      currentIndex = value;
      emit(ChangeNavigationPageState());
    }
  }

  void setData() async {
    var data = {
      'id': "41",
      'name': "Electric Circuits",
      'code': "ECEN 101",
      '2nd code': "",
      'core': "Physics Core",
    };

    await FirebaseFirestore.instance
        .collection("schools")
        .doc("2")
        .collection("courses")
        .doc("41")
        .set(data)
        .then((value) {
      print("value added");
    });
  }

  //Courses Functions..

  List<CourseModel> allCourses = [];
  List<CourseModel> searchedCourses = [];
  List<CourseModel> recentlyCourses = [];
  List<CourseModel> showedCourses = [];
  List<CourseModel> favCourses = [];

  List<DropdownMenuItem<String>> coursesTitles = [];

  String? courseCode;
  CourseModel? choosedCourse;

  void changeTextPopMenu(String value) {
    courseCode = value;
    emit(EditTextPopMenuSuccessfullyState());
  }

  void loadCoursesName() async {
    getCourses();
    await Future.delayed(const Duration(seconds: 1));
    coursesTitles = [];
    for (var element in allCourses) {
      coursesTitles.add(
        DropdownMenuItem(
            value: element.code2 != ""
                ? "${element.code} & ${element.code2}"
                : "${element.code}",
            child: Text(element.code2 != ""
                ? "${element.code} & ${element.code2}"
                : "${element.code}")),
      );
    }
    emit(GetTitlesSuccessfullyState());
  }

  void getCourses() async {
    emit(LoadCoursesState());
    await FirebaseFirestore.instance
        .collection("schools")
        .doc("2")
        .collection("courses")
        .get()
        .then((value) {
      for (var element in value.docs) {
        allCourses.add(CourseModel.fromJson(element.data()));
      }
      emit(CoursesLoadedSuccessfullyState());
    });
    showedCourses = [];
    showedCourses.addAll(allCourses);
    emit(EditShowedCoursesState());
  }

  void addToRecently(CourseModel model) {
    if (recentlyCourses.length == 2) {
      recentlyCourses.removeAt(1);
      recentlyCourses.add(model);
      emit(EditRecentlyCoursesState(recentlyCourses));
    } else {
      recentlyCourses.add(model);
      emit(EditRecentlyCoursesState(recentlyCourses));
    }
  }

  void searchCourse(String value) {
    value = value.toLowerCase();
    searchedCourses = [];
    for (var item in allCourses) {
      if (item.code!.toLowerCase().contains(value) ||
          item.code2!.toLowerCase().contains(value) &&
              value.isNotEmpty &&
              value == "") {
        searchedCourses.add(item);
      } else if (value.isEmpty) {
        searchedCourses = [];
      }
    }
    showedCourses = [];
    showedCourses.addAll(searchedCourses);
    emit(EditShowedCoursesState());
  }

  CourseModel? getCourseCodes() {
    if(courseCode!.contains("&")) {
      var text = courseCode!.split("&");
      print(text);
      for (var element in allCourses) {
        if (element.code!.contains(text.first.trim()) &&
            element.code2!.contains(text.last.trim())) {
          return element;
        }
      }
    }else{
      for (var element in allCourses) {
        if (element.code!.contains(courseCode!.trim())) {
          return element;
        }
      }
    }
  }

  CourseModel? currentCourse;
  Future<void> getCurrentCourseData(String courseID) async {
    emit(GetCourseDataState());
    await FirebaseFirestore.instance
        .collection("schools")
        .doc("2")
        .collection("courses")
        .doc(courseID)
        .get()
        .then((value) {
      currentCourse = CourseModel.fromJson(value.data()!);
      emit(GetCourseDataSuccessfullyState());
    });
    getCurrentCourseFiles();
  }

  Future<void> addCourseToFav(CourseModel model) async {
    if(model.favorite == false){
      CourseModel updatedCourseModel = CourseModel(
          name: model.name,
          id: model.id,
          code: model.code,
          code2: model.code2,
          core: model.core,
          favorite: true
      );
      await FirebaseFirestore.instance
          .collection("schools")
          .doc("2")
          .collection("courses")
          .doc(model.id)
          .set(updatedCourseModel.toMap())
          .then((value) {
        print("course ${model.code} added to fav");
      });
      emit(AddCourseToFavSuccessfullyState());
    }else{
      CourseModel updatedCourseModel = CourseModel(
          name: model.name,
          id: model.id,
          code: model.code,
          code2: model.code2,
          core: model.core,
          favorite: false
      );
      await FirebaseFirestore.instance
          .collection("schools")
          .doc("2")
          .collection("courses")
          .doc(model.id)
          .set(updatedCourseModel.toMap())
          .then((value) {
        print("course ${model.code} deleted to fav");
      });
      emit(DeleteCourseToFavSuccessfullyState());
    }
  }

  void getFavCourses() async {
    getCourses();
    await Future.delayed(const Duration(milliseconds: 300));
    favCourses = [];
    for(var element in allCourses){
      if(element.favorite == true){
        favCourses.add(element);
      }
    }
    emit(AddCourseToFavListSuccessfullyState());
  }

  //Files Functions..

  var file;
  var fileNameController = TextEditingController();

  Future<void> chooseFile() async {
    emit(ChooseFileLoadingState());
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    file = result.files.first;
    fileNameController.text = file.name;
    emit(ChooseFileSuccessfullyState());
  }

  void deleteFile() {
    file = null;
    fileNameController.text = "";
    emit(DeleteFileState());
  }

  String fileURL = '';
  void uploadFile() {
    emit(UploadFileLoadingState());
    File mainFile = File(file.path!);
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("$courseCode/${file.name}")
        .putFile(mainFile)
        .then((value) {
      value.ref.getDownloadURL().then((value2) {
        fileURL = value2;
        FileModel fileModel = FileModel(
            id: "",
            name: fileNameController.text,
            fileUrl: fileURL,
            courseCode: getCourseCodes()!.code,
            courseCode2: getCourseCodes()!.code2,
            author: "adham misallam",
            likes: "0",
            date: DateTime.now().toString(),
            isVerifed: false,
            isLiked: false
        );

        FirebaseFirestore.instance
            .collection("schools")
            .doc("2")
            .collection("courses")
            .doc(getCourseCodes()!.id)
            .collection("files")
            .add(fileModel.toMap())
            .then((DocumentReference doc) {
              FileModel updatedFileModel = FileModel(
                  id: doc.id,
                  name: fileModel.name,
                  fileUrl: fileModel.fileUrl,
                  courseCode: fileModel.courseCode,
                  courseCode2: fileModel.courseCode2,
                  author: fileModel.author,
                  likes: fileModel.likes,
                  date: fileModel.date,
                  isVerifed: fileModel.isVerifed,
                  isLiked: fileModel.isLiked
              );
          FirebaseFirestore.instance
              .collection("schools")
              .doc("2")
              .collection("courses")
              .doc(getCourseCodes()!.id)
              .collection("files")
              .doc(doc.id)
              .set(updatedFileModel.toMap())
              .then((value) => print("file with ${doc.id} added")
          );
        });
        emit(UploadFileSuccessfullyState());
      }).catchError((onError) {
        print(onError);
      });
    }).catchError((error) {
      print(error);
    });
  }

  List<FileModel> allCourseFiles = [];

  Future<void> getCurrentCourseFiles() async {
    emit(GetCourseFilesLoadingState());
    await FirebaseFirestore.instance
        .collection("schools")
        .doc("2")
        .collection("courses")
        .doc(currentCourse!.id!)
        .collection("files")
        .get()
        .then((value) {
      for (var element in value.docs) {
        allCourseFiles.add(FileModel.fromJson(element.data()));
      }
      emit(GetCourseFilesSuccessfullyState());
    });
  }

  FileModel? currentFile;
  Future<void> getCurrentFileData(String courseID,String fileID) async {
    emit(GetFileDataLoadingState());
    await FirebaseFirestore.instance
        .collection("schools")
        .doc("2")
        .collection("courses")
        .doc(courseID)
        .collection("files")
        .doc(fileID)
        .get()
        .then((value) {
      currentFile = FileModel.fromJson(value.data()!);
      print(currentFile!.likes);
      emit(GetFileDataSuccessfullyState());
    });
  }

  Future<void> likeFile(CourseModel course, FileModel file) async {
    if(file.isLiked == false){
      FileModel updatedFile = FileModel(
          id: file.id,
          name: file.name,
          fileUrl: file.fileUrl,
          courseCode: file.courseCode,
          courseCode2: file.courseCode2,
          author: file.author,
          likes: "${int.parse(file!.likes!.toString()) + 1}",
          date: file.date,
          isVerifed: file.isVerifed,
          isLiked: true
      );
      await FirebaseFirestore.instance
          .collection("schools")
          .doc("2")
          .collection("courses")
          .doc(course.id)
          .collection("files")
          .doc(file.id)
          .set(updatedFile.toMap())
          .then((value) {
        print("course ${file.name} Liked");
      });
      emit(LikeFileState());
    }else{
      FileModel updatedFile = FileModel(
          id: file.id,
          name: file.name,
          fileUrl: file.fileUrl,
          courseCode: file.courseCode,
          courseCode2: file.courseCode2,
          author: file.author,
          likes: "${int.parse(file!.likes!.toString()) - 1}",
          date: file.date,
          isVerifed: file.isVerifed,
          isLiked: false
      );
      await FirebaseFirestore.instance
          .collection("schools")
          .doc("2")
          .collection("courses")
          .doc(course.id)
          .collection("files")
          .doc(file.id)
          .set(updatedFile.toMap())
          .then((value) {
        print("course ${file.name} Disliked");
      });
      emit(DislikeFileState());
    }
  }

  Future<File?> downloadFile(String url, String name) async{
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');

    print(file.path);

    final response = await Dio().get(
        url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
      ),
    );

    final ref = file.openSync(mode: FileMode.write);
    ref.writeFromSync(response.data);
    await ref.close();

    return file;
  }

  String getDate(String timeX){
    ////file date
    var timeAllFile = timeX.split(" ");
    var timeDateFile = timeAllFile.first;
    var timeClockFile = timeAllFile.last;
    var dayFile = timeDateFile.split("-").last;
    var monthFile = timeDateFile.split("-")[1];
    var yearFile = timeDateFile.split("-").first;
    var hourFile = timeClockFile.split(":").first;
    var minFile = timeClockFile.split(":")[1];

    ////now date
    var timeAllNow = DateTime.now().toString().split(" ");
    var timeDateNow = timeAllNow.first;
    var timeClockNow = timeAllNow.last;
    var dayNow = timeDateNow.split("-").last;
    var monthNow = timeDateNow.split("-")[1];
    var yearNow = timeDateNow.split("-").first;
    var hourNow = timeClockNow.split(":").first;
    var minNow = timeClockNow.split(":")[1];

    if(yearNow == yearFile){
      if(monthNow == monthFile){
        if(dayNow == dayFile){
          if(hourNow == hourFile){
            if(minNow == minFile){
              return "Just Now!";
            }else{
              return "${int.parse(minNow) - int.parse(minFile)} Minutes ago";
            }
          }else{
            return "${int.parse(hourNow) - int.parse(hourFile)} Hours ago";
          }
        }else{
          return "${int.parse(dayNow) - int.parse(dayFile)} Days ago";
        }
      }else{
        return "${int.parse(monthNow) - int.parse(monthFile)} Months ago";
      }
    }else{
      return "${int.parse(yearNow) - int.parse(yearFile)} Years ago";
    }
  }
/////////////////////
}
