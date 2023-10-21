import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_campanion/core/animation/delayed_display.dart';
import 'package:food_campanion/features/users/presentation/pages/modify_user_details.dart';

class AccountSettingsWidget extends StatelessWidget {
  const AccountSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(-2, -2),
              blurRadius: 12,
              color: Color.fromRGBO(0, 0, 0, 0.05),
            ),
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 5,
              color: Color.fromRGBO(0, 0, 0, 0.10),
            )
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            header(
                const Icon(
                  Icons.email_rounded,
                  color: Colors.orange,
                ),
                '  Change your email',
                context,
                'email'),
            const Divider(
              thickness: 2,
            ),
            header(
                const Icon(
                  Icons.password,
                  color: Colors.orange,
                ),
                '  Change your password',
                context,
                'password'),
            const Divider(
              thickness: 2,
            ),
            header(
                const Icon(
                  Icons.person,
                  color: Colors.orange,
                ),
                '  Change your username',
                context,
                'username'),
            const Divider(
              thickness: 2,
            ),
            header(
                const Icon(
                  Icons.location_city,
                  color: Colors.orange,
                ),
                '  Change your location',
                context,
                'country'),
          ],
        ));
  }

  header(Icon icon, String name, BuildContext context, String setting) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DelayedDisplay(delay: const Duration(microseconds: 600), child: icon),
          DelayedDisplay(
            delay: const Duration(microseconds: 600),
            child: Text(name,
                style: const TextStyle(
                  fontFamily: 'mooli',
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                )),
          ),
          DelayedDisplay(
            delay: const Duration(microseconds: 600),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserDetailsPage(toModify: setting),
                  ));
                },
                icon: const Icon(Icons.arrow_forward_sharp)),
          )
        ],
      ),
    );
  }
}
