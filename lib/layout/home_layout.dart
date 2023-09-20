import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nu_sources/modules/app_pages/AddPostPage.dart';
import 'package:nu_sources/shared/app_cubit/app_cubit.dart';
import 'package:nu_sources/shared/styles/colors.dart';

import '../shared/app_cubit/app_states.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(context),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) async {
          AppCubit cubit = AppCubit.get(context);
          if(state is AddPostPageState){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostPage()));
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            body: cubit.pages[cubit.currentIndex],
            bottomNavigationBar: AnimatedBottomNavigationBar.builder(
              itemCount: cubit.navIcons.length,
              tabBuilder: (int index, bool isActive) {
                return index==1 ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(color: mainColor,borderRadius: BorderRadius.circular(8)),
                    child: Center(child: Icon(cubit.navIcons[1],color: whiteColor,size: 32,),),
                  ),
                ): Icon(cubit.navIcons[index],color: isActive?mainColor:heavyGreyColor,size: isActive?35:28,);
              },
              gapWidth: 0,
              splashColor: mainColor,
              activeIndex: cubit.currentIndex,
              onTap: (value) {
                cubit.changeNavigationPage(value);
              },
            ),
        );
        }
      ),
    );
  }
}
