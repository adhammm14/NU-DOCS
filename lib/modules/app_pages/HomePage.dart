import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nu_sources/modules/app_pages/AllCoursesPage.dart';

import '../../shared/app_cubit/app_cubit.dart';
import '../../shared/app_cubit/app_states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import 'CoursePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(context)..emit(AppInitialState()),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          AppCubit cubit = AppCubit.get(context);
          var screenWidth = MediaQuery.of(context).size.width;
          var screenHeight = MediaQuery.of(context).size.height;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              titleSpacing: 15,
              title: const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/128/4333/4333609.png"),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Recently Courses",style: TextStyle(color: blackColor,fontSize: 23,fontFamily: "LeagueSpartan"),),
                        TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const AllCoursesPage()));
                          },
                          child: Text("See All",style: TextStyle(color: mainColor,fontSize: 15,fontFamily: "LeagueSpartan"),),
                        ),
                      ],
                    ),
                    ConditionalBuilder(
                        condition: cubit.recentlyCourses.isNotEmpty,
                        builder: (context) => Expanded(
                          flex: 1,
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns in the grid
                                crossAxisSpacing: 10.0, // Spacing between columns
                              ),
                              itemCount: cubit.recentlyCourses.length,
                              itemBuilder: (BuildContext context,int index){
                                return Center(
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CoursePage(courseModel: cubit.recentlyCourses[index],)));
                                    },
                                    child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/folder.svg",
                                          width: screenWidth/2.4,
                                          color: cubit.recentlyCourses[index].core == "ITSC core" ? CSColor.withOpacity(0.8) : cubit.showedCourses[index].core == "Math Core" ? MathColor.withOpacity(0.8):PHYSColor,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  cubit.recentlyCourses[index].core!,
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
                                                  "${cubit.recentlyCourses[index].code!}: ${cubit.recentlyCourses[index].name!}",
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
                        fallback: (context) => Center(child: Column(children:[
                          Image.asset("assets/images/box.png",width: 150,),
                          const SizedBox(height: 10,),
                          Text("Recently courses will be here!",style: TextStyle(color: blackColor.withOpacity(0.7),fontSize: 18,fontFamily: "LeagueSpartan"),)
                        ]),
                        ),
                    ),
                    const SizedBox(height: 10,),
                    Text("New",style: TextStyle(color: blackColor,fontSize: 23,fontFamily: "LeagueSpartan"),),
                    const SizedBox(height: 10,),
                    Expanded(
                      flex: 2,
                      child: ListView.builder(
                          itemCount: colors.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: InkWell(
                                onTap: (){
                                },
                                child: Container(
                                  height: screenHeight/9.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: lightGreyColor
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: double.infinity,
                                        width: 80,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15))
                                        ),
                                        child: Center(
                                          child: Stack(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/icons/file.svg",
                                                  width: 60,
                                                  color: colors[index],
                                                ),
                                                Positioned(
                                                  right: 11,
                                                  bottom: 10,
                                                  child: Text(
                                                    "CSCI101",
                                                    style: TextStyle(fontSize: 20,color: whiteColor.withOpacity(0.5),fontWeight: FontWeight.w700),
                                                  ),
                                                ),
                                              ]
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Spacer(),
                                            Text(titles[index],maxLines:1,overflow: TextOverflow.ellipsis,style: TextStyle(color: blackColor,fontSize: 17, fontWeight: FontWeight.w700),),
                                            const SizedBox(height: 4,),
                                            Text(users[index],maxLines:1,overflow: TextOverflow.ellipsis,style: TextStyle(color: blackColor.withOpacity(0.2),fontSize: 12, fontWeight: FontWeight.w400),),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                const SizedBox(width: 5,),
                                                SvgPicture.asset("assets/icons/like.svg", width: 18,),
                                                const SizedBox(width: 5,),
                                                Text(numbers[index],style: const TextStyle(color: Colors.blue,fontSize: 12, fontWeight: FontWeight.w500),),
                                                const SizedBox(width: 15,),
                                                SvgPicture.asset("assets/icons/star.svg", width: 18, color: verified[index] ?Colors.orangeAccent : blackColor.withOpacity(0.1),),
                                                const SizedBox(width: 5,),
                                                Text(verified[index] ?"Verified" : "Not Verified",style: TextStyle(color: verified[index] ?Colors.orangeAccent : blackColor.withOpacity(0.1),fontSize: 12, fontWeight: FontWeight.w500),),

                                              ],
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
