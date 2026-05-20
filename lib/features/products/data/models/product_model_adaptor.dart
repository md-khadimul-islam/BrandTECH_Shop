import 'package:hive/hive.dart';

import 'product_model.dart';

class RatingModelAdapter extends TypeAdapter<RatingModel> {
  @override
  final int typeId = 0;

  @override
  RatingModel read(BinaryReader reader) {
    return RatingModel(
      rate: reader.readDouble(),
      count: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, RatingModel obj) {
    writer.writeDouble(obj.rate);
    writer.writeInt(obj.count);
  }
}

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 1;

  @override
  ProductModel read(BinaryReader reader) {
    return ProductModel(
      id: reader.readInt(),
      title: reader.readString(),
      price: reader.readDouble(),
      description: reader.readString(),
      category: reader.readString(),
      image: reader.readString(),
      rating: reader.read() as RatingModel,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeInt(obj.id)
      ..writeString(obj.title)
      ..writeDouble(obj.price)
      ..writeString(obj.description)
      ..writeString(obj.category)
      ..writeString(obj.image)
      ..write(obj.rating);
  }
}
