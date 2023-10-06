import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../shared/app_cubit/app_cubit.dart';
import '../../shared/app_cubit/app_states.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';
import 'CoursePage.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(context)..getUserData()..getFavCourses(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          var screenWidth = MediaQuery.of(context).size.width;
          var screenHeight = MediaQuery.of(context).size.height;
          return ConditionalBuilder (
            condition: cubit.model != null || state is GetUserSuccessfullyState,
            builder: (context) => Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.transparent,
                titleSpacing: 15,
                title: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: mainColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(cubit.model!.gender! == "male" ? 13 : 7.5),
                    child: Image.asset("assets/images/${cubit!.model!.image!}",fit: BoxFit.cover,),
                  ),
                ),
              ),
              body: SafeArea(
                child: ConditionalBuilder(
                  condition: cubit.favCourses.isNotEmpty,
                  builder: (context) => SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Expanded(
                        child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of columns in the grid
                              crossAxisSpacing: 10.0, // Spacing between columns
                            ),
                            itemCount: cubit.favCourses.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CoursePage(courseModel: cubit.favCourses[index],),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/folder.svg",
                                        width: screenWidth / 2.4,
                                        color: cubit.favCourses[index].core == "ITSC core"
                                            ? CSColor.withOpacity(0.8)
                                            : cubit.favCourses[index].core == "Math Core"
                                            ? MathColor.withOpacity(0.8)
                                            : PHYSColor,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                cubit.favCourses[index].core!,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: whiteColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                "${cubit.favCourses[index].code!}: ${cubit.favCourses[index].name!}",
                                                overflow:
                                                TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: whiteColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                  fallback: (context) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/icons/fav.gif",width: 200,),
                        Text("There's no favorite courses yet!\n see all courses page",style: TextStyle(color: blackColor.withOpacity(0.7),fontSize: 22,fontFamily: "LeagueSpartan"),textAlign: TextAlign.center,),
                      ],
                    )
                  ),
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
