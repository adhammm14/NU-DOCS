import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../modules/login_Pages/signup_page.dart';
import '../../shared/styles/colors.dart';

import '../../shared/login_cubit/login_cubit.dart';
import '../../shared/login_cubit/login_states.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(context),
      child: BlocConsumer<LoginCubit,LoginStates>(
          listener: (context,state){},
          builder: (context,state){
            LoginCubit cubit = LoginCubit.get(context);
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Image.network(
                            "https://nu.edu.eg/sites/default/files/2022-09/slider-360.jpg",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            height: 300,
                            width: double.infinity,
                            decoration:
                            BoxDecoration(color: blackColor.withOpacity(0.35)),
                          ),
                          Positioned(
                              left: 20,
                              top: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sign in to your\nAccount",
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 40),
                                  ),
                                  Text(
                                    "Sign into your Account",
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextFormField(
                              controller: emailController,
                              cursorColor: Colors.grey.withOpacity(0.8),
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(
                                    color: Colors.grey.withOpacity(0.8), fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                  const BorderSide(style: BorderStyle.solid),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$')
                                        .hasMatch(value)) {
                                  return "Please Enter Valid Email";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: passController,
                              cursorColor: heavyGreyColor,
                              obscureText: cubit.hidden,
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle:
                                TextStyle(color: heavyGreyColor, fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                  const BorderSide(style: BorderStyle.solid),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 1,
                                      color: heavyGreyColor),
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
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: mainColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context) => InkWell(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.loginAccount(emailController, passController);
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: mainColor
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              fallback: (context) => Center(child: CircularProgressIndicator(
                                color: mainColor,
                              ),),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 1,
                                  width: 120,
                                  color: heavyGreyColor,
                                ),
                                const Text(
                                  "Or login with",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  height: 1,
                                  width: 120,
                                  color: heavyGreyColor,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              height: 65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: heavyGreyColor, width: 1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/google.svg",
                                    width: 25,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Google",
                                    style: TextStyle(
                                        color: blackColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
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
                                              builder: (context) => SignupPage()));
                                    },
                                    child: Text(
                                      "Create Account",
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
            );
          }
      ),
    );
  }
}