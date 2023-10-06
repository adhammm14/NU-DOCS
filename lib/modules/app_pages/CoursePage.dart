import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:nu_sources/modules/app_pages/FilePage.dart';
import 'package:nu_sources/shared/styles/colors.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

import '../../models/course_model.dart';
import '../../shared/app_cubit/app_cubit.dart';
import '../../shared/app_cubit/app_states.dart';
import '../../shared/styles/icon_broken.dart';

class CoursePage extends StatefulWidget {
  CourseModel? courseModel;
  CoursePage({required this.courseModel,super.key});

  @override
  State<CoursePage> createState() => _CoursePageState(this.courseModel);
}

class _CoursePageState extends State<CoursePage> {
  CourseModel? courseModel;
  _CoursePageState(this.courseModel);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(context)..getCurrentCourseData(courseModel!.id!),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          AppCubit cubit = AppCubit.get(context);
          var screenWidth = MediaQuery.of(context).size.width;
          var screenHeight = MediaQuery.of(context).size.height;
          var searchController = TextEditingController();
          return ConditionalBuilder (
            condition: cubit.currentCourse != null || state is GetCourseDataSuccessfullyState,
            builder: (context) => Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: BackButton(
                  color: blackColor,
                ),
                actions: [
                  SearchBarAnimation(
                    textEditingController: searchController,
                    isOriginalAnimation: false,
                    trailingWidget: Container(),
                    secondaryButtonWidget: Icon(Icons.close, color: blackColor,size: 27,),
                    buttonWidget: Icon(IconBroken.Search, color: blackColor,size: 27,),
                    searchBoxWidth: screenWidth/1.4,
                    buttonBorderColour: Colors.transparent,
                    buttonColour: whiteColor,
                    buttonElevation: 0,
                    buttonShadowColour: Colors.transparent,
                    durationInMilliSeconds: 350,
                  ),
                  LikeButton(
                    size: 50,
                    circleColor: CircleColor(start: Colors.red, end: errorColor),
                    isLiked: cubit.inFav,
                    likeBuilder: (bool isLiked){
                      return Icon(
                          Icons.favorite,
                          color: isLiked ? errorColor : heavyGreyColor,
                          size: 30,
                      );
                    },
                    onTap: (v) async{
                      cubit.checkFavCourse(cubit.currentCourse!);
                      if(cubit.inFav!){
                        cubit.delCourseToFav(cubit.currentCourse!);
                        cubit.getCurrentCourseData(cubit.currentCourse!.id!);
                        return cubit.inFav!;
                      }else{
                        cubit.addCourseToFav(cubit.currentCourse!);
                        cubit.getCurrentCourseData(cubit.currentCourse!.id!);
                        return cubit.inFav!;
                      }
                    },
                  ),
                  const SizedBox(width: 10,),
                ],
              ),
              body: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/folder.svg",
                          width: screenWidth/2,
                          color: cubit.currentCourse!.core == "ITSC core" ? CSColor.withOpacity(0.8) : courseModel!.core == "Math Core" ? MathColor.withOpacity(0.8):PHYSColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: screenWidth/2.2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  cubit.currentCourse!.core!,
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
                                  "${cubit.currentCourse!.code!}: ${cubit.currentCourse!.name!}",
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
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        Text("Files",style: TextStyle(color: blackColor,fontSize: 23,fontFamily: "LeagueSpartan"),),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    if(cubit.allCourseFiles.isNotEmpty || state is GetCourseFilesLoadingState)
                      Expanded(
                      flex: 2,
                      child: ListView.builder(
                          itemCount: cubit.allCourseFiles.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => FilePage(fileModel: cubit.allCourseFiles[index],courseModel: courseModel,)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                                                    color: cubit.currentCourse!.core == "ITSC core" ? CSColor.withOpacity(0.8) : courseModel!.core == "Math Core" ? MathColor.withOpacity(0.8):PHYSColor,
                                                ),
                                                Positioned(
                                                  right: 11,
                                                  bottom: 10,
                                                  child: Text(
                                                    cubit.currentCourse!.code!,
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
                                            Text(cubit.allCourseFiles[index].name!,maxLines:1,overflow: TextOverflow.ellipsis,style: TextStyle(color: blackColor,fontSize: 17, fontWeight: FontWeight.w700),),
                                            const SizedBox(height: 4,),
                                            Text(cubit.allCourseFiles[index].author!,maxLines:1,overflow: TextOverflow.ellipsis,style: TextStyle(color: blackColor.withOpacity(0.2),fontSize: 12, fontWeight: FontWeight.w400),),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                const SizedBox(width: 5,),
                                                SvgPicture.asset("assets/icons/like.svg", width: 18,),
                                                const SizedBox(width: 5,),
                                                Text(cubit.allCourseFiles[index].likes!.length.toString(),style: const TextStyle(color: Colors.blue,fontSize: 12, fontWeight: FontWeight.w500),),
                                                const SizedBox(width: 15,),
                                                SvgPicture.asset("assets/icons/star.svg", width: 18, color: cubit.allCourseFiles[index].isVerifed! ?Colors.orangeAccent : blackColor.withOpacity(0.1),),
                                                const SizedBox(width: 5,),
                                                Text(cubit.allCourseFiles[index].isVerifed! ?"Verified" : "Not Verified",style: TextStyle(color: cubit.allCourseFiles[index].isVerifed! ?Colors.orangeAccent : blackColor.withOpacity(0.1),fontSize: 12, fontWeight: FontWeight.w500),),
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
                    if(cubit.allCourseFiles.isEmpty)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/icons/windsock.gif",width: 60,fit: BoxFit.cover,),
                            const SizedBox(height: 15,),
                            Text("There's no files in this course!",style: TextStyle(color: blackColor,fontSize: 20,fontFamily: "LeagueSpartan"),),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            fallback: ( context) => Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                ),
              ),
          );
        },
      ),
    );
  }
}
