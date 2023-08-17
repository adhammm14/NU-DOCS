import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nu_sources/shared/app_cubit/app_states.dart';

import '../../modules/AddPostPage.dart';
import '../../modules/FavoritePage.dart';
import '../../modules/HomePage.dart';
import '../styles/icon_broken.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit(this.context) : super(AppInitialState());

  final BuildContext context;

  static AppCubit get(context) => BlocProvider.of(context);

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

  void changeNavigationPage(int value){
    if(value == 1){
      emit(AddPostPageState());
    }else {
      currentIndex = value;
      emit(ChangeNavigationPageState());
    }
  }
}