import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_campanion/core/injection_container/injection_container.dart';
import 'package:food_campanion/features/recipes/domain/entities/event_entity.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/recipes_bloc/recipes_bloc.dart';

Widget events(List<EventEntity> events) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          height: 300,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: events.length,
              itemBuilder: ((context, index) {
                return Container(
                  width: 200,
                  margin: const EdgeInsets.only(left: 20, bottom: 20),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xff1D1617).withOpacity(0.07),
                            offset: const Offset(0, 10),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: events[index].bgColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(45)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        events[index].icon,
                        height: 80,
                        width: 60,
                      ),
                      Column(
                        children: [
                          Text(events[index].name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text(events[index].description),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => sl<RecipesBloc>(),
                                //    child: SearchResults(
                                //      item: events[index].name,
                                //       ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xff1D1617)
                                        .withOpacity(0.07),
                                    offset: const Offset(0, 10),
                                    blurRadius: 4,
                                    spreadRadius: 0)
                              ],
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(colors: [
                                Color.fromARGB(255, 209, 201, 145),
                                Color.fromARGB(255, 231, 162, 52)
                              ])),
                          child: const Text(
                            'View',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
              separatorBuilder: ((context, index) => const SizedBox(
                    width: 0,
                  )))),
    ],
  );
}
