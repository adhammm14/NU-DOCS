import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../shared/app_cubit/app_cubit.dart';
import '../../shared/app_cubit/app_states.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(context)..loadCoursesName(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
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
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10,),
                            Text(
                              "Adham Misallam",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: blackColor,
                                fontSize: 20,
                                height: 1.4,
                                fontFamily: "LeagueSpartan",
                              ),
                            ),
                            DropdownButton<String>(
                              value: cubit.courseCode,
                              hint: const Text("Choose Course.."),
                              icon: const Icon(IconBroken.Arrow___Down_2),
                              underline: Container(
                                height: 2,
                                color: mainColor,
                              ),
                              focusColor: mainColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              items: cubit.coursesTitles,
                              onChanged: (String? value) {
                                cubit.changeTextPopMenu(value!);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (cubit.file == null)
                    InkWell(
                      onTap: () async {
                        cubit.chooseFile();
                        // cubit.uploadFile(file);
                      },
                      child: DottedBorder(
                          strokeWidth: 3,
                          color: heavyGreyColor,
                          borderType: BorderType.RRect,
                          padding: const EdgeInsets.all(6),
                          dashPattern: [10, 5],
                          child: Container(
                            width: screenWidth,
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload_rounded,
                                    size: 50,
                                    color: heavyGreyColor,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Choose file from your device",
                                    style: TextStyle(
                                        color: heavyGreyColor,
                                        fontSize: 20,
                                        height: 1.4,
                                        fontFamily: "LeagueSpartan"),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  if (cubit.file != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: screenHeight / 9.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: lightGreyColor),
                        child: Row(
                          children: [
                            Container(
                              height: double.infinity,
                              width: 80,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15))),
                              child: Center(
                                child: Stack(children: [
                                  SvgPicture.asset(
                                    "assets/icons/file.svg",
                                    width: 60,
                                    color: whiteColor,
                                  ),
                                  Positioned(
                                    right: 11,
                                    bottom: 10,
                                    child: Container(
                                      color: Colors.red,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 2),
                                      child: Text(
                                        "PDF",
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: whiteColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 150,
                              child: TextFormField(
                                controller: cubit.fileNameController,
                                cursorColor: Colors.grey.withOpacity(0.8),
                                style: TextStyle(
                                    color: blackColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700
                                ),
                                decoration: InputDecoration(
                                  hintText: cubit.file.name,
                                  hintStyle: TextStyle(
                                      color: blackColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  cubit.deleteFile();
                                },
                                icon: const Icon(
                                  Icons.delete_rounded,
                                  size: 25,
                                )),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  if(state is UploadFileLoadingState)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Loading..",
                            style: TextStyle(
                              color: mainColor,
                              fontSize: 18,
                              height: 1,
                              fontFamily: "LeagueSpartan",
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        LinearPercentIndicator(
                          animation: true,
                          animationDuration: 2000,
                          backgroundColor: mainColor.withOpacity(0.2),
                          progressColor: mainColor,
                          percent: 1,
                          barRadius: const Radius.circular(10),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            bottomSheet: MaterialButton(
              onPressed: () async {
                if (cubit.courseCode!.isNotEmpty && cubit.file != null) {
                  cubit.uploadFile();
                  await Future.delayed(Duration(milliseconds: 2000));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Congratulations!",
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 20,
                                    fontFamily: "LeagueSpartan"),
                              ),
                              const Text("Your File Have Been Uploaded Now."),
                            ],
                          ),
                        ),
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  );
                  Navigator.pop(context);
                  await Future.delayed(Duration(milliseconds: 2000));
                } else {
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
                                "Error Message!",
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 20,
                                    fontFamily: "LeagueSpartan"),
                              ),
                              const Text("Please add file and choose course first."),
                            ],
                          ),
                        ),
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  );
                }
              },
              minWidth: double.infinity,
              height: 60,
              color: mainColor,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Text(
                "Post",
                style: TextStyle(
                    color: whiteColor,
                    fontSize: 25,
                    fontFamily: "LeagueSpartan"),
              ),
            ),
          );
        },
      ),
    );
  }
}
