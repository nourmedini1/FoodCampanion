import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_campanion/core/widgets/loading_widget.dart';
import 'package:food_campanion/features/recipes/presentation/pages/bottom_navigation_page.dart';
import 'package:food_campanion/features/users/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:food_campanion/features/users/presentation/widgets/button.dart';
import 'package:food_campanion/features/users/utils/colors.dart';

class LoginBottomSheetWidget extends StatefulWidget {
  const LoginBottomSheetWidget({super.key});

  @override
  State<LoginBottomSheetWidget> createState() => _LoginBottomSheetWidgetState();
}

class _LoginBottomSheetWidgetState extends State<LoginBottomSheetWidget> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final passwordNode = FocusNode();
  final emailNode = FocusNode();
  dynamic isObscured;
  @override
  void initState() {
    super.initState();
    isObscured = true;
    passwordController.text = '';
    emailController.text = '';
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
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
            const Padding(
              padding: EdgeInsets.only(left: 60, right: 60, bottom: 20),
              child: Text(
                'FoodCampanion',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'acme',
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            TextFormField(
              style: const TextStyle(
                  color: Colors.black87, fontFamily: 'mooli', fontSize: 20),
              controller: emailController,
              focusNode: emailNode,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 245, 235, 216),
                  filled: true,
                  prefixIcon: const Icon(FontAwesomeIcons.person),
                  prefixIconColor: Colors.orangeAccent,
                  hintText: 'email',
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(66, 47, 46, 46),
                      fontFamily: 'mooli',
                      fontSize: 16),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  emailNode.requestFocus();
                  return 'please enter an email';
                }
                return null;
              },
            ),
            TextFormField(
              style: const TextStyle(
                  color: Colors.black87, fontFamily: 'mooli', fontSize: 16),
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
                      fontSize: 16),
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
                            fontWeight: FontWeight.w500, color: Colors.white),
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
                            fontWeight: FontWeight.w500, color: Colors.white),
                      )));
                  Navigator.pushReplacement(
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
                      () =>
                          login(emailController.text, passwordController.text));
                } else if (state is UsersSuccessState) {
                  return button(
                      'Login',
                      yellow,
                      orange,
                      () =>
                          login(emailController.text, passwordController.text));
                }
                return button('Login', yellow, orange,
                    () => login(emailController.text, passwordController.text));
              },
            )
          ],
        ),
      ),
    );
  }

  login(String email, String password) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<UsersBloc>(context)
          .add(UsersRemoteLoginEvent(email: email, password: password));
    }
  }
}
