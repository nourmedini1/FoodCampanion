import 'dart:ui';

class CategoryEntity {
  final Color bgColor;
  final String icon;
  final String name;
  CategoryEntity(
      {required this.bgColor, required this.icon, required this.name});

  static List<CategoryEntity> getCategories() {
    return [
      CategoryEntity(
          bgColor: const Color.fromARGB(0, 94, 237, 237),
          icon: 'lib/core/assets/icons/juice.svg',
          name: 'juice'),
      CategoryEntity(
          bgColor: const Color.fromARGB(0, 198, 127, 229),
          icon: 'lib/core/assets/icons/pancakes.svg',
          name: 'pancakes'),
      CategoryEntity(
          bgColor: const Color.fromARGB(0, 130, 233, 158),
          icon: 'lib/core/assets/icons/salad.svg',
          name: 'salad'),
      CategoryEntity(
          bgColor: const Color.fromARGB(0, 234, 229, 127),
          icon: 'lib/core/assets/icons/cheese.svg',
          name: 'cheese'),
      CategoryEntity(
          bgColor: const Color.fromARGB(0, 232, 193, 160),
          icon: 'lib/core/assets/icons/rice.svg',
          name: 'rice'),
      CategoryEntity(
          bgColor: const Color.fromARGB(0, 184, 126, 172),
          icon: 'lib/core/assets/icons/chicken.svg',
          name: 'chicken'),
      CategoryEntity(
          bgColor: const Color.fromARGB(0, 139, 238, 157),
          icon: 'lib/core/assets/icons/pasta.svg',
          name: 'pasta'),
      CategoryEntity(
          bgColor: const Color.fromARGB(0, 234, 186, 156),
          icon: 'lib/core/assets/icons/meat.svg',
          name: 'meat'),
      CategoryEntity(
          bgColor: const Color.fromARGB(0, 179, 80, 117),
          icon: 'lib/core/assets/icons/seafood.svg',
          name: 'seafood'),
      CategoryEntity(
          bgColor: const Color.fromARGB(0, 151, 237, 94),
          icon: 'lib/core/assets/icons/cake.svg',
          name: 'cake'),
      CategoryEntity(
          bgColor: const Color.fromARGB(0, 239, 181, 181),
          icon: 'lib/core/assets/icons/cupcake.svg',
          name: 'cupcake'),
      CategoryEntity(
          bgColor: const Color.fromARGB(0, 198, 132, 239),
          icon: 'lib/core/assets/icons/eggs.svg',
          name: 'eggs'),
      CategoryEntity(
          bgColor: const Color.fromARGB(0, 94, 237, 187),
          icon: 'lib/core/assets/icons/sausage.svg',
          name: 'sausage'),
    ];
  }
}
