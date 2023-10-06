import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nu_sources/modules/app_pages/HomePage.dart';
import '../../shared/login_cubit/login_cubit.dart';
import '../../shared/login_cubit/login_states.dart';

import '../../shared/styles/colors.dart';

class SelectPage extends StatefulWidget {
  SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(context),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {},
          builder: (context, state) {
            LoginCubit cubit = LoginCubit.get(context);
            var screenWidth = MediaQuery.of(context).size.width;
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Center(
                  child: Text(
                    "Finish Setup",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      fontFamily: "LeagueSpartan",
                    ),
                  ),
                ),
              ),
              body: SafeArea(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Select Gender",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            fontFamily: "LeagueSpartan",
                          ),
                        ),
                      ),
                      const SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                cubit.changeGender("male");
                              });
                            },
                            child: Container(
                              width: screenWidth/2.4,
                              height: 60,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [BoxShadow(
                                      color: heavyGreyColor,
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                      offset: const Offset(0, 0)
                                  )],
                                  border: cubit.gender == "male" ? Border.all(style: BorderStyle.solid,width: 2,color: mainColor) : Border.all(style: BorderStyle.none)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset("assets/icons/male.gif"),
                                      if(cubit.gender == "male")
                                        CircleAvatar(
                                          backgroundColor: mainColor,
                                          child: Icon(Icons.check, color: whiteColor,),
                                        ),
                                    ],
                                  ),
                                  Text("Male",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: blackColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "LeagueSpartan",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                cubit.changeGender("female");
                              });
                            },
                            child: Container(
                              width: screenWidth/2.4,
                              height: 60,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [BoxShadow(
                                      color: heavyGreyColor,
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                      offset: const Offset(0, 0)
                                  )],
                                  border: cubit.gender == "female" ? Border.all(style: BorderStyle.solid,width: 2,color: mainColor) : Border.all(style: BorderStyle.none)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset("assets/icons/female.gif"),
                                      if(cubit.gender == "female")
                                        CircleAvatar(
                                          backgroundColor: mainColor,
                                          child: Icon(Icons.check, color: whiteColor,),
                                        ),
                                    ],
                                  ),
                                  Text("Female",
                                    style: TextStyle(
                                      color: blackColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "LeagueSpartan",
                                    ),)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60,),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Select School",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            fontFamily: "LeagueSpartan",
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.warning_rounded,color: Colors.yellow,),
                            const SizedBox(width: 5,),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "Kindly choose a school in order to gain access to its available courses and have the ability to download associated course materials.",
                                  style: TextStyle(
                                    color: semiGreyColor,
                                    fontSize: 17,
                                    fontFamily: "LeagueSpartan",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 35,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                cubit.changeSchoolID(1);
                              });
                            },
                            child: Container(
                              width: screenWidth/2.2,
                              height: 60,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [BoxShadow(
                                  color: heavyGreyColor,
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 0)
                                )],
                                border: cubit.school == 1 ? Border.all(style: BorderStyle.solid,width: 2,color: ENGColor) : Border.all(style: BorderStyle.none)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset("assets/icons/ENG.png"),
                                      if(cubit.school == 1)
                                        CircleAvatar(
                                        backgroundColor: ENGColor,
                                        child: Icon(Icons.check, color: whiteColor,),
                                      ),
                                    ],
                                  ),
                                  Text("Engineering",
                                    style: TextStyle(
                                    color: blackColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "LeagueSpartan",
                                  ),)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    cubit.changeSchoolID(2);
                                  });
                                },
                                child: Container(
                                  width: screenWidth/2.2,
                                  height: 60,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [BoxShadow(
                                          color: heavyGreyColor,
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                          offset: const Offset(0, 0)
                                      )],
                                      border: cubit.school == 2 ? Border.all(style: BorderStyle.solid,width: 2,color: CSColor) : Border.all(style: BorderStyle.none)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset("assets/icons/CS.png"),
                                          if(cubit.school == 2)
                                            CircleAvatar(
                                              backgroundColor: CSColor,
                                              child: Icon(Icons.check, color: whiteColor,),
                                            ),
                                        ],
                                      ),
                                      Text("Computer \nScience",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: blackColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "LeagueSpartan",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    cubit.changeSchoolID(3);
                                  });
                                },
                                child: Container(
                                  width: screenWidth/2.2,
                                  height: 60,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [BoxShadow(
                                          color: heavyGreyColor,
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                          offset: const Offset(0, 0)
                                      )],
                                      border: cubit.school == 3 ? Border.all(style: BorderStyle.solid,width: 2,color: BTColor) : Border.all(style: BorderStyle.none)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset("assets/icons/BT.png"),
                                          if(cubit.school == 3)
                                            CircleAvatar(
                                              backgroundColor: BTColor,
                                              child: Icon(Icons.check, color: whiteColor,),
                                            ),
                                        ],
                                      ),
                                      Text("Biotechnology",
                                        style: TextStyle(
                                          color: blackColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "LeagueSpartan",
                                        ),)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15,),
                          InkWell(
                            onTap: (){
                              setState(() {
                                cubit.changeSchoolID(4);
                              });
                            },
                            child: Container(
                              width: screenWidth/2.2,
                              height: 60,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [BoxShadow(
                                      color: heavyGreyColor,
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                      offset: const Offset(0, 0)
                                  )],
                                  border: cubit.school == 4 ? Border.all(style: BorderStyle.solid,width: 2,color: BISColor) : Border.all(style: BorderStyle.none)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset("assets/icons/BIS.png"),
                                      if(cubit.school == 4)
                                        CircleAvatar(
                                          backgroundColor: BISColor,
                                          child: Icon(Icons.check, color: whiteColor,),
                                        ),
                                    ],
                                  ),
                                  Text("Business",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: blackColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "LeagueSpartan",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              bottomSheet: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ConditionalBuilder(
                  condition: state is! SignUpLoadingState,
                  builder: (context) => InkWell(
                    onTap: () {
                      if (cubit.school != 0 && cubit.gender != "") {
                        cubit.updateUserData();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                      }else{
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
                                      const Text("Please choose gender and school."),
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
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(
                            color: lightGreyColor,
                            blurRadius: 20,
                            spreadRadius: 5,
                            offset: const Offset(0, 4)
                        )],
                        color: cubit.gender != "" && cubit.school != 0 ? mainColor : heavyGreyColor,
                      ),
                      child: Center(
                        child: Text(
                          "Finish",
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              fontFamily: "LeagueSpartan"
                          ),
                        ),
                      ),
                    ),
                  ),
                  fallback: (context) => Center(child: CircularProgressIndicator(
                    color: mainColor,
                  ),),
                ),
              ),
            );
          }),
    );
  }
}
