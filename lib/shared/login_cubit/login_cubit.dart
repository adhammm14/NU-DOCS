import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/home_layout.dart';
import '../../models/user_model.dart';
import '../network/local/cache_helper.dart';
import '../styles/colors.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit(this.context) : super(LoginInitialState());

  final BuildContext context;

  static LoginCubit get(context) => BlocProvider.of(context);

  bool hidden = true;
  int school = 0;
  String gender = "";


  void registerAccount(TextEditingController nameController, TextEditingController emailController, TextEditingController passController) {
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text)
        .then((value) {
      print("User with email: ${value.user!.email} and id: ${value.user!.uid} Added Successfully");
      createAccount(uId: value.user!.uid, name: nameController.text, email: emailController.text);
      emit(SignUpSuccessfullyState());
    }).catchError((error) {
      print(error);
    });
  }

  void createAccount(
      {required String uId, required String name, required String email}) {
    UserModel userModel = UserModel(image: "",uId: uId, name: name, email: email, gender: "",school: "");
    CacheHelper.putStringData(key: "uId", value: uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      print("User Added");
      emit(SignUpDataSuccessfullyState());
    }).catchError((error) {
      print("error: $error");
    });
  }

  void loginAccount(TextEditingController emailController,TextEditingController passController){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text
    ).then((value)
    {
      print("user with ${value.user!.email} Signin Successfully Success");
      CacheHelper.putStringData(key: "uId", value: value.user!.uid);
      emit(LoginSuccessfullyState());
      Future.delayed(Duration(seconds: 40));
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeLayout()));
      emit(HomePageState());
    }).catchError(
            (error){
              if(error.toString() == "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted."){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: errorColor,
                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Error!",
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 20,
                                  fontFamily: "LeagueSpartan"),
                            ),
                            const Text("Email or password not correct."),
                          ],
                        ),
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                );
                emit(LoginInitialState());
              }
          print("error: $error");
        });
  }

  void changeHidden(){
    hidden = !hidden;
    emit(ChangeButtonIconState());
  }

  void changeSchoolID(int num){
    school = num;
    emit(ChangeSchoolIdState());
  }

  void changeGender(String g){
    gender = g;
    emit(ChangeGenderState());
  }

  void updateUserData(){
    String? uId = CacheHelper.getStringData(key: "uId");
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value){
      print(value.data());
      UserModel model = UserModel.fromJson(value.data()!);
      UserModel newUser = UserModel(uId: model.uId, name: model.name, email: model.email, gender: gender,image: gender == "male" ? "male.png" : "female.png", school: "$school");
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .set(newUser.toMap())
          .then((value) {
        print("User Updated");
        emit(UpdateDataSuccessfullyState());
      }).catchError((error) {
        print("error: $error");
      });
    });
  }
}