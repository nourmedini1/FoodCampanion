import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/injection_container/injection_container.dart';
import 'package:food_campanion/core/widgets/loading_widget.dart';
import 'package:food_campanion/features/users/data/models/user_model.dart';
import 'package:food_campanion/features/users/domain/entities/user_entity.dart';
import 'package:food_campanion/features/users/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:food_campanion/features/users/utils/colors.dart';
import 'package:food_campanion/features/users/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModifyUsernameWidget extends StatefulWidget {
  const ModifyUsernameWidget({super.key});

  @override
  State<ModifyUsernameWidget> createState() => _ModifyUsernameWidgetState();
}

class _ModifyUsernameWidgetState extends State<ModifyUsernameWidget> {
  final GlobalKey formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final SharedPreferences sharedPreferences = sl<SharedPreferences>();
  final UserEntity user = UserModel.fromJson(
      json.decode(sl<SharedPreferences>().getString(CURRENT_USER)!));

  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    controller.text = user.username;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              '        FoodCampanion',
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 30,
                  fontFamily: 'acme',
                  fontWeight: FontWeight.w800),
            ),
          ),
          body: Center(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 60, bottom: 5, right: 10, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Username',
                          style: TextStyle(
                            color: Colors.orange,
                            fontFamily: 'acme',
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
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
                            controller: controller,
                            focusNode: focusNode,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                fillColor: Colors.white.withOpacity(0.4),
                                filled: true,
                                prefixIcon: const Icon(Icons.person),
                                prefixIconColor: Colors.orangeAccent,
                                hintText: 'username',
                                hintStyle: const TextStyle(
                                    color: Colors.black87,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                focusNode.requestFocus();
                                return 'please enter a username';
                              }
                              return null;
                            },
                          ),
                        ),
                        BlocConsumer<UsersBloc, UsersState>(
                          builder: (context, state) {
                            if (state is UsersLoadingState) {
                              return const LoadingWidget();
                            } else if (state is UsersErrorState) {
                              return confirm(context, controller.text);
                            } else if (state is UsersSuccessState) {
                              return confirm(context, controller.text);
                            }
                            return confirm(context, controller.text);
                          },
                          listener: (context, state) {
                            if (state is UsersErrorState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      dismissDirection: DismissDirection.up,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              150,
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.lightGreen,
                                      dismissDirection: DismissDirection.up,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              150,
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
                        )
                      ],
                    ),
                  )),
            ),
          )),
    );
  }

  Padding confirm(BuildContext context, String username) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          UserEntity userE = UserEntity(
              email: user.email,
              username: username,
              country: user.country,
              password: user.password,
              id: user.id);

          BlocProvider.of<UsersBloc>(context)
              .add(UsersUpdateUserEvent(userEntity: userE));
        },
        child: Container(
          height: 50,
          width: 300,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: orange,
            boxShadow: const [
              BoxShadow(
                offset: Offset(-2, -2),
                blurRadius: 5,
                color: Color.fromRGBO(0, 0, 0, 0.05),
              ),
              BoxShadow(
                offset: Offset(2, 2),
                blurRadius: 5,
                color: Color.fromRGBO(0, 0, 0, 0.10),
              )
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Center(
              child: Text(
                'Confirm',
                style: TextStyle(
                  fontFamily: 'mooli',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
