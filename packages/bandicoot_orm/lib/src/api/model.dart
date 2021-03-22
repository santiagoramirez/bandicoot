abstract class Model<T> {
  T toModel(Map<String, dynamic> values);

  Map<String, dynamic> toRow();
}
