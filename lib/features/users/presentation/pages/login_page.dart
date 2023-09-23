import 'package:flutter/material.dart';
import 'package:food_campanion/features/users/presentation/pages/local_login_page.dart';
import 'package:food_campanion/features/users/presentation/pages/signup_page.dart';
import 'package:food_campanion/features/users/presentation/widgets/app_motto.dart';
import 'package:food_campanion/features/users/presentation/widgets/background_carousel_widget.dart';
import 'package:food_campanion/features/users/presentation/widgets/button.dart';
import 'package:food_campanion/features/users/presentation/widgets/login_bottom_sheet_widget.dart';
import 'package:food_campanion/features/users/presentation/widgets/shadow_widget.dart';
import 'package:food_campanion/features/users/utils/colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (ctx) {
      return Stack(children: [
        backgroundImages(ctx),
        shadow(MediaQuery.of(ctx).size.height, MediaQuery.of(ctx).size.width),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 340,
            ),
            appMotto(
                'You can count on us to deliver the recipe you desire.\nAlways your campanion'),
            const SizedBox(
              height: 30,
            ),
            button('Login', yellow, orange,
                () => _displayBottomSheet(ctx, context)),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'You dont have an account yet ?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            signUpTextButton(context)
          ],
        ),
        Positioned(bottom: 20, left: 20, child: loginFromSavedAccount(context))
      ]);
    }));
  }

  GestureDetector loginFromSavedAccount(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const LocalLoginPage(),
          )),
      child: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          'Login from a saved Account',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.orangeAccent,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  GestureDetector signUpTextButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SignUpPage(),
          )),
      child: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          'Sign up',
          style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  PersistentBottomSheetController<void> _displayBottomSheet(
      BuildContext ctx, BuildContext context) {
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
              child: const LoginBottomSheetWidget(),
            ));
  }
}
