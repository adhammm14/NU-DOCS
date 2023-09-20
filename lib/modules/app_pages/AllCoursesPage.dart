import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nu_sources/shared/app_cubit/app_cubit.dart';
import 'package:nu_sources/shared/app_cubit/app_states.dart';
import 'package:nu_sources/shared/styles/colors.dart';

import '../../shared/styles/icon_broken.dart';
import 'CoursePage.dart';

class AllCoursesPage extends StatelessWidget {
  const AllCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(context)..getCourses(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          AppCubit cubit = AppCubit.get(context);
          var screenWidth = MediaQuery.of(context).size.width;
          var screenHeight = MediaQuery.of(context).size.height;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: blackColor,
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                ),
              ),
              title: Center(child: Text("All Courses",style: TextStyle(color: blackColor,fontSize: 22,fontFamily: "LeagueSpartan"),)),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SafeArea(
              child: ConditionalBuilder(
                condition: cubit.allCourses.isEmpty || state is LoadCoursesState,
                builder: (context) => Center(child: CircularProgressIndicator(color: mainColor,),),
                fallback: (context) =>  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: TextFormField(
                                onChanged: (value) {
                                  print(value);
                                  cubit.searchCourse(value);
                                },
                                cursorColor: Colors.grey.withOpacity(0.8),
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(left: 14.0,right: 8.0,bottom: 12),
                                    child: Icon(IconBroken.Search, color: Colors.grey.withOpacity(0.8)),
                                  ),
                                  prefixIconConstraints: const BoxConstraints(),
                                  hintText: "Search for course..",
                                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8),fontSize: 16),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(style: BorderStyle.none,width: 0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(style: BorderStyle.none),
                                  ),
                                  disabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(style: BorderStyle.none),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Expanded(
                            child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Number of columns in the grid
                                  crossAxisSpacing: 10.0, // Spacing between columns
                                ),
                                itemCount: cubit.showedCourses.length,
                                itemBuilder: (BuildContext context,int index){
                                  return Center(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => CoursePage(courseModel: cubit.showedCourses[index],)));
                                      },
                                      child: Stack(
                                        alignment: Alignment.bottomLeft,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/folder.svg",
                                            width: screenWidth/2.4,
                                            color: cubit.showedCourses[index].core == "ITSC core" ? CSColor.withOpacity(0.8) : cubit.showedCourses[index].core == "Math Core" ? MathColor.withOpacity(0.8):PHYSColor,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    cubit.showedCourses[index].core!,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w400,
                                                      color: whiteColor,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 3,),
                                                  Text(
                                                    "${cubit.showedCourses[index].code!}: ${cubit.showedCourses[index].name!}",
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600,
                                                      color: whiteColor,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 30,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ),
            ),
          );
        },
      ),
    );
  }
}