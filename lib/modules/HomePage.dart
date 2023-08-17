import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import 'CoursePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              Text("Recently Courses",style: TextStyle(color: blackColor,fontSize: 23,fontFamily: "LeagueSpartan"),),
              Expanded(
                flex: 1,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                      crossAxisSpacing: 10.0, // Spacing between columns
                    ),
                    itemCount: coursesColors.length,
                    itemBuilder: (BuildContext context,int index){
                      return Center(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CoursePage()));
                          },
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/folder.svg",
                                width: screenWidth/2.4,
                                color: coursesColors[index].withOpacity(0.8),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        coursesCores[index],
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
                                        coursesCodes[index],
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
              const SizedBox(height: 10,),
              Text("New",style: TextStyle(color: blackColor,fontSize: 23,fontFamily: "LeagueSpartan"),),
              Expanded(
                flex: 2,
                child: ListView.builder(
                    itemCount: colors.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
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
                                decoration: BoxDecoration(
                                    gradient: RadialGradient(colors: [
                                      colors[index],
                                      colors[index].withOpacity(0.75)
                                    ]),
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15))
                                ),
                                child: Center(child: Text(code[index],style: TextStyle(color: whiteColor,fontSize: 12, fontWeight: FontWeight.w700),)),
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
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
