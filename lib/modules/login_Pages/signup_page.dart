import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../modules/login_Pages/login_page.dart';
import '../../shared/login_cubit/login_cubit.dart';
import '../../shared/login_cubit/login_states.dart';

import '../../shared/styles/colors.dart';
class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
                          Image.asset(
                            "assets/images/BG.jpg",
                            width: double.infinity,
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
                              top: 170,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Create Account",
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 40),
                                  ),
                                  Text(
                                    "Create Account to connect \nwith your friends",
                                    style: TextStyle(
                                      color: whiteColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                    ),
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
                          children: [
                            TextFormField(
                              controller: nameController,
                              cursorColor: Colors.grey.withOpacity(0.8),
                              decoration: InputDecoration(
                                labelText: "Name",
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
                                    RegExp(r'[0-9!@#$%^&*+=/?]').hasMatch(value)) {
                                  return "Please Enter Valid Name";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: phoneController,
                              cursorColor: Colors.grey.withOpacity(0.8),
                              decoration: InputDecoration(
                                labelText: "Phone Number",
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
                                    !RegExp(r'^[0-9+]').hasMatch(value)) {
                                  return "Please Enter Valid Phone Number";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ConditionalBuilder(
                              condition: state is! SignUpLoadingState,
                              builder: (context) => InkWell(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.registerAccount(nameController, emailController, passController, phoneController);
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: ENGColor),
                                  child: Center(
                                    child: Text(
                                      "SignUp",
                                      style: TextStyle(
                                          color: blackColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              fallback: (context) => Center(child: CircularProgressIndicator(
                                color: ENGColor,
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
                                          color: ENGColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    )),
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