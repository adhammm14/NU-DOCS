import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nu_sources/modules/login_pages/select_page.dart';
import '../../modules/login_Pages/login_page.dart';
import '../../shared/login_cubit/login_cubit.dart';
import '../../shared/login_cubit/login_states.dart';

import '../../shared/styles/colors.dart';
class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfirmController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(context),
      child: BlocConsumer<LoginCubit,LoginStates>(
          listener: (context,state){},
          builder: (context,state){
            LoginCubit cubit = LoginCubit.get(context);
            var screenWidth = MediaQuery.of(context).size.width;
            return Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Set up your profile",
                              style: TextStyle(
                                  color: blackColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 33,
                                  fontFamily: "LeagueSpartan"
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "Create Account to connect \nwith your friends",
                              style: TextStyle(
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
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
                                          "Your name will appear to other users.",
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
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: nameController,
                                cursorColor: semiGreyColor,
                                decoration: InputDecoration(
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                      color: semiGreyColor,
                                      fontSize: 18,
                                      fontFamily: "LeagueSpartan"
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1,
                                      color: semiGreyColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1,
                                      color: semiGreyColor,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1,
                                      color: errorColor,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      RegExp(r'[0-9!@#$%^&*+=/?]').hasMatch(value)) {
                                    return "Please Enter Valid Name";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
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
                                          "Please enter your NU email.",
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
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: emailController,
                                cursorColor: semiGreyColor,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: semiGreyColor,
                                      fontSize: 18,
                                      fontFamily: "LeagueSpartan"
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1,
                                      color: semiGreyColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1,
                                      color: semiGreyColor,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1,
                                      color: errorColor,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'^[^@]+@nu\.edu\.eg$')
                                          .hasMatch(value)) {
                                    return "Please Enter Valid Email";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: passController,
                                cursorColor: semiGreyColor,
                                obscureText: cubit.hidden,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: semiGreyColor,
                                      fontSize: 18,
                                      fontFamily: "LeagueSpartan"
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1,
                                      color: semiGreyColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1,
                                      color: semiGreyColor,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1,
                                      color: errorColor,
                                    ),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: InkWell(
                                      onTap: () {
                                        cubit.changeHidden();
                                      },
                                      child: cubit.hidden
                                          ? SvgPicture.asset(
                                        "assets/icons/eye-closed.svg",
                                      )
                                          : SvgPicture.asset(
                                        "assets/icons/eye-opened.svg",
                                      ),
                                    ),
                                  ),
                                  suffixIconConstraints: const BoxConstraints(
                                      minWidth: 35,
                                      maxHeight: 40,
                                      minHeight: 35,
                                      maxWidth: 40),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 8) {
                                    return "Please Enter More than 8 Characters";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: passConfirmController,
                                cursorColor: semiGreyColor,
                                obscureText: cubit.hidden,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  hintStyle: TextStyle(
                                      color: semiGreyColor,
                                      fontSize: 18,
                                      fontFamily: "LeagueSpartan"
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1,
                                      color: semiGreyColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1,
                                      color: semiGreyColor,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1,
                                      color: errorColor,
                                    ),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: InkWell(
                                      onTap: () {
                                        cubit.changeHidden();
                                      },
                                      child: cubit.hidden
                                          ? SvgPicture.asset(
                                        "assets/icons/eye-closed.svg",
                                      )
                                          : SvgPicture.asset(
                                        "assets/icons/eye-opened.svg",
                                      ),
                                    ),
                                  ),
                                  suffixIconConstraints: const BoxConstraints(
                                      minWidth: 35,
                                      maxHeight: 40,
                                      minHeight: 35,
                                      maxWidth: 40),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 8 || value != passController.text) {
                                    return "Password not matched!";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ConditionalBuilder(
                                condition: state is! SignUpLoadingState,
                                builder: (context) => InkWell(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.registerAccount(nameController, emailController, passController);
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectPage()));
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: mainColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Continue",
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "have an account?",
                                    style: TextStyle(
                                        color: blackColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => LoginPage())
                                        );
                                      },
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: mainColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}