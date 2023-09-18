import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_campanion/core/widgets/loading_widget.dart';
import 'package:food_campanion/features/users/domain/entities/user_entity.dart';
import 'package:food_campanion/features/users/presentation/bloc/users_bloc/users_bloc.dart';

import 'package:food_campanion/features/users/presentation/widgets/button.dart';
import 'package:food_campanion/features/users/utils/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var passObscured, confirmPassObscured;
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final countryController = TextEditingController();
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final countryFocusNode = FocusNode();

  @override
  void initState() {
    passObscured = true;
    confirmPassObscured = true;
    emailController.text = '';
    usernameController.text = '';
    passwordController.text = '';
    countryController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (ctx) {
        return Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'lib/core/assets/images/signup_images/photo5.jpg'),
                      fit: BoxFit.cover),
                )),
            shadow(
                MediaQuery.of(ctx).size.height, MediaQuery.of(ctx).size.width),
            Center(
              child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height,
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 40, bottom: 30, right: 10, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Positioned(
                                left: 80,
                                right: 80,
                                top: 80,
                                bottom: 120,
                                child: Text(
                                  'FoodCampanion\n           SignUp',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'acme',
                                    fontSize: 35,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30, bottom: 10, left: 10, right: 10),
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'mooli',
                                      fontSize: 20),
                                  controller: emailController,
                                  focusNode: emailFocusNode,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.4),
                                      filled: true,
                                      prefixIcon: const Icon(Icons.person),
                                      prefixIconColor: Colors.orangeAccent,
                                      hintText: 'email',
                                      hintStyle: const TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'mooli',
                                          fontSize: 20),
                                      focusColor: Colors.orange,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 4,
                                          )),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.black87,
                                            width: 4,
                                          ))),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      emailFocusNode.requestFocus();
                                      return 'please enter an email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'mooli',
                                      fontSize: 20),
                                  controller: passwordController,
                                  focusNode: passwordFocusNode,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.4),
                                      filled: true,
                                      suffixIcon: IconButton(
                                        padding: const EdgeInsets.all(10),
                                        icon: passObscured
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            passObscured = !passObscured;
                                          });
                                        },
                                      ),
                                      suffixIconColor: Colors.orangeAccent,
                                      prefixIcon:
                                          const Icon(FontAwesomeIcons.lock),
                                      prefixIconColor: Colors.orangeAccent,
                                      hintText: 'password',
                                      hintStyle: const TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'mooli',
                                          fontSize: 20),
                                      focusColor: Colors.orange,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 4,
                                          )),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.black87,
                                            width: 4,
                                          ))),
                                  obscureText: passObscured,
                                  obscuringCharacter: '*',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      passwordFocusNode.requestFocus();
                                      return 'please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'mooli',
                                      fontSize: 20),
                                  controller: confirmPasswordController,
                                  focusNode: confirmPasswordFocusNode,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.4),
                                      filled: true,
                                      suffixIcon: IconButton(
                                        padding: const EdgeInsets.all(10),
                                        icon: confirmPassObscured
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            confirmPassObscured =
                                                !confirmPassObscured;
                                          });
                                        },
                                      ),
                                      suffixIconColor: Colors.orangeAccent,
                                      prefixIcon:
                                          const Icon(FontAwesomeIcons.lock),
                                      prefixIconColor: Colors.orangeAccent,
                                      hintText: 'confirm password',
                                      hintStyle: const TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'mooli',
                                          fontSize: 20),
                                      focusColor: Colors.orange,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 4,
                                          )),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.black87,
                                            width: 4,
                                          ))),
                                  obscureText: confirmPassObscured,
                                  obscuringCharacter: '*',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      confirmPasswordFocusNode.requestFocus();
                                      return 'please confirm your password';
                                    } else if (value !=
                                        passwordController.text) {
                                      return 'Does not match the password';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'mooli',
                                      fontSize: 20),
                                  controller: usernameController,
                                  focusNode: usernameFocusNode,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.4),
                                      filled: true,
                                      prefixIcon:
                                          const Icon(FontAwesomeIcons.user),
                                      prefixIconColor: Colors.orangeAccent,
                                      hintText: 'usename',
                                      hintStyle: const TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'mooli',
                                          fontSize: 20),
                                      focusColor: Colors.orange,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 4,
                                          )),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.black87,
                                            width: 4,
                                          ))),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      usernameFocusNode.requestFocus();
                                      return 'please enter a usename';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'mooli',
                                      fontSize: 20),
                                  controller: countryController,
                                  focusNode: countryFocusNode,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(0.4),
                                      filled: true,
                                      prefixIcon:
                                          const Icon(FontAwesomeIcons.globe),
                                      prefixIconColor: Colors.orangeAccent,
                                      hintText: 'country',
                                      hintStyle: const TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'mooli',
                                          fontSize: 20),
                                      focusColor: Colors.orange,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 4,
                                          )),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                            color: Colors.black87,
                                            width: 4,
                                          ))),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      countryFocusNode.requestFocus();
                                      return 'please enter a country';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: BlocConsumer<UsersBloc, UsersState>(
                                  listener: (context, state) {
                                    if (state is UsersErrorState) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.red,
                                              dismissDirection:
                                                  DismissDirection.up,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .height -
                                                      100,
                                                  left: 10,
                                                  right: 10),
                                              duration:
                                                  const Duration(seconds: 3),
                                              content: Text(
                                                state.errorMessage,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              )));
                                    } else if (state is UsersSuccessState) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  Colors.lightGreen,
                                              dismissDirection:
                                                  DismissDirection.up,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .height -
                                                      100,
                                                  left: 10,
                                                  right: 10),
                                              duration:
                                                  const Duration(seconds: 3),
                                              content: Text(
                                                state.successMessage,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              )));
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is UsersLoadingState) {
                                      return const LoadingWidget();
                                    } else if (state is UsersErrorState) {
                                      return button(
                                          'SignUp',
                                          yellow,
                                          orange,
                                          () => signUp(
                                              emailController.text,
                                              usernameController.text,
                                              passwordController.text,
                                              countryController.text));
                                    } else if (state is UsersSuccessState) {
                                      return button('Signed Up', greenLight,
                                          greenDark, () => null);
                                    }
                                    return button(
                                        'SignUp',
                                        yellow,
                                        orange,
                                        () => signUp(
                                            emailController.text,
                                            usernameController.text,
                                            passwordController.text,
                                            countryController.text));
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            )
          ],
        );
      }),
    );
  }

  Container shadow(double height, double width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [transparent, black.withOpacity(0.99)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
    );
  }

  signUp(String email, String username, String password, String country) {
    if (formKey.currentState!.validate()) {
      final userEntity = UserEntity(
          email: email,
          username: username,
          country: country,
          password: password);
      BlocProvider.of<UsersBloc>(context)
          .add(UsersSignInEvent(userEntity: userEntity));
    }
  }
}
