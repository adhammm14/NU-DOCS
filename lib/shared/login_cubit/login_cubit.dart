import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/home_layout.dart';
import '../../models/user_model.dart';
import '../network/local/cache_helper.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit(this.context) : super(LoginInitialState());

  final BuildContext context;

  static LoginCubit get(context) => BlocProvider.of(context);

  bool hidden = true;


  void registerAccount(TextEditingController nameController, TextEditingController emailController, TextEditingController passController, TextEditingController phoneController) {
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text)
        .then((value) {
      print("User with email: ${value.user!.email} and id: ${value.user!.uid} Added Successfully");
      createAccount(uId: value.user!.uid, name: nameController.text, email: emailController.text, phone: phoneController.text,);
      emit(SignUpSuccessfullyState());
    }).catchError((error) {
      print(error);
    });
  }

  void createAccount(
      {required String uId, required String name, required String email, required String phone}) {
    UserModel userModel = UserModel(image: "https://cdn-icons-png.flaticon.com/128/3177/3177440.png",bio: "",uId: uId, name: name, email: email, phone: phone);

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
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeLayout()));
      emit(HomePageState());
    })
        .catchError(
            (error){
          print(error);
        });
  }

  void changeHidden(){
    hidden = !hidden;
  }

}