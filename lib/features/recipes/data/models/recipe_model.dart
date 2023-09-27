import 'package:food_campanion/features/recipes/domain/entities/recipe_entity.dart';

class RecipeModel extends RecipeEntity {
  const RecipeModel(
      {required super.uri,
      required super.label,
      required super.image,
      required super.images,
      required super.source,
      required super.url,
      required super.shareAs,
      required super.recipeYield,
      required super.dietLabels,
      required super.healthLabels,
      required super.cautions,
      required super.ingredientLines,
      required super.ingredients,
      required super.calories,
      required super.glycemicIndex,
      required super.totalCo2Emissions,
      required super.totalWeight,
      required super.cuisineType,
      required super.mealType,
      required super.dishType,
      required super.instructions,
      required super.tags,
      required super.externalId,
      required super.digest});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
        uri: json['uri'],
        label: json['label'],
        image: json['image'],
        images: ImagesModel.fromJson(json['images']),
        source: json['source'],
        url: json['url'],
        shareAs: json['shareAs'],
        recipeYield: json['yield'],
        dietLabels: json['dietLabels'],
        healthLabels: json['healthLabels'],
        cautions: json['cautions'],
        ingredientLines: json['ingredientLines'],
        ingredients: json['ingredients']
            .map<IngredientModel>(
                (ingredient) => IngredientModel.fromJson(ingredient))
            .toList(),
        calories: json['calories'],
        glycemicIndex: json['glycemicIndex'],
        totalCo2Emissions: json['totalCo2Emissions'],
        totalWeight: json['totalWeight'],
        cuisineType: json['cuisineType'],
        mealType: json['mealType'],
        dishType: json['dishType'],
        instructions: json['instructions'],
        tags: json['tags'],
        externalId: json['externalId'],
        digest: json['digest']
            .map<DigestModel>((jsonDigest) => DigestModel.fromJson(jsonDigest))
            .toList());
  }
  factory RecipeModel.fromEntity(RecipeEntity recipeEntity) {
    return RecipeModel(
        uri: recipeEntity.uri,
        label: recipeEntity.label,
        image: recipeEntity.image,
        images: ImagesModel.fromEntity(recipeEntity.images),
        source: recipeEntity.source,
        url: recipeEntity.url,
        shareAs: recipeEntity.shareAs,
        recipeYield: recipeEntity.recipeYield,
        dietLabels: recipeEntity.dietLabels,
        healthLabels: recipeEntity.healthLabels,
        cautions: recipeEntity.cautions,
        ingredientLines: recipeEntity.ingredientLines,
        ingredients: recipeEntity.ingredients
            .map<IngredientModel>(
                (ingredient) => IngredientModel.fromEntity(ingredient))
            .toList(),
        calories: recipeEntity.calories,
        glycemicIndex: recipeEntity.glycemicIndex,
        totalCo2Emissions: recipeEntity.totalCo2Emissions,
        totalWeight: recipeEntity.totalWeight,
        cuisineType: recipeEntity.cuisineType,
        mealType: recipeEntity.mealType,
        dishType: recipeEntity.dishType,
        instructions: recipeEntity.instructions,
        tags: recipeEntity.tags,
        externalId: recipeEntity.externalId,
        digest: recipeEntity.digest
            .map<DigestModel>((digest) => DigestModel.fromEntity(digest))
            .toList());
  }
  Map<String, dynamic> toJson() {
    return {
      'uri': uri,
      'label': label,
      'image': image,
      'images': ImagesModel.fromEntity(images).toJson(),
      'source': source,
      'url': url,
      'shareAs': shareAs,
      'yield': recipeYield,
      'dietLabels': dietLabels,
      'healthLabels': healthLabels,
      "cautions": cautions,
      "ingredientLines": ingredientLines,
      "ingredients": ingredients
          .map<Map<String, dynamic>>(
              (ingredient) => IngredientModel.fromEntity(ingredient).toJson())
          .toList(),
      "calories": calories,
      "glycemicIndex": glycemicIndex,
      "totalCo2Emissions": totalCo2Emissions,
      "totalweight": totalWeight,
      "cuisinetype": cuisineType,
      "mealtype": mealType,
      "dishType": dishType,
      "instructions": instructions,
      "tags": tags,
      "externalid": externalId,
      "digest": digest
          .map<Map<String, dynamic>>(
              (digest) => DigestModel.fromEntity(digest).toJson())
          .toList()
    };
  }
}

