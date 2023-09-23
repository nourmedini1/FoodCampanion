import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/injection_container/injection_container.dart';
import 'package:food_campanion/core/widgets/custom_error_widget.dart';
import 'package:food_campanion/core/widgets/loading_widget.dart';

import 'package:food_campanion/features/users/domain/entities/user_entity.dart';
import 'package:food_campanion/features/users/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:food_campanion/features/users/presentation/widgets/local_login_bottom_sheet.dart';

class SavedAccountsWidget extends StatelessWidget {
  const SavedAccountsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Center(
          child: BlocProvider(
            create: (context) =>
                sl<UsersBloc>()..add(UsersGetSavedUsersEvent()),
            child: BlocBuilder<UsersBloc, UsersState>(
              builder: (context, state) {
                if (state is UsersLoadingState) {
                  return const LoadingWidget();
                } else if (state is UsersLoadedState) {
                  return RefreshIndicator(
                    color: Colors.orange,
                    onRefresh: () => refreshSavedAccounts(context),
                    child: savedAccountsList(state.userEntities, ctx),
                  );
                } else if (state is UsersErrorState) {
                  return customErrorWidget(state.errorMessage);
                }
                return const LoadingWidget();
              },
            ),
          ),
        ),
      );
    });
  }

  Widget savedAccountsList(List<UserEntity> accounts, BuildContext ctx) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                displayBottomSheet(ctx, context, accounts[index]);
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 15, left: 20, right: 20),
                child: Container(
                  width: 200,
                  height: 80,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xff1D1617).withOpacity(0.07),
                            offset: const Offset(0, 10),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: Color.fromARGB(255, 235, 233, 233),
                      borderRadius: BorderRadius.circular(45)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Icon(
                        Icons.person_2,
                        color: Colors.orange,
                        size: 50,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(accounts[index].username,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'mooli',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text(accounts[index].email,
                              style: const TextStyle(
                                  fontSize: 19,
                                  fontFamily: 'mooli',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
          itemCount: accounts.length),
    );
  }

  PersistentBottomSheetController<void> displayBottomSheet(
      BuildContext ctx, BuildContext context, UserEntity userEntity) {
    return showBottomSheet(
        shape: const RoundedRectangleBorder(
            side: BorderSide(style: BorderStyle.solid),
            borderRadius: BorderRadius.vertical(top: Radius.circular(36))),
        context: ctx,
        builder: (context) => Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(36)),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff1D1617).withOpacity(0.07),
                      offset: const Offset(0, 10),
                      blurRadius: 4,
                      spreadRadius: 0)
                ],
                image: const DecorationImage(
                    image: AssetImage(
                        'lib/core/assets/images/signup_images/table.jpg'),
                    fit: BoxFit.fill),
              ),
              child: LocalLoginBottomSheetWidget(userEntity: userEntity),
            ));
  }
}

Future<void> refreshSavedAccounts(BuildContext context) async {
  return BlocProvider.of<UsersBloc>(context).add(UsersGetSavedUsersEvent());
}
