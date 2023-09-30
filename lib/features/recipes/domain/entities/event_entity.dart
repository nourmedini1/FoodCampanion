import 'dart:ui';

class EventEntity {
  final Color bgColor;
  final String name;
  final String description;
  final String icon;

  const EventEntity(
      {required this.bgColor,
      required this.name,
      required this.description,
      required this.icon});
  static List<EventEntity> getEvents() {
    return [
      const EventEntity(
          bgColor: Color.fromARGB(0, 184, 161, 124),
          name: 'date night',
          icon: 'lib/core/assets/icons/date_night.svg',
          description: 'quick | easy | snacks'),
      const EventEntity(
          bgColor: Color.fromARGB(0, 205, 231, 176),
          icon: 'lib/core/assets/icons/wedding.svg',
          name: 'wedding',
          description: 'cake | dinner | classic'),
      const EventEntity(
          bgColor: Color.fromARGB(0, 171, 59, 241),
          icon: 'lib/core/assets/icons/ramadan.svg',
          name: 'ramadan',
          description: 'soup | spicy | full table'),
      const EventEntity(
          bgColor: Color.fromARGB(0, 171, 63, 128),
          name: 'christmas',
          icon: 'lib/core/assets/icons/christmas.svg',
          description: 'chicken | gathering | dinner'),
      const EventEntity(
          bgColor: Color.fromARGB(0, 224, 167, 114),
          icon: 'lib/core/assets/icons/kids.svg',
          name: 'kids',
          description: 'easy | energy | breakfast'),
    ];
  }
}
