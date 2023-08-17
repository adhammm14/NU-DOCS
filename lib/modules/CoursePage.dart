import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nu_sources/shared/styles/colors.dart';

import '../shared/components/components.dart';
import '../shared/styles/icon_broken.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: blackColor,
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(IconBroken.Search, color: blackColor,size: 27,)
          ),
          IconButton(
              onPressed: (){},
              icon: Icon(IconBroken.Heart, color: blackColor,size: 27,)
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                SvgPicture.asset(
                  "assets/icons/folder.svg",
                  width: screenWidth/2,
                  color: ENGColor.withOpacity(0.8),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Engineering Core",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: whiteColor,
                          ),
                        ),
                        SizedBox(height: 3,),
                        Text(
                          "MATH301: Linear Algebra",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: whiteColor,
                          ),
                        ),
                        SizedBox(height: 30,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Text("Files",style: TextStyle(color: blackColor,fontSize: 23,fontFamily: "LeagueSpartan"),),
              ],
            ),
            SizedBox(height: 15,),
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
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15))
                              ),
                              child: Center(
                                child: SvgPicture.asset("assets/icons/file.svg",width: 60,color: ENGColor.withOpacity(0.7)),
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
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
