import 'package:equatable/equatable.dart';

class RecipeEntity extends Equatable {
  final String uri;
  final String label;
  final String image;
  final Images images;
  final String source;
  final String url;
  final String shareAs;
  final int recipeYield;
  final List<String> dietLabels;
  final List<String> healthLabels;
  final List<String> cautions;
  final List<String> ingredientLines;
  final List<Ingredient> ingredients;
  final int calories;
  final int glycemicIndex;
  final int totalCo2Emissions;
  final int totalWeight;
  final List<String> cuisineType;
  final List<String> mealType;
  final List<String> dishType;
  final List<String> instructions;
  final List<String> tags;
  final String externalId;
  final List<Digest> digest;

  const RecipeEntity({
    required this.uri,
    required this.label,
    required this.image,
    required this.images,
    required this.source,
    required this.url,
    required this.shareAs,
    required this.recipeYield,
    required this.dietLabels,
    required this.healthLabels,
    required this.cautions,
    required this.ingredientLines,
    required this.ingredients,
    required this.calories,
    required this.glycemicIndex,
    required this.totalCo2Emissions,
    required this.totalWeight,
    required this.cuisineType,
    required this.mealType,
    required this.dishType,
    required this.instructions,
    required this.tags,
    required this.externalId,
    required this.digest,
  });

  @override
  List<Object?> get props => [
        uri,
        label,
        image,
        images,
        source,
        url,
        shareAs,
        recipeYield,
        dietLabels,
        healthLabels,
        cautions,
        ingredientLines,
        ingredients,
        calories,
        glycemicIndex,
        totalCo2Emissions,
        totalWeight,
        cuisineType,
        mealType,
        dishType,
        instructions,
        tags,
        externalId,
        digest
      ];
}

class Digest extends Equatable {
  final String label;
  final String tag;
  final int total;
  final bool hasRdi;
  final int daily;
  final String unit;

  const Digest({
    required this.label,
    required this.tag,
    required this.total,
    required this.hasRdi,
    required this.daily,
    required this.unit,
  });

  @override
  List<Object?> get props => [label, tag, total, hasRdi, daily, unit];
}

class Images extends Equatable {
  final Image thumbnail;
  final Image small;
  final Image regular;
  final Image large;

  const Images({
    required this.thumbnail,
    required this.small,
    required this.regular,
    required this.large,
  });

  @override
  List<Object?> get props => [thumbnail, small, regular, large];
}

class Image extends Equatable {
  final String url;
  final int width;
  final int height;

  const Image({
    required this.url,
    required this.width,
    required this.height,
  });

  @override
  List<Object?> get props => [url, width, height];
}

class Ingredient extends Equatable {
  final String text;
  final int quantity;
  final String measure;
  final String food;
  final int weight;

  const Ingredient({
    required this.text,
    required this.quantity,
    required this.measure,
    required this.food,
    required this.weight,
  });

  @override
  List<Object?> get props => [text, quantity, measure, food, weight];
}
