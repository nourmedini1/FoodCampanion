import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_campanion/core/widgets/loading_widget.dart';
import 'package:food_campanion/features/recipes/presentation/pages/bottom_navigation_page.dart';
import 'package:food_campanion/features/users/domain/entities/user_entity.dart';
import 'package:food_campanion/features/users/presentation/bloc/users_bloc/users_bloc.dart';

import 'package:food_campanion/features/users/utils/colors.dart';

class LocalLoginBottomSheetWidget extends StatefulWidget {
  final UserEntity userEntity;
  const LocalLoginBottomSheetWidget({super.key, required this.userEntity});

  @override
  State<LocalLoginBottomSheetWidget> createState() =>
      _LoginBottomSheetWidgetState();
}

class _LoginBottomSheetWidgetState extends State<LocalLoginBottomSheetWidget> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final passwordNode = FocusNode();
  dynamic isObscured;
  @override
  void initState() {
    super.initState();
    isObscured = true;
    passwordController.text = '';
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 60, right: 60, bottom: 20),
                  child: Text(
                    widget.userEntity.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'acme',
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 60, right: 60, bottom: 20),
                  child: Text(
                    widget.userEntity.email,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'mooli',
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(
              style: const TextStyle(
                  color: Colors.black87, fontFamily: 'mooli', fontSize: 20),
              controller: passwordController,
              focusNode: passwordNode,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 245, 235, 216),
                  filled: true,
                  suffixIcon: IconButton(
                    padding: const EdgeInsets.all(10),
                    icon: isObscured
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                  ),
                  suffixIconColor: Colors.orangeAccent,
                  prefixIcon: const Icon(FontAwesomeIcons.lock),
                  prefixIconColor: Colors.orangeAccent,
                  hintText: 'password',
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(66, 47, 46, 46),
                      fontFamily: 'mooli',
                      fontSize: 20),
                  focusColor: Colors.orange,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.orangeAccent,
                        width: 4,
                      )),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.black87,
                        width: 4,
                      ))),
              obscureText: isObscured,
              obscuringCharacter: '*',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  passwordNode.requestFocus();
                  return 'please enter your password';
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocConsumer<UsersBloc, UsersState>(
                  listener: (context, state) {
                    if (state is UsersErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          dismissDirection: DismissDirection.up,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 100,
                              left: 10,
                              right: 10),
                          duration: const Duration(seconds: 3),
                          content: Text(
                            state.errorMessage,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )));
                    } else if (state is UsersSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.lightGreen,
                          dismissDirection: DismissDirection.up,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 100,
                              left: 10,
                              right: 10),
                          duration: const Duration(seconds: 1),
                          content: Text(
                            state.successMessage,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavView()),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is UsersLoadingState) {
                      return const LoadingWidget();
                    } else if (state is UsersErrorState) {
                      return button(
                          'Login',
                          yellow,
                          orange,
                          () => login(
                              widget.userEntity, passwordController.text));
                    } else if (state is UsersSuccessState) {
                      return button(
                          'Login',
                          yellow,
                          orange,
                          () => login(
                              widget.userEntity, passwordController.text));
                    }
                    return button(
                        'Login',
                        yellow,
                        orange,
                        () =>
                            login(widget.userEntity, passwordController.text));
                  },
                ),
                const SizedBox(
                  width: 30,
                ),
                BlocConsumer<UsersBloc, UsersState>(
                  listener: (context, state) {
                    if (state is UsersDeleteErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          dismissDirection: DismissDirection.up,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 100,
                              left: 10,
                              right: 10),
                          duration: const Duration(seconds: 3),
                          content: Text(
                            state.errorMessage,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )));
                    } else if (state is UsersDeleteSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.lightGreen,
                          dismissDirection: DismissDirection.up,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height - 100,
                              left: 10,
                              right: 10),
                          duration: const Duration(seconds: 3),
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
                    } else if (state is UsersDeleteErrorState) {
                      return button('Delete', yellow, orange,
                          () => delete(widget.userEntity));
                    } else if (state is UsersDeleteSuccessState) {
                      return button('delete', yellow, orange,
                          () => delete(widget.userEntity));
                    }
                    return button('delete', yellow, orange,
                        () => delete(widget.userEntity));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  login(UserEntity userEntity, String password) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<UsersBloc>(context).add(
          UsersLocalLoginEvent(password: password, userEntity: userEntity));
    }
  }

  delete(UserEntity userEntity) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<UsersBloc>(context)
          .add(UsersDeleteUserEvent(userEntity: userEntity));
    }
  }

  Widget button(
      String label, Color color1, Color color2, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 120,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: const Color(0xff1D1617).withOpacity(0.07),
                  offset: const Offset(0, 10),
                  blurRadius: 4,
                  spreadRadius: 0)
            ],
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(colors: [color1, color2])),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'mooli',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
