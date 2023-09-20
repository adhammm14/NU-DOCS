import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nu_sources/shared/app_cubit/app_cubit.dart';
import 'package:nu_sources/shared/app_cubit/app_states.dart';
import 'package:nu_sources/shared/styles/colors.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(context),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            body: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        cubit.setData();
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: ENGColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: CSColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
