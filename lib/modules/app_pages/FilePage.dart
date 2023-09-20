import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:nu_sources/models/file_model.dart';
import 'package:nu_sources/shared/styles/colors.dart';
import 'package:nu_sources/shared/styles/my_flutter_app_icons.dart';

import '../../models/course_model.dart';
import '../../shared/app_cubit/app_cubit.dart';
import '../../shared/app_cubit/app_states.dart';

class FilePage extends StatefulWidget {
  FileModel? fileModel;
  CourseModel? courseModel;
  FilePage({required this.fileModel,this.courseModel,super.key});

  @override
  State<FilePage> createState() => _FilePageState(this.fileModel,this.courseModel);
}

class _FilePageState extends State<FilePage> {
  FileModel? fileModel;
  CourseModel? courseModel;
  _FilePageState(this.fileModel,this.courseModel);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(context)..getCurrentCourseData(courseModel!.id!)..getCurrentFileData(courseModel!.id!, fileModel!.id!),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          AppCubit cubit = AppCubit.get(context);
          var screenWidth = MediaQuery.of(context).size.width;
          var screenHeight = MediaQuery.of(context).size.height;
          return ConditionalBuilder (
            condition: cubit.currentCourse != null || state is GetCourseDataSuccessfullyState || cubit.currentFile != null || state is GetFileDataSuccessfullyState,
            builder: (context) => Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: BackButton(
                  color: blackColor,
                ),
              ),
              body: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/file.svg",
                            width: screenWidth/2,
                            color: cubit.currentCourse!.core == "ITSC core" ? CSColor.withOpacity(0.8) : cubit.currentCourse!.core == "Math Core" ? MathColor.withOpacity(0.8):PHYSColor,
                          ),
                          Positioned(
                            right: 27,
                            bottom: 10,
                            child: Text(
                              cubit.currentCourse!.code!,
                              style: TextStyle(fontSize: 80,color: whiteColor.withOpacity(0.5),fontWeight: FontWeight.w700),
                            ),
                          ),
                        ]
                    ),
                    const SizedBox(height: 15,),
                    Text(cubit.currentFile!.name!,style: TextStyle(color: blackColor,fontSize: 23,fontFamily: "LeagueSpartan"),),
                    const SizedBox(height: 5,),
                    Text("${courseModel!.code!} & ${courseModel!.code2!} : ${courseModel!.name!}",style: TextStyle(color: blackColor,fontSize: 15,fontFamily: "LeagueSpartan"),),
                    const SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              SvgPicture.asset("assets/icons/calender.svg", width: 25,),
                              const SizedBox(height: 10,),
                              Text(cubit.getDate(fileModel!.date!),style: TextStyle(color: blackColor,fontSize: 17,fontFamily: "LeagueSpartan",overflow: TextOverflow.ellipsis),maxLines: 1,),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10,),
                        SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              Image.asset("assets/images/user.png", width: 25),
                              const SizedBox(height: 10,),
                              Text(cubit.currentFile!.author!,style: TextStyle(color: blackColor,fontSize: 17,fontFamily: "LeagueSpartan",overflow: TextOverflow.ellipsis),maxLines: 1,),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10,),
                        SizedBox(
                          width: 100,
                          child: Column(
                            children: [
                              SvgPicture.asset("assets/icons/star.svg", width: 25,color: fileModel!.isVerifed! ? Colors.orangeAccent : blackColor.withOpacity(0.1),),
                              const SizedBox(height: 10,),
                              Text(cubit.currentFile!.isVerifed! ? "Verifed" : "Not Verifed",style: TextStyle(color: fileModel!.isVerifed! ? blackColor : blackColor.withOpacity(0.1),fontSize: 17,fontFamily: "LeagueSpartan"),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        LikeButton(
                          size: 70,
                          circleColor: CircleColor(start: Colors.blue.withOpacity(0.1), end: mainColor),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: whiteColor,
                            dotSecondaryColor: ENGColor,
                            dotThirdColor: MathColor,
                            dotLastColor: mainColor,
                          ),
                          isLiked: cubit.currentFile!.isLiked,
                          likeBuilder: (bool isLiked){
                            return isLiked ? Center(
                              child: Container(
                                width: screenWidth/3,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(10),
                                ), child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(fileModel!.likes!.toString(),style: TextStyle(color: whiteColor,fontSize: 20,fontFamily: "LeagueSpartan"),).animate().fade(delay: const Duration(milliseconds: 100)).slide(),
                                  const SizedBox(width: 10,),
                                  Icon(MyFlutterApp.thumbs_up,color: whiteColor,),
                                ],
                              ),
                              ),
                            ) :
                            Center(
                              child: Container(
                                width: screenWidth/3,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: mainColor,width: 2,style: BorderStyle.solid)
                                ), child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(cubit.currentFile!.likes!,style: TextStyle(color: mainColor,fontSize: 20,fontFamily: "LeagueSpartan"),).animate().fade(delay: const Duration(milliseconds: 100)).slide(),
                                  const SizedBox(width: 10,),
                                  Icon(MyFlutterApp.thumbs_up_alt,color: mainColor,),
                                ],
                              ),
                              ),
                            );
                          },
                          onTap: (v) async{
                            if(cubit.currentFile!.isLiked!){
                              cubit.likeFile(cubit.currentCourse!,cubit.currentFile!);
                              AppCubit.get(context).getCurrentFileData(courseModel!.id!, fileModel!.id!);
                              return false;
                            }else{
                              cubit.likeFile(cubit.currentCourse!,cubit.currentFile!);
                              AppCubit.get(context).getCurrentFileData(courseModel!.id!,fileModel!.id!);
                              return true;
                            }
                          },
                        ),
                        InkWell(
                          onTap: (){
                            cubit.downloadFile(cubit.currentFile!.fileUrl!, cubit.currentFile!.name!);
                          },
                          child: Container(
                            width: screenWidth/2,
                            height: 50,
                            decoration: BoxDecoration(
                                color: lightGreyColor,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                                child: Text("Open File",style: TextStyle(color: blackColor,fontSize: 20,fontFamily: "LeagueSpartan"),),
                            ),
                          ),
                        ),
                      ],
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