class DigestModel extends Digest {
  const DigestModel(
      {required super.label,
      required super.tag,
      required super.total,
      required super.hasRdi,
      required super.daily,
      required super.unit});
  factory DigestModel.fromJson(Map<String, dynamic> jsonDigest) {
    return DigestModel(
        label: jsonDigest['label'],
        tag: jsonDigest['tag'],
        total: jsonDigest['total'],
        hasRdi: jsonDigest['hasRdi'],
        daily: jsonDigest['daily'],
        unit: jsonDigest['unit']);
  }
  factory DigestModel.fromEntity(Digest digest) {
    return DigestModel(
        label: digest.label,
        tag: digest.tag,
        total: digest.total,
        hasRdi: digest.hasRdi,
        daily: digest.daily,
        unit: digest.unit);
  }
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'tag': tag,
      'total': total,
      'hasRDI': hasRdi,
      'daily': daily,
      'unit': unit
    };
  }
}

class ImagesModel extends Images {
  const ImagesModel(
      {required super.thumbnail,
      required super.small,
      required super.regular,
      required super.large});
  factory ImagesModel.fromJson(Map<String, dynamic> jsonImages) {
    return ImagesModel(
        thumbnail: ImageModel.fromJson(jsonImages['THUMBNAIL']),
        small: ImageModel.fromJson(jsonImages['SMALL']),
        regular: ImageModel.fromJson(jsonImages['REGULAR']),
        large: ImageModel.fromJson(jsonImages['LARGE']));
  }
  factory ImagesModel.fromEntity(Images images) {
    return ImagesModel(
        thumbnail: ImageModel.fromEntity(images.thumbnail),
        small: ImageModel.fromEntity(images.small),
        regular: ImageModel.fromEntity(images.regular),
        large: ImageModel.fromEntity(images.large));
  }
  Map<String, dynamic> toJson() {
    return {
      'THUMBNAIL': ImageModel.fromEntity(thumbnail).toJson(),
      'SMALL': ImageModel.fromEntity(small).toJson(),
      'REGULAR': ImageModel.fromEntity(regular).toJson(),
      'LARGE': ImageModel.fromEntity(large).toJson()
    };
  }
}

class ImageModel extends Image {
  const ImageModel(
      {required super.url, required super.width, required super.height});
  factory ImageModel.fromJson(Map<String, dynamic> jsonImage) {
    return ImageModel(
        url: jsonImage['url'],
        width: jsonImage['width'],
        height: jsonImage['height']);
  }
  Map<String, dynamic> toJson() {
    return {'url': url, 'width': width, 'height': height};
  }

  factory ImageModel.fromEntity(Image image) {
    return ImageModel(url: image.url, width: image.width, height: image.height);
  }
}

class IngredientModel extends Ingredient {
  const IngredientModel(
      {required super.text,
      required super.quantity,
      required super.measure,
      required super.food,
      required super.weight});
  factory IngredientModel.fromJson(Map<String, dynamic> jsonIngredient) {
    return IngredientModel(
        text: jsonIngredient['text'],
        quantity: jsonIngredient['quantity'],
        measure: jsonIngredient['measure'],
        food: jsonIngredient['food'],
        weight: jsonIngredient['weight']);
  }
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'quantity': quantity,
      'measure': measure,
      "food": food
    };
  }

  factory IngredientModel.fromEntity(Ingredient ingredient) {
    return IngredientModel(
        text: ingredient.text,
        quantity: ingredient.quantity,
        measure: ingredient.measure,
        food: ingredient.food,
        weight: ingredient.weight);
  }
}
