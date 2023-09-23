import 'package:flutter/material.dart';
import 'package:food_campanion/features/users/presentation/widgets/saved_accounts_widget.dart';
import 'package:food_campanion/features/users/presentation/widgets/shadow_widget.dart';

class LocalLoginPage extends StatelessWidget {
  const LocalLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (ctx) {
          return Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'lib/core/assets/images/signup_images/photo6.jpg'),
                        fit: BoxFit.cover)),
              ),
              shadow(MediaQuery.of(ctx).size.height,
                  MediaQuery.of(ctx).size.width),
              Container(
                padding: const EdgeInsets.only(top: 200),
                child: const Text(
                  '              Saved Accounts',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'acme',
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 200),
                  child: const Center(child: SavedAccountsWidget()))
            ],
          );
        },
      ),
    );
  }
}